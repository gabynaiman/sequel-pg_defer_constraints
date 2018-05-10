require 'coverage_helper'
require 'minitest/autorun'
require 'minitest/colorin'
require 'pry-nav'
require 'logger'
require 'sequel'
require 'sequel/extensions/pg_defer_constraints'

if RUBY_ENGINE == 'jruby'
  require 'jdbc/postgres'
else
  require 'pg'
end

adapter = RUBY_ENGINE == 'jruby' ? 'jdbc:postgresql' : 'postgres'

DB = Sequel.connect "#{adapter}://localhost/pg_defer_constraints_test?user=postgres&password=password"

DB.extension :pg_defer_constraints 

DB.drop_table? :people
DB.drop_table? :users

DB.create_table :users do
  primary_key :id
  String :name, null: false, unique: true
end

DB.create_table :people do
  String :document_number, null: false, primary_key: true
  String :first_name, null: false
  String :last_name, null: false
  Date :birth_date, null: false
  foreign_key :user_id, :users, null: false, deferrable: :immediate, unique: true
end

class Minitest::Test

  alias_method :__run__, :run

  def run(*args)
    DB.transaction(rollback: :always, savepoint: true) do
      __run__(*args)
    end
  end

end
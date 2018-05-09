require 'minitest_helper'

describe Sequel::Postgres::DeferConstraintsMethods do

  before do
    (1..5).each do |id|
      DB[:users].insert id: id , name: "user_#{id}"

      DB[:people].insert document_number: "#{id}",
                         first_name: "person_#{id}", 
                         last_name: 'test', 
                         birth_date: Time.at(0), 
                         user_id: id
    end
  end

  it 'Remove a parent entity and not the child must raise exception on commit deferring constraints' do
    proc do 
      DB.defer_constraints do 
        (1..5).each { |id| DB[:users].where(id: id.to_s).delete }
        DB[:users].count.must_equal 0
      end
    end.must_raise Sequel::ForeignKeyConstraintViolation
    DB[:users].count.must_equal 5
  end

  it 'Remove a parent entity and not the child must raise exception on statement execution not deferring constraints' do
    proc do 
      DB.transaction(savepoint: true) do
        (1..5).each { |id| DB[:users].where(id: id.to_s).delete }
      end
    end.must_raise Sequel::ForeignKeyConstraintViolation
    DB[:users].count.must_equal 5
  end


  it 'Removing parent childs and then the childs deferring constraints not raise exception and is OK' do
    DB.defer_constraints do 
      (1..5).each { |id| DB[:users].where(id: id.to_s).delete }
      DB[:users].count.must_equal 0

      (1..5).each { |id| DB[:people].where(document_number: id.to_s).delete }
      DB[:people].count.must_equal 0
    end

    DB[:users].count.must_equal 0
    DB[:people].count.must_equal 0
  end 

end
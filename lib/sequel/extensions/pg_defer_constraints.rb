module Sequel
  module Postgres
    module DeferConstraintsMethods

      def defer_constraints
        transaction(savepoint: true) do
          run 'SET CONSTRAINTS ALL DEFERRED'
          result = yield
          run 'SET CONSTRAINTS ALL IMMEDIATE'
          result
        end
      end

    end

    Database.register_extension(:pg_defer_constraints, Postgres::DeferConstraintsMethods)

  end
end




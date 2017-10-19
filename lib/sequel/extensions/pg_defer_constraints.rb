module Sequel
  module Postgres
    module DeferConstraintsMethods

      def defer_constraints(*schemas)
        schemas = ['public'] if schemas.empty?

        tables_by_schema = schemas.each_with_object({}) do |schema, h|
          h[schema] = self.from(Sequel[:information_schema][:tables])
                          .where(table_schema: schema, table_type: 'BASE TABLE')
                          .select_map(:table_name)
        end

        tables_by_schema.each do |schema, tables|
          tables.each { |t| run "ALTER TABLE \"#{schema}\".\"#{t}\" DISABLE TRIGGER ALL" }
        end

        yield

      ensure
        tables_by_schema.each do |schema, tables|
          tables.each { |t| run "ALTER TABLE \"#{schema}\".\"#{t}\" ENABLE TRIGGER ALL" }
        end
      end

    end

    Database.register_extension(:pg_defer_constraints, Postgres::DeferConstraintsMethods)
    
  end
end
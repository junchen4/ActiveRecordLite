require_relative 'db_connection'
require_relative '01_sql_object'

module Searchable
	def where(params)
		cols = params.keys
		vals = params.values

		conditions_str = cols.map{|col| "#{col} = ?"}.join(" AND ")
		found = DBConnection.execute(<<-SQL, vals)
			SELECT
			  *
			FROM 
			  #{self.table_name}
			WHERE
			  #{conditions_str}
		SQL
		found.map{|attr| self.new(attr)}
	end
end

class SQLObject
  extend Searchable
end

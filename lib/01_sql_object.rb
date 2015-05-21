require_relative 'db_connection'
require 'active_support/inflector'

class SQLObject
  def self.columns
    cols = DBConnection.execute2(<<-SQL)
      SELECT
        *
      FROM
        #{@table_name}
    SQL

    cols.first.map(&:to_sym)
  end

  def self.finalize!
    # cols = self.columns
    # cols.each do |name|
    #   define_method("#{name}=") do |arg| 
    #     attributes[name] = arg
    #   end

    #   define_method("#{name}") { attributes[name] }
    # end
  
  end

  def self.table_name=(table_name)
    @table_name = table_name
  end

  def self.table_name
    @table_name || @table_name = self.to_s.tableize
  end

  def self.all
    # attributes = DBConnection.execute(<<-SQL, @table_name)
    #   SELECT
    #     ?.*
    #   FROM
    #     ?
    # SQL

    #self.parse_all(attributes)
  end

  def self.parse_all(results)
    # objects = []
    # results.each do |result|
    #   objects << self.new(result)
    # end
    # objects
  end

  def self.find(id)
    # objects = self.all
    # objects.each do |obj|
    #   if obj.id == id 
    #     return obj
    #   end
    # end
  end

  def initialize(params = {})
    # cols = self.class.columns #Access class method ::columns
    # params.each do |k, v|
    #   if cols.include?(k.to_sym)
    #     self.class.send("#{k}=".to_sym, v)
    #   else
    #     raise ArgumentError.new('unknown attribute #{attr_name}') 
    #   end

    # end
  end

  def attributes
    # @attributes = {}
  end

  def attribute_values
    # attr_values = []
    # self.class.columns.map do |col|
    #   attr_values << self.class.send(#{col})
    # end
    # attr_values
  end

  def insert
    # col_names = self.class.columns.join(',')
    # question_marks = ["?"] * attributes.length
    # DBConnection.execute(<<-SQL,*attribute_values)
    #   INSERT INTO
    #     #{table_name}(#{col_names})
    #   VALUES
    #     #{question_marks}
    # SQL

    # DBConnection.last_insert_row_id
  end

  def update
    # set_cols = []
    # self.class.columns.map do |col|
    #   set_cols << "#{col} = ?" 
    # end
    # set_cols = set_cols.join(',')

    # DBConnection.execute(<<-SQL, *attribute_values, self.id)
    #   UPDATE
    #     #{table_name}
    #   SET
    #     #{set_cols}
    #   WHERE
    #     id = ?
    # SQL

  end

  def save
    # if self.id.nil?
    #   insert
    # else
    #   update
    # end
  end
end

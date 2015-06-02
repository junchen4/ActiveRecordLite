require_relative 'db_connection'
require 'active_support/inflector'

class SQLObject
  def self.columns
    @cols = DBConnection.execute2(<<-SQL)
      SELECT
        *
      FROM
        #{self.table_name}
    SQL

    @cols.first.map(&:to_sym)
  end

  def self.finalize!
    col_names = self.columns
    col_names.each do |col|
      puts col
      define_method(col.to_s + "=") do |arg| 
        self.attributes[col] = arg
      end

      define_method(col.to_s) { self.attributes[col] }
    end
  end

  def self.table_name=(table_name)
    @table_name = table_name
  end

  def self.table_name
    @table_name ||= self.to_s.tableize
  end

  def self.all
    results = DBConnection.execute(<<-SQL)
      SELECT
        *
      FROM
        #{self.table_name}
    SQL
    self.parse_all(results)
  end

  def self.parse_all(results)
    objects = []
    results.each do |attrs|
      objects << self.new(attrs)
    end
    objects
  end

  def self.find(id)
    objects = self.all
    objects.each do |obj|
      return obj if obj.attributes[:id] == id
    end
    nil #if not found
  end

  def initialize(params = {})
    cols = self.class.columns #Access class method ::columns
    params.each do |k, v|
      if cols.include?(k.to_sym)
        self.send("#{k}=", v)
      else
        raise "unknown attribute '#{k}'" 
      end
    end
  end

  def attributes
    @attributes ||= {}
  end

  def attribute_values
    return self.class.columns.map {|col| attributes[col]}
  end

  def insert
    col_names = self.class.columns.join(",")
    question_marks = (["?"] * self.class.columns.count).join(",")
    DBConnection.execute(<<-SQL, *attribute_values)
      INSERT INTO
        #{self.class.table_name} (#{col_names})
      VALUES
        (#{question_marks})
    SQL

    self.id = DBConnection.last_insert_row_id
  end

  def update
    set_cols = []
    self.class.columns.each do |col|
      set_cols << "#{col} = ?" 
    end
    set_cols = set_cols.join(",")

    DBConnection.execute(<<-SQL, *attribute_values, self.id)
      UPDATE
        #{self.class.table_name}
      SET
        #{set_cols}
      WHERE
        id = ?
    SQL
  end

  def save
    if self.id.nil?
      self.insert
    else
      self.update
    end
  end
end

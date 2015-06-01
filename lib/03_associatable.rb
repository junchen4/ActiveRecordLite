require_relative '02_searchable'
require 'active_support/inflector'

class AssocOptions
  attr_accessor(
    :foreign_key,
    :class_name,
    :primary_key
  )

  def model_class
    @class_name.constantize
  end

  def table_name
    self.model_class.table_name
  end
end

class BelongsToOptions < AssocOptions
  def initialize(name, options = {})
    @foreign_key = options[:foreign_key] || "#{name}_id".to_sym
    @primary_key = options[:primary_key] || :id 
    @class_name = options[:class_name] || name.to_s.camelcase
  end
end

class HasManyOptions < AssocOptions
  def initialize(name, self_class_name, options = {})
    @foreign_key = options[:foreign_key] || "#{self_class_name.underscore}_id".to_sym
    @primary_key = options[:primary_key] || :id 
    @class_name = options[:class_name] || name.to_s.singularize.camelcase
  end
end

module Associatable #continued in 04_associatable2.rb
  def belongs_to(name, options = {})
    options = BelongsToOptions.new(name, options)
    assoc_options[name] = options
    define_method(name) do
      foreign = options.foreign_key.to_sym
      model_class = options.model_class
      primary = options.primary_key
      model_class.where(primary.to_sym => self.send(foreign)).first
    end
  end

  def has_many(name, options = {})
    options = HasManyOptions.new(name, self.to_s, options)

    define_method(name) do
      primary = options.primary_key.to_sym
      foreign = options.foreign_key
      model_class = options.model_class
      model_class.where(foreign => self.send(primary))
    end
  end

  def assoc_options
    @assoc_options ||= {}
  end
end

class SQLObject
  extend Associatable
end

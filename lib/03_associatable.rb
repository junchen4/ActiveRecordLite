require_relative '02_searchable'
require 'active_support/inflector'

# Phase IIIa
class AssocOptions
  attr_accessor(
    :foreign_key,
    :class_name,
    :primary_key
  )

  def model_class
    # class_name.constantize
  end

  def table_name
    # class_name.downcase.pluralize
  end
end

class BelongsToOptions < AssocOptions
  def initialize(name, options = {})
    # if options[:foreign_key]
    #   foreign_key = options[:foreign_key]
    # else
    #   foreign_key = (name + "_id").to_sym
    # end

    # if options[:primary_key]
    #   primary_key = options[:primary_key]
    # else 
    #   primary_key = :id 
    # end

    # if options[:class_name]
    #   class_name = options[:class_name]
    # else
    #   class_name = name.capitalize
    # end
  end
end

class HasManyOptions < AssocOptions
  def initialize(name, self_class_name, options = {})
    # if options[:foreign_key]
    #   foreign_key = options[:foreign_key]
    # else
    #   foreign_key = (self_class_name.downcase + "_id").to_sym
    # end

    # if options[:primary_key]
    #   primary_key = options[:primary_key]
    # else 
    #   primary_key = :id 
    # end

    # if options[:class_name]
    #   class_name = options[:class_name]
    # else
    #   class_name = name.singularize.capitalize
    # end  
  end
end

module Associatable
  # Phase IIIb
  def belongs_to(name, options = {})
    # options = new BelongsToOptions(name, options)
    # assoc_options[name] = options
    # define_method(name.to_s) {
    #   foreign_key = self.send(options.foreign_key).first
    #   model_class = options.model_class
    #   model_class.where({options.primary_key => foreign_key})
    # }
  end

  def has_many(name, options = {})
    # options = new HasManyOptions(name, self, options)

    # define_method(name.to_s) {
    #   foreign_key = self.send(options.foreign_key).first
    #   foreign_key = options.send("foreign_key")
    #   model_class = options.model_class
    #   model_class.where({options.primary_key => foreign_key})
    # }  
  end

  def assoc_options
    # @assoc_options ||= {}
  end
end

class SQLObject
  extend Associatable
end

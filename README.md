Active Record Lite
============

Active Record Lite is a light ruby framework clone of ActiveRecord's basic functionality, used commonly in Ruby on Rails. It is built in Ruby, and makes use of Ruby metaprogramming.

* The superclass SQLObject provides Ruby methods for interacting with a SQL database. Each subclass represents a SQL table; each subclass instance represents a row in the table. The table name is achieved by pluralizing the class name using the active_support/inflector library.

* Each subclass provides instance methods for each of the columns in the represented table for accessing the values of a given row. The #save method updates or inserts a row as appropriate.

Modules are mixed in to extend the SQLObject superclass. The Searchable module provides a #where method that mimics WHERE statements in SQL. Furthermore, the Associatable module provides the functionality of belongs_to, has_many, and has_one_through relations.




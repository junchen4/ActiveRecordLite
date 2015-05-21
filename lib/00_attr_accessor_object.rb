class AttrAccessorObject
  def self.my_attr_accessor(*names)
  	#define setter/getter methods using define_method
  	names.each do |name|
		define_method("#{name}=") do |arg| 
			instance_variable_set(:"@#{name}", arg)
		end

		define_method("#{name}") { instance_variable_get(:"@#{name}") }
  	end
  end
end

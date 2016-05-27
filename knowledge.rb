class Module
  def attribute(name, &block)
    name, value = name.first if name.is_a?(Hash)
    create_attribute(name, value, &block)
  end

  def create_attribute(name, value = nil, &block)
    define_method(name.to_s) do
      unless instance_variable_defined?(:"@#{name}")
        instance_variable_set(:"@#{name}", block_given? ? instance_eval(&block) : value)
      end
      instance_variable_get(:"@#{name}")
    end

    define_method("#{name}=") do |val|
      instance_variable_set(:"@#{name}", val)
    end

    define_method("#{name}?") do
      return false if instance_variable_get(:"@#{name}").nil?
      instance_variable_defined?(:"@#{name}")
    end
  end
end

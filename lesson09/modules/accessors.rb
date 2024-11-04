module Accessors
  def attr_accessor_with_history(*names_arr)
    names_arr.each do |name|
      define_method(name) { instance_variable_get("@#{name}") }

      define_method("#{name}=") do |value|
        instance_variable_set("@#{name}", value)
        
        history = instance_variable_get("@#{name}_history") || []
        history << value
        instance_variable_set("@#{name}_history", history)
      end

      define_method("#{name}_history") do
        instance_variable_get("@#{name}_history") || []
      end
    end
  end

  def strong_attr_accessor(name, cl)
    define_method(name) { instance_variable_get("@#{name}") }

    define_method("#{name}=") do |value|
      unless value.is_a?(cl)
        raise TypeError, "Неверный тип данных: ожидался #{cl}, получен #{value.class}"
      end

      instance_variable_set("@#{name}", value)
    end
  end
end

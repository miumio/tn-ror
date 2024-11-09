module Validation
  def self.included(base)
    base.extend ClassMethods
    base.include InstanceMethods
  end

  module ClassMethods
    def validate(name, type, option = nil)
      name_hash = { name: name, type: type, option: option }
      instance_variable_set('@validations', (instance_variable_get('@validations') || []) << name_hash)
    end

    def validations
      if superclass.respond_to?(:validations)
        superclass.validations + (@validations || [])
      else
        @validations || []
      end
    end
  end

  module InstanceMethods
    def validate!
      self.class.validations.each do |validation|
        attribute = instance_variable_get("@#{validation[:name]}")
        case validation[:type]
        when :presence
          unless attribute && !attribute.to_s.strip.empty?
            raise "#{validation[:name]} must be present."
          end
        when :format
          regex = validation[:option]
          unless attribute =~ regex
            raise "#{validation[:name]} has invalid format."
          end
        when :type
          expected_class = validation[:option]
          unless attribute.is_a?(expected_class)
            raise "#{validation[:name]} must be of type #{expected_class}."
          end
        else
          raise "Unknown validation type: #{validation[:type]}"
        end
      end
      true
    end

    def valid?
      validate!
      true
    rescue RuntimeError
      false
    end
  end
end

	
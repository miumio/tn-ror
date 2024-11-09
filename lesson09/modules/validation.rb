module Validation
  def self.included(base)
    base.extend ClassMethods
    base.include InstanceMethods
  end

  module ClassMethods
    def validate(name, type, option = nil)
      @validations ||= []
      @validations << { attribute: name, type: type, option: option }
    end

    def validations
      @validations
    end
  end

  module InstanceMethods
    def validate!
      self.class.validations.each do |validation|
        attribute = instance_variable_get("@#{validation[:attribute]}")
        case validation[:type]
        when :presence
          unless attribute && !attribute.to_s.strip.empty?
            raise "#{validation[:attribute]} must be present."
          end
        when :format
          regex = validation[:option]
          unless attribute =~ regex
            raise "#{validation[:attribute]} has invalid format."
          end
        when :type
          expected_class = validation[:option]
          unless attribute.is_a?(expected_class)
            raise "#{validation[:attribute]} must be of type #{expected_class}."
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
    rescue
      false
    end
  end
end

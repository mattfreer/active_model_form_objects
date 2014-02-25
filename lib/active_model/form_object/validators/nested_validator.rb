module ActiveModel
  module FormObject
   module Validators
      class NestedValidator < ActiveModel::EachValidator
        def validate_each(record, attribute, value)

          if !value.nil? && record.send(attribute).invalid?
            record.send(attribute).errors.each do |k, v|
              record.errors[k] ||= []
              record.errors[k] << v
            end
          end
        end
      end
    end
  end
end

module ActiveModel
  module FormObject
   module Validators
      class PermittedParamsValidator < ActiveModel::EachValidator
        def validate_each(record, attribute, value)
          if record.send(attribute).present?
            each_unpermitted_attr(record.unpermitted_attrs) do |value|
              add_error(record, attribute, value)
            end
          end
        end

        private

        def each_unpermitted_attr(unpermitted_attrs, &b)
          if unpermitted_attrs.any?
            unpermitted_attrs.each do |key, value|
              value.each do |a|
                b.call(a)
              end
            end
          end
        end

        def add_error(record, key, attr)
          record.errors[key] ||= []
          record.errors[key] << "#{attr} is not permitted"
        end
      end
    end
  end
end

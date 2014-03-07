module ActiveModel
  module FormObject
    require_relative "form_object/railtie" if defined?(Rails)
    require_relative 'form_object/validators/nested_validator'
    require_relative 'form_object/strong_parameters'

    def self.included klass
      klass.class_eval do
        extend Naming
        include Conversion
        include Validations
        include Validations::Callbacks
        include Validators
        include StrongParameters
        extend ClassMethods
        include InstanceMethods
      end
    end

    module ClassMethods
      def new(*args, &block)
        args = [{}] if args == []
        create_accessors(*args)
        allocate_and_init(*args, &block)
      end

      def model_name
        ActiveModel::Name.new(self, nil, self.name.split(/(?=[A-Z])/).first)
      end

      private

      def create_accessors(*args)
        if args.first.present?
          args.first.each do |key, value|
            self.send(:attr_accessor, key)
          end
        end
      end

      def allocate_and_init(*args, &block)
        obj = allocate
        obj.send(:initialize, *args, &block)

        if args.first.present?
          args.first.each do |key, value|
            obj.instance_variable_set("@#{key}".to_sym, value)
          end
        end
        obj
      end
    end

    module InstanceMethods
      def initialize(*args)
      end

      def persisted?
        false
      end

      def save
        if valid?
          persist!
          true
        else
          false
        end
      end

      private
      def persist!
      end
    end
  end
end

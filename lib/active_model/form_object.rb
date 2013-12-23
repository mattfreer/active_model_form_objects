module ActiveModel
  module FormObject
    require_relative "form_object/railtie" if defined?(Rails)

    def self.included klass
      klass.class_eval do
        include Base
      end
    end
  end
end

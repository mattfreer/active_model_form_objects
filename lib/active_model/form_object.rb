module ActiveModel
  module FormObject

    def self.included klass
      klass.class_eval do
        extend Naming
        include Conversion
        include Validations
      end
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

require 'simple_settings/version'

module SimpleSettings
  class SettingSerializer
    ALLOWED_VALUE_TYPES = [Fixnum, String, Float, TrueClass, FalseClass]

    class SettingTypeNotAllowed < TypeError; end

    class << self
      def load(value)
        YAML.load(value) if value
      end

      def dump(value)
        if ALLOWED_VALUE_TYPES.any? { |t| value.is_a?(t) }
          YAML.dump(value)
        else
          raise SettingTypeNotAllowed, "Setting values of type #{value.class} not allowed"
        end
      end
    end
  end

  class Settings < ActiveRecord::Base
    self.table_name = 'settings'
    
    validates :key, uniqueness: true

    serialize :value, SettingSerializer

    class << self
      def write(key, value)
        setting = find_or_initialize_by(key: key)
        setting.value = value
        setting.save
      end

      def read(key)
        setting = find_by(key: key)

        setting.value if setting
      end
    end
  end
end

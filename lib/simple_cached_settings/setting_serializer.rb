module SimpleCachedSettings
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
end

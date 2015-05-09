module SimpleCachedSettings
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
        value = Rails.cache.read(__cache_key(key))
        return value if value

        setting = find_by(key: key)
        setting.value if setting
      end

      def __cache_key(setting_key)
        "simple_settings:#{setting_key}"
      end
    end

    after_commit :update_cache, on: [:create, :update]
    def update_cache
      Rails.cache.write(self.class.__cache_key(key), value)
    end

    after_commit :expire_cache, on: [:destroy]
    def expire_cache
      Rails.cache.delete(self.class.__cache_key(key))
    end
  end
end

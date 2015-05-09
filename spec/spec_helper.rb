require 'rubygems'
require 'active_record'
require 'active_support'
require 'sqlite3'
require 'database_cleaner'

$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'rails'))
require 'simple_settings'

ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: ':memory:')
ActiveRecord::Schema.verbose = false
ActiveRecord::Schema.define(version: 1) do
  create_table :settings do |t|
    t.string :key, null: false
    t.text :value
    t.timestamps null: false
  end
end

class ::MySettings < SimpleSettings::Settings
  self.table_name = 'settings'
end

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.around(:each) do |example|
    DatabaseCleaner.cleaning do
      example.run
    end
  end

  config.before(:all) do
    # Rails.cache.clear
  end

  # config.after(:all) do
  #   Object.send(:remove_const, :Setting)
  # end
end

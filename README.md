[![Gem Version](https://badge.fury.io/rb/simple_cached_settings.svg)](http://badge.fury.io/rb/simple_cached_settings)
# Simple Cached Settings

Gem for storing global configuration settings in an ActiveRecord::Model.

## Installation

Add this line to your application's Gemfile:

    gem 'simple_cached_settings'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install simple_cached_settings

## Setup

Generate settings model and migration:

    $ rails g simple_cached_settings <settings_name>

Apply migration:
    
    $ rake db:migrate

Now you have the model that looks something like this:

```ruby
class MySettings < SimpleCachedSettings::Settings
end
```

## Usage

```ruby
MySettings.write(:foo, 'bar')

MySettings.read(:foo)
=> 'bar'
```

It's possible to store settings values of four types: String, Integer, Float and Boolean

## Contributing

1. Fork it ( https://github.com/[my-github-username]/settings/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

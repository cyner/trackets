# Trackets [![Build Status](https://travis-ci.org/sensible/trackets-ruby.svg?branch=master)](https://travis-ci.org/sensible/trackets-ruby) [![Code Climate](https://codeclimate.com/github/sensible/trackets-ruby.png)](https://codeclimate.com/github/sensible/trackets-ruby)

WIP gem for Trackets.com service

## Installation

Add this line to your application's Gemfile:

    gem 'trackets'

And then execute:

    $ bundle

## Usage

In order to setup Trackets for Ruby, you need to first find your API
key. To do this simply [open up your project](https://trackets.com/projects)
on Trackets, go to settings and copy the API key.

    $ rails g trackets:install YOUR_API_KEY
    $ rake trackets:test # To send testing exception

## JavaScript

If you wish to enable JavaScript error tracking, you can do so using a
helper which this gem provides. Simply include the following snippet in
your `app/views/layout/application.html.erb` in the `<head>` tag
directly above your application JavaScript.

```erb
<%= trackets_include_tag %>
<%= javascript_include_tag "application", "data-turbolinks-track" => true %>
```

### Configuration

Can be found in `config/initializers/trackets.rb`

```ruby
Trackets.setup do |config|
  config.api_key = "ebf6d706b29ca4e176012a3dc3b017a8" # API key for your Project
  config.async = true # [Default: false] Send notification in a separate thread (Uses Sucker Punch gem)
end
```

## Rack

Here's a sample `config.ru`

```ruby
require 'rack'
require 'trackets'

Trackets.setup do |config|
  config.api_key = "insert-valid-api-key"
end

app = Rack::Builder.app do
  run lambda { |env| raise "Testing Error" }
end

use Trackets::Middleware::RackExceptionHandler
run app
```

## Rake tasks

Currently there is only one rake task for testing the setup by sending
an exception to Trackets. You can do this simply by invoking `rake
trackets:notify` in your application after you've installed the gem.

    $ rake trackets:notify MESSAGE="Custom message from Rake"

## Contributing

1. Fork it ( https://github.com/[my-github-username]/trackets/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

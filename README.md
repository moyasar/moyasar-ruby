# This project has been archived and is no longer maintained.

# moyasar-ruby

[![Gem Version](https://badge.fury.io/rb/moyasar.svg)](http://badge.fury.io/rb/moyasar)
[![Build Status](https://travis-ci.org/moyasar/moyasar-ruby.svg?branch=master)](https://travis-ci.org/moyasar/moyasar-ruby)


Moyasar Ruby language wrapper

## Documentation

See the [Ruby API docs](https://moyasar.com/docs/api/?ruby).

## Requirements

* Ruby 2.1 or above.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'moyasar'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install moyasar

## Usage

``` ruby
require "moyasar"
Moyasar.api_key = "sk_test_..."

# list payments
Moyasar::Payment.list()

# fetch single payment
Moyasar::Payment.fetch("760878ec-d1d3-5f72-9056-191683f55872")

# create an invoice
Moyasar::Invoice.create(amount: 2500, currency: 'SAR', description: 'Monthly subscription')
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).


## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/moyasar. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).


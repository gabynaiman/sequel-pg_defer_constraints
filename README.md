# Sequel::Postgres::DeferConstraints

[![Gem Version](https://badge.fury.io/rb/sequel-pg_defer_constraints.svg)](https://rubygems.org/gems/sequel-pg_defer_constraints)
[![Build Status](https://travis-ci.org/gabynaiman/sequel-pg_defer_constraints.svg?branch=master)](https://travis-ci.org/gabynaiman/sequel-pg_defer_constraints)
[![Coverage Status](https://coveralls.io/repos/github/gabynaiman/sequel-pg_defer_constraints/badge.svg?branch=master)](https://coveralls.io/github/gabynaiman/sequel-pg_defer_constraints?branch=master)
[![Code Climate](https://codeclimate.com/github/gabynaiman/sequel-pg_defer_constraints.svg)](https://codeclimate.com/github/gabynaiman/sequel-pg_defer_constraints)
[![Dependency Status](https://gemnasium.com/gabynaiman/sequel-pg_defer_constraints.svg)](https://gemnasium.com/gabynaiman/sequel-pg_defer_constraints)

Disable and enable PG constraints

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'sequel-pg_defer_constraints'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install sequel-pg_defer_constraints

## Usage

```ruby
db = Sequel.connect ...

db.extension :pg_defer_constraints

db.defer_constraints do
  ...
end
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/gabynaiman/sequel-pg_defer_constraints.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

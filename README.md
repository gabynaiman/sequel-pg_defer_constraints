# Sequel::Postgres::DeferConstraints

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

db.defer_constraints :public, :custom_schema do
  ...
end
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/gabynaiman/sequel-pg_defer_constraints.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

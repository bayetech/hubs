# Hubs

hubs is a WeChat moment clone gem focus mobile only, inspired from [homeland](https://github.com/rails-engine/homeland) gem a lot, but it's having more feature:

* topic category
* post topic with image
* topic can reply
* user can like/unlike topic
* user can following/unfollowing


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'hubs'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install hubs

## Usage

```
rails g hub:install
```

it will mount the hub to routes and add hubs.rb in initializers folder.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/bayetech/hubs. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).


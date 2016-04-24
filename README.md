# EasyMailchimp

Easy Mailchimp Ruby library.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'EasyMailchimp'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install EasyMailchimp

## Usage

This gem is so simple its API is currently limited to,

* `EasyMailchimp#create_member` &mdash; takes the list ID as a string, followed
  by a Hash (see below for list of expected keys).
* `EasyMailchimp#get_list_name` &mdash; takes the list ID as a string.

```ruby
require 'easy_mailchimp'

mailchimp = ::EasyMailchimp::Base.new
mailchimp.create_member('<Your Mailchimp List ID goes here>', {
  email: 'tim.cook@apple.com',
  first_name: 'Tim',
  last_name: 'Cook'
})
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

Bug reports and pull requests are welcome on GitHub at https://github.com/bsodmike/easy_mailchimp.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).


# OmniAuth::Procore

This is the official OmniAuth strategy for authenticating to Procore. To
use it, you'll need to sign up for an OAuth2 Application ID and Secret
on the [Procore Applications Page](https://developers.procore.com/developers).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'omniauth-procore'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install omniauth-procore

## Usage

```ruby
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :procore, ENV['PROCORE_KEY'], ENV['PROCORE_SECRET']
end
```

With a different Procore environment (e.g. sandbox):

```ruby
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :procore, ENV['PROCORE_KEY'], ENV['PROCORE_SECRET'],
  client_options: {
    site: 'https://sandbox.procore.com',
    api_site: 'https://sandbox.procore.com',
  },
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/procore/omniauth-procore. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


# MonoMerchant

The "mono-merchant" gem simplifies [Monobank API](https://api.monobank.ua/docs/acquiring.html) usage in Ruby applications.

## Installation

Install the gem and add to the application's Gemfile by executing:

```bash
bundle add "mono-merchant"
```

If bundler is not being used to manage dependencies, install the gem by executing:

```ruby
gem install "mono-merchant"
```

## Usage

Add API token to the environment variable:

```bash
# .env
MONOBANK_API_TOKEN=your_api_token
```

#### You can get the API token depending on the environment:

Development: [https://api.monobank.ua/](https://api.monobank.ua/)

Production: [https://fop.monobank.ua/](https://fop.monobank.ua/)

### Create invoice request

```ruby

amount = 100 # in cents
MonoMerchant::Invoice::Create.new(amount) # see other params in code comments 

```

### Verify webhook transaction

```ruby

request_to_validate = MonoMerchant::WebhookValidator.new(request)
request_to_validate.valid?

```

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/okliv/mono-merchant.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
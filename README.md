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

### Verify webhook transaction

```ruby

request_to_validate = MonoMerchant::WebhookValidator.new(request)
request_to_validate.valid?

```

### Create invoice request

```ruby

amount = 100 # in cents
MonoMerchant::Invoice::Create.new(amount) # see other params in code comments 

```

### Other methods

```ruby

# Invoice
MonoMerchant::Invoice::Status.new(invoice_id) # check status
MonoMerchant::Invoice::Cancel.new(invoice_id) # cancel successful payment
MonoMerchant::Invoice::Remove.new(invoice_id) # invalidate created invoice 
MonoMerchant::Invoice::Finalize.new(invoice_id, amount, items: []) # finalize holding amount with possibility to modify it 
MonoMerchant::Invoice::FiscalChecks.new(invoice_id) # get fiscal check(s) 

# QR
MonoMerchant::Qr::List.new # list QR cash-boxes
MonoMerchant::Qr::Details.new(qr_id) # get QR details
MonoMerchant::Qr::ResetAmount.new(qr_id) # reset/remove payment

# Submerchant
MonoMerchant::Submerchant::List.new # get list of submerchants

# Wallet
MonoMerchant::Wallet::List.new(wallet_id)
MonoMerchant::Wallet::Card.new(card_token) # delete card token
MonoMerchant::Wallet::Payment.new(card_token, amount) # see other attributes directly in code

# Merchant
MonoMerchant::Details.new # basic info about merchant: Id, Name, edrpou
MonoMerchant::Statement.new(from: 1649329978, to: 1649329978) # get bank account statement for defined period. from & to are utc unix timestamps

```

## TODO

- [credentials payment](https://api.monobank.ua/docs/acquiring.html#/paths/~1api~1merchant~1invoice~1payment-direct/post)
- better Readme
- minor todos (noticed directly in code)

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/okliv/mono-merchant.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
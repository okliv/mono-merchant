module MonoMerchant
  module Wallet

    # Create payment for card token
    # todo DRY it with Invoice::Create
    class Payment < ApiRequest

      attr_reader :card_token, :amount, :currency, :initiation_kind, :customer_emails, :items, :destination, :comment, :reference, :redirect_url, :webhook_url

      def initialize(card_token, amount, currency = DEFAULT_CURRENCY, by_client: false, items: [], reference: nil, redirect_url: nil, webhook_url: nil, email: nil, destination: nil, comment: nil)
        @card_token = card_token
        @amount = convert_to_cents(amount)
        @destination = destination
        @reference = reference
        @comment = comment
        @customer_emails = [email] if email
        @redirect_url = redirect_url
        @webhook_url = webhook_url
        @currency = Money::Currency.new(currency)
        # todo: append barcode, uktzed, tax, discounts etc.
        @items = items.map { |i| Invoice::Item.new(i).to_hash.presence }
        @initiation_kind = by_client ? 'client' : 'merchant'
        super()
      end

      protected

      delegate :iso_numeric, to: :currency, prefix: true
      alias_method :ccy, :currency_iso_numeric

      def body
        {
          ccy: ccy.to_i,
          amount: amount,
          initiationKind: initiation_kind,
          redirectUrl: redirect_url,
          webHookUrl: webhook_url,
          merchantPaymInfo: {
            basketOrder: items.presence,
            reference: reference,
            comment: comment,
            destination: destination,
            customerEmails: customer_emails
          }.compact
        }
      end

      def data
        %w[invoiceId tdsUrl status failureReason amount ccy createdDate modifiedDate]
      end

    end
  end
end


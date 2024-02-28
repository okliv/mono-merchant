# frozen_string_literal: true

module MonoMerchant
  module Invoice
    # Create invoice
    class Create < ApiRequest
      attr_reader :amount, :currency, :payment_type, :customer_emails, :items, :destination, :reference, :redirect_url, :webhook_url

      # @param [BigDecimal,Integer] amount (cents) to request payment
      # @param [String] destination - additional info about payment
      # @param [String] reference - bill number or other reference
      # @param [String] currency - currency iso code
      # @param [Boolean] hold - if payment type is 'hold' (default: 'debit')
      # @param [String] email - client email
      # @param [Array] items - cart content
      # @param [String] redirect_url - url where user will be redirected after payment
      # @param [String] webhook_url - url where Monobank will send webhook after payment
      def initialize(amount, destination: nil, reference: nil, currency: DEFAULT_CURRENCY, hold: false, email: nil, items: [], redirect_url: nil, webhook_url: nil)
        super()
        @amount = convert_to_cents(amount)
        @destination = destination
        @reference = reference
        @currency = Money::Currency.new(currency)
        @payment_type = hold ? 'hold' : 'debit'
        @customer_emails = [email] if email
        @items = items.map { |i| Item.new(i).to_hash }
        @redirect_url = redirect_url
        @webhook_url = webhook_url
      end

      protected

      delegate :iso_numeric, to: :currency, prefix: true
      alias_method :ccy, :currency_iso_numeric
      def body
        {
          ccy: ccy.to_i,
          amount: amount,
          paymentType: payment_type,
          redirectUrl: redirect_url,
          webHookUrl: webhook_url,
          basketOrder: items,
          merchantPaymInfo: {
            reference: reference,
            destination: destination,
            customerEmails: customer_emails
          }.compact
        }
      end

      def data
        %w[pageUrl invoiceId]
      end

    end
  end
end

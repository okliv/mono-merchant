# frozen_string_literal: true

module MonoMerchant
  module Invoice
    # Create invoice
    class Create < ApiRequest
      attr_reader :amount, :currency, :payment_type, :customer_emails, :items, :destination, :comment, :reference, :redirect_url, :webhook_url

      # @param [BigDecimal,Integer] amount (cents) to request payment
      # @param [String] destination - additional info about payment
      # @param [String] reference - bill number or other reference
      # @param [String] comment - internal service info
      # @param [String] currency - currency iso code
      # @param [Boolean] hold - if payment type is 'hold' (default: 'debit')
      # @param [String] email - client email
      # @param [Array] items - cart content
      # @param [String] redirect_url - url where user will be redirected after payment
      # @param [String] webhook_url - url where Monobank will send webhook after payment
      def initialize(amount, currency: DEFAULT_CURRENCY, items: [], hold: false, reference: nil, redirect_url: nil, webhook_url: nil, email: nil, destination: nil, comment: nil)
        @amount = convert_to_cents(amount)
        @destination = destination
        @reference = reference
        @comment = comment
        @customer_emails = [email] if email
        @redirect_url = redirect_url
        @webhook_url = webhook_url
        @currency = Money::Currency.new(currency)
        @items = items.map { |i| Item.new(i).to_hash.presence }
        @payment_type = hold ? 'hold' : 'debit'
        super()
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
        %w[pageUrl invoiceId]
      end

    end
  end
end

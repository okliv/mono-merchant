# frozen_string_literal: true

module MonoMerchant
  module Invoice

    # Finalize holding amount
    class Finalize < ApiRequest
      attr_reader :invoice_id, :amount, :items

      def initialize(invoice_id, amount, items: [])
        super()
        @invoice_id = invoice_id
        @amount = amount
        @items = items.map { |i| Item.new(i).to_hash }
      end

      protected

      def body
        { invoiceId: invoice_id,
          amount: amount,
          items: items.presence
        }
      end

      def data
        %w[status]
      end
    end
  end
end

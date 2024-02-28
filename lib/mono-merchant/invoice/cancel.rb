module MonoMerchant
  module Invoice

    # Cancel successful payment
    class Cancel < ApiRequest

      attr_reader :ext_ref, :invoice_id, :amount, :items

      def initialize(invoice_id, amount, ext_ref: nil, items: [])
        @invoice_id, @amount, @items, @ext_ref = invoice_id, amount, items, ext_ref
      end

      protected

      def body
        { invoiceId: invoice_id,
          amount: amount,
          extRef: ext_ref,
          items: items.presence
        }
      end
    end
  end
end


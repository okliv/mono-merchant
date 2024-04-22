module MonoMerchant
  module Invoice

    # Cancel successful payment
    class Cancel < ApiRequest

      attr_reader :ext_ref, :invoice_id, :amount, :items

      def initialize(invoice_id, amount = nil, ext_ref: nil, items: [])
        @invoice_id, @amount, @items, @ext_ref = invoice_id, amount, items, ext_ref
        super()
      end

      protected

      def body
        { invoiceId: invoice_id,
          amount: amount,
          extRef: ext_ref,
          items: items.presence
        }
      end

      def data
        %w[status createdDate modifiedDate]
      end
    end
  end
end


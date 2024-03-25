module MonoMerchant
  module Invoice

    # Invalidate invoice
    class Remove < ApiRequest

      attr_reader :invoice_id

      def initialize(invoice_id)
        @invoice_id = invoice_id
        super()
      end

      protected

      def body
        { invoiceId: invoice_id }
      end

    end
  end
end


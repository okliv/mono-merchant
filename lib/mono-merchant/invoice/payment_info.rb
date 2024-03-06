# frozen_string_literal: true

module MonoMerchant
  module Invoice

    class PaymentInfo < ApiRequest

      attr_reader :invoice_id

      def initialize(invoice_id)
        @invoice_id = invoice_id
        super(type: :get)
      end

      protected
      def params
        { invoiceId: invoice_id }
      end

      def data
        %w[maskedPan approvalCode rrn amount ccy finalAmount createdDate terminal paymentScheme paymentMethod fee domesticCard domesticCard cancelList]
      end
    end
  end
end

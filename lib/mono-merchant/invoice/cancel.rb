module MonoMerchant
  module Invoice

    # Cancel successful payment
    class Cancel < Finalize

      attr_reader :ext_ref

      def initialize(invoice_id, amount, ext_ref: nil, items: [])
        super(invoice_id, amount, items)
        @ext_ref = ext_ref
      end

      protected

      def body
        super.merge(extRef: ext_ref)
      end
    end
  end
end


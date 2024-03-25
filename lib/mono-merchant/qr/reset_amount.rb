module MonoMerchant
  module Qr

    # Reset/remove payment
    class ResetAmount < ApiRequest

      attr_reader :qr_id

      def initialize(qr_id)
        @qr_id = qr_id
        super()
      end

      protected

      def body
        { qrId: qr_id }
      end
    end
  end
end
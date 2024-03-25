module MonoMerchant
  module Qr

    # Get info about QR paydesk
    class Details < ApiRequest

      attr_reader :qr_id

      def initialize(qr_id)
        @qr_id = qr_id
        super(type: :get)
      end

      protected
      def params
        { qrId: qr_id }
      end

      def data
        %w[shortQrId invoiceId amount ccy]
      end
    end
  end
end

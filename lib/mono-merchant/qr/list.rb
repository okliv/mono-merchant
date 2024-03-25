module MonoMerchant
  module Qr

    # Get list of QR paydesks
    class List < ApiRequest

      def initialize
        super(type: :get)
      end

      # todo: make array of objects from response list (shortQrId, qrId, amountType, pageUrl)?
      def data
        %w[list]
      end
    end
  end
end

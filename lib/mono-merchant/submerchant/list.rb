module MonoMerchant
  module Submerchant

    # Get list of sub-merchants
    class List < ApiRequest

      def initialize
        super(type: :get)
      end

      # todo: make array of objects from response list (code, edrpou, iban)?
      def data
        %w[list]
      end
    end
  end
end

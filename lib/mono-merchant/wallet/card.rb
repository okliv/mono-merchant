module MonoMerchant
  module Wallet

    # Remove card token
    class Card < ApiRequest

      attr_reader :card_token

      def initialize(card_token)
        @card_token = card_token
        super(type: :delete)
      end

      protected

      def body
        { cardToken: card_token }
      end

    end
  end
end


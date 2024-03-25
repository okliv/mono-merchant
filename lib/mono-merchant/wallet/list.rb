module MonoMerchant
  module Wallet
    class List < ApiRequest

      attr_reader :wallet_id

      # @param [String] wallet_id - wallet id
      def initialize(wallet_id = nil)
        @wallet_id = wallet_id
        super(type: :get)
      end

      def url
        "#{API_URL}/merchant/wallet/#{url_query}"
      end

      protected

      def params
        { walletId: wallet_id }.compact
      end

      # todo: objectify wallets?
      # https://api.monobank.ua/docs/acquiring.html#/paths/~1api~1merchant~1wallet/get
      def data
        %w[wallet]
      end

    end
  end
end

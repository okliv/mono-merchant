# frozen_string_literal: true

module MonoMerchant
  module Invoice

    class Status < PaymentInfo

      protected

      def data
        %w[status failureReason errCode amount ccy finalAmount createdDate modifiedDate reference cancelList walletData]
      end
    end
  end
end

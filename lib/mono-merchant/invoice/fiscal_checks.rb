# frozen_string_literal: true

module MonoMerchant
  module Invoice

    class FiscalChecks < PaymentInfo

      protected

      # todo: objectify array of checks?
      # https://api.monobank.ua/docs/acquiring.html#/paths/~1api~1merchant~1invoice~1fiscal-checks?invoiceId={invoiceId}/get
      def data
        %w[checks]
      end
    end
  end
end

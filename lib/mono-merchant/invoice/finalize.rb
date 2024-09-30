# frozen_string_literal: true

module MonoMerchant
  module Invoice

    # Finalize holding amount
    class Finalize < ApiRequest
      attr_reader :invoice_id, :amount, :items

      def initialize(invoice_id, amount = nil, items: [])
        @invoice_id = invoice_id
        @amount = amount
        @items = items.map { |i| Item.new(i).to_hash }
        super()
      end

      protected

      def implicit_amount
        resp = Status.new(invoice_id).send(:response)
        err_hsh = {}
        if resp.is_a?(Hash)
          %w[errCode failureReason].each do |err|
            err_msg = resp[err]
            next unless err_msg
            err_hsh[err] = err_msg
          end
        else
          err_hsh['wrongData'] = 'response is not a Hash'
        end
        unless err_hsh.empty?
          warn err_hsh
          return nil
        end

        resp['amount'] if resp['status'] == 'hold'
      end

      def body
        { invoiceId: invoice_id,
          amount: amount || implicit_amount,
          items: items.presence
        }.compact!
      end

      def data
        %w[status]
      end
    end
  end
end

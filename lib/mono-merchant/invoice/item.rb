# frozen_string_literal: true

module MonoMerchant
  module Invoice
    class Item

      REQUIRED_ATTRS = %i[name qty sum code]

      attr_reader *REQUIRED_ATTRS, :icon, :unit, :header, :footer

      def initialize(i)
        # TODO: check required?
        @name = i[:name]
        @qty = i[:qty]
        @sum = i[:sum]
        @code = i[:code]

        # optional
        @icon = i[:icon]
        @unit = i[:unit]
        @header = i[:header]
        @footer = i[:footer]
      end
    end
  end
end
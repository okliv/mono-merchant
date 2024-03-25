module MonoMerchant
  class Details < ApiRequest

    def initialize
      super(type: :get)
    end

    protected

    def data
      %w[merchantId merchantName edrpou]
    end

  end
end

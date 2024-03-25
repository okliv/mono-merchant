module MonoMerchant
  class Statement < ApiRequest

    attr_reader :from, :to

    # @param [Integer] from - utc unix timestamp
    # @param [Integer] to - utc unix timestamp
    def initialize(from: nil, to: nil)
      @from, @to = from, to
      super(type: :get)
    end

    protected

    def params
      { from: from, to: to }.compact
    end

    # todo: objectify data?
    # https://api.monobank.ua/docs/acquiring.html#/paths/~1api~1merchant~1statement/get
    def data
      %w[list]
    end

  end
end

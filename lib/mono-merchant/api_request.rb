# frozen_string_literal: true

module MonoMerchant
  class ApiRequest

    API_URL = "https://api.monobank.ua/api"
    DEFAULT_CURRENCY = "UAH"

    attr_reader :errors, :type

    def initialize(type: :post)
      @type = type
      @errors = []
    end

    def url
      "#{API_URL}/#{self.class.name.underscore.dasherize.sub('mono-', '')}#{url_query}"
    end

    protected

    # Required headers for Monobank API
    #
    # @return [Hash] headers
    def headers
      warn 'ENV["MONOBANK_API_TOKEN"] is absent' unless ENV["MONOBANK_API_TOKEN"]
      {
        content_type: :json,
        accept: :json,
        "X-Token": ENV["MONOBANK_API_TOKEN"]
      }
    end

    def url_query
      "#{'?' if params.presence}#{URI.encode_www_form(params.to_hash)}" if type == :get
    end

    def params
      {}
    end

    def body
      {}
    end

    # @return [Hash] response body of false in case of errors
    def response
      @response ||= begin
                      response = case type
                                 when :post
                                   RestClient.post(url, body.compact.to_json, headers)
                                 when :get
                                   RestClient.get(url, headers)
                                 when :delete
                                   RestClient.delete(url, headers)
                                 end
                      body = JSON.parse(response.body)
                      Hash[data.map { |rp| [rp, body[rp]] }]
                    rescue StandardError => e
                      response_body = JSON.parse(e.response.body) rescue {}
                      @errors << [e.message, { response_body['errCode'] => response_body['errText'] }]
                      warn @errors
                      false
                    end
    end

    def convert_to_cents(amount)
      if amount.is_a?(BigDecimal)
        Money.from_amount(amount, currency).cents
      else
        amount
      end
    end

    private

    def method_missing(name, *args)
      cam_name = name.to_s.camelize(:lower)
      return super unless data.include?(cam_name)

      response[cam_name] if response
    end
  end
end
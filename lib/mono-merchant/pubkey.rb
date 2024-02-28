# frozen_string_literal: true

module MonoMerchant
  class Pubkey < ApiRequest

    def self.get
      @@get ||= begin
                  key = new.key
                  Base.decode key if key
                end
    end

    def self.reset
      @@get = nil
      self.get
    end

    def initialize
      super(type: :get)
    end

    private

    def data
      %w[key]
    end
  end
end

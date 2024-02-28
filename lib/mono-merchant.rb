# frozen_string_literal: true

require 'active_support/core_ext/module'
require 'active_support/core_ext/object/blank'
require "base64"
require "bigdecimal"
require "json"
require "money"
require "rest-client"

module MonoMerchant
  class Base
    def self.decode(str)
      Base64.decode64(str)
    end
  end
end

Dir.glob(File.join(__dir__, "mono-merchant", "/**/*.rb")).sort.each { |file| require file }

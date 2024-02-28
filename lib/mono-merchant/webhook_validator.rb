module MonoMerchant
  class WebhookValidator

    def initialize(request)
      @request = request
      @webhook_data = @request.raw_post
    end

    def public_key
      Pubkey.get
    end

    # Validate webhook data signature with public key
    #
    # @return [Boolean] valid?
    def valid?
      return false if @webhook_data.nil?
      return false if signature.nil?
      return false unless public_key

      openssl_ec = OpenSSL::PKey::EC.new(public_key)
      openssl_ec.check_key

      return true if openssl_ec.verify(digest, signature, @webhook_data)

      warn "Webhook isn't authorized. Might be wrong signature or inconsistent webhook data."

      false
    end

    private

    # Get signature from request headers
    #
    # @return [String] signature
    def signature
      @signature ||= Base.decode(@request.headers["X-Sign"])
    end

    # Get digest from OpenSSL
    #
    # @return [OpenSSL::Digest] digest
    def digest
      @digest ||= OpenSSL::Digest.new("SHA256")
    end
  end
end

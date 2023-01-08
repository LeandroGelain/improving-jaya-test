module WebhookAuthHelper
  def authenticate_webhook!
    x_hub_signature = request.headers['X-Hub-Signature-256']

    body = request.body.read
    key = "sha256=#{OpenSSL::HMAC.hexdigest(OpenSSL::Digest.new('sha256'), ENV['SECRET_TOKEN'], body)}"

    valid_credentials = x_hub_signature == key

    return head :unauthorized unless valid_credentials
  end
end
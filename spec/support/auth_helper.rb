module AuthHelper
  def http_basic_auth
    request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials(
      ENV['BASIC_AUTH_USER'], ENV['BASIC_AUTH_PASSWORD']
    )
  end
end

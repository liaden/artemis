module JwtToken
  module_function

  def bearer(token)
    "Bearer #{token}"
  end

  def auth_header(given_tenant = nil)
    given_tenant = tenant if given_tenant.nil? && defined?(:tenant)
    given_tenant ||= create(:tenant)

    { 'HTTP_AUTHORIZATION' => bearer(Token.devtest_token(tenant_id: tenant.tenant_id)) }
  end

  def set_request_header(given_tenant = nil)
    before do
      h = auth_header(given_tenant)
      @request.set_header(*h.first)
    end
  end
end

RSpec.configure do |c|
  c.extend JwtToken
  c.include JwtToken
end

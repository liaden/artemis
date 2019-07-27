module Rack::JWT
  class Cookie

    def initialize(app, opts = {}, &block)
      @app = app
      @cookie_name = opts[:cookie] || 'AUTH_TOKEN'
      @make_token = block

      raise 'Not for production usage' if Rails.env.production?
    end

    def call(env)
      request = Rack::Request.new(env)

      token =
        if request.params.key?('tenant_id')
          tenant_id = request.params['tenant_id'].to_i
          ::Token.devtest_token(tenant_id: tenant_id)
        else
          request.cookies[@cookie_name]
        end

      env['HTTP_AUTHORIZATION'] ||= "Bearer #{token}" if token

      if tenant_id
        status, headers, body = @app.call(env)
        response = Rack::Response.new(body, status, headers)
        response.set_cookie(@cookie_name, token)
        response.finish
      else
        @app.call(env)
      end
    end
  end
end

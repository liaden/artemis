class ApplicationController < ActionController::Base
  def current_tenant
    @tenant ||=
      begin
        logger.debug request.env.slice('jwt.payload', 'jwt.header')
        tenant_id = request.env.dig('jwt.payload', 'tenant_id')
        Tenant.find(tenant_id)
      end
  rescue ActiveRecord::RecordNotFound
    head :unauthorized
  end

  before_action :current_tenant
end

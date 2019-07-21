class Api::TenantsController < Api::ApplicationController
  def index
    render jsonapi: Tenant.all
  end

  def show
    render jsonapi: tenant
  end

  def create
    Tenant.create!(tenant_params)

    head :created
  end

  def update
    tenant.update!(tenant_params)

    head :ok
  end

  def destroy
    tenant.destroy

    head :ok
  end

  private

  def tenant
    @tenant ||= fetch_tenant
  end

  def fetch_tenant
    Tenant.find_by(tenant_id: params[:tenant_id])
  end

  def tenant_params
    params.require(:tenant).permit(:tenant_id, :name)
  end
end

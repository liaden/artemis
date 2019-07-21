class TenantSerializer
  include FastJsonapi::ObjectSerializer

  attributes :tenant_id, :name
end

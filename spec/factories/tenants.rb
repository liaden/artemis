FactoryBot.define do
  factory :tenant do
    tenant_id { 1 }
    sequence(:name) { |n| "test-tenant-name-#{n}" }
  end
end

FactoryBot.define do
  factory :tenant do
    sequence(:tenant_id, 100)
    sequence(:name) { |n| "test-tenant-name-#{n}" }
  end
end

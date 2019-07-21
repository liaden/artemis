FactoryBot.define do
  factory :publication_status do
    sequence(:name) { |n| "fake-status-#{n}" }
  end
end

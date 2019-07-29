FactoryBot.define do
  factory :page do
    tenant { Tenant.first || create(:tenant) }
    content { 'some plain text content' }
    sequence(:name) { |n| "test-page-#{n}" }
    publication_status { PublicationStatus.first || create(:publication_status) }

    trait :with_tenant do
      tenant { create(:tenant) }
    end

    trait :draft do
      publication_status { PublicationStatus['draft'] }
    end

    trait :published do
      publication_status { PublicationStatus['published'] }
    end

    trait :withdrawn do
      publication_status { PublicationStatus['withdrawn'] }
    end
  end
end

FactoryBot.define do
  factory :publication_status do
    name { 'draft' }

    trait :draft do
      name {'draft' }
    end

    trait :published do
      name { 'published' }
    end

    trait :withdrawn do
      name { 'withdrawn' }
    end
  end
end

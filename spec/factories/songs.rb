FactoryBot.define do
  factory :song do
    association :composer
    association :composition
    sequence(:opus) { |n| n }
    sequence(:number) { |n| n }
    key { "a minor" }

    trait :posthumous do
      opus { "posthumous" }
    end

    trait :no_number do
      number { nil }
    end

    trait :alt_name do
      alt_name { "Winter Wind" }
    end
  end
end

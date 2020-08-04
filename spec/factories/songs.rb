FactoryBot.define do
  factory :song do
    association :composer
    association :composition
    sequence(:title) { |n| "song #{n}" }
  end
end

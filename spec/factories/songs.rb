FactoryBot.define do
  factory :song do
    association :composer
    association :composition
    title { "title" }
  end
end

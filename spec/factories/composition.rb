FactoryBot.define do
  factory :composition do
    sequence(:name) { |n| "composition #{n}" }
  end
end

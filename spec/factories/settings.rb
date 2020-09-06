FactoryBot.define do
  factory :setting do
    sequence(:id) { |n| n }
    sequence(:description) { |n| "description #{n}" }
    association :setting_classification
  end
end

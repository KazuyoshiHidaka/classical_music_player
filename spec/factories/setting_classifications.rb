FactoryBot.define do
  factory :setting_classification do
    sequence(:id) { |n| n }
    sequence(:description) { |n| "description #{n}" }
  end
end

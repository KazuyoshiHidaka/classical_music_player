FactoryBot.define do
  factory :setting do
    sequence(:id) { |n| n }
    sequence(:description) { |n| "description #{n}" }
  end
end

FactoryBot.define do
  factory :composer do
    sequence(:name) { |n| "composer #{n}" }
  end
end

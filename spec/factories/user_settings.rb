FactoryBot.define do
  factory :user_setting do
    association :user
    association :setting
    setting_classification { setting.setting_classification }
  end
end

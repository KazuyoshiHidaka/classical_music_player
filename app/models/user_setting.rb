class UserSetting < ApplicationRecord
  belongs_to :user
  belongs_to :setting
  belongs_to :setting_classification

  validates_uniqueness_of :user_id, scope: :setting_classification_id
  before_validation do
    self.setting_classification_id = setting.setting_classification_id
  end
end

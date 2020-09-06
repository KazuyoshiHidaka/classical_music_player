class Setting < ApplicationRecord
  has_many :user_settings, dependent: :destroy
  has_many :users, through: :user_settings
  belongs_to :setting_classification

  validates :id, presence: true
  validates_uniqueness_of :id
  validates_numericality_of :id, only_integer: true,
                                 greater_than: 0
  validates :description, presence: true
  validates_uniqueness_of :description, case_sensitive: true

  def self.post_data_to_db
    data.each do |setting|
      find_or_initialize_by(id: setting[:id]).update(setting)
    end
  end

  def self.data
    SettingClassification.post_data_to_db unless SettingClassification.exists?
    [
      {
        id: 1,
        setting_classification_id: 1,
        description: "次の曲を再生",
      },
      {
        id: 2,
        setting_classification_id: 1,
        description: "同じ曲の次の動画を再生",
      },
      {
        id: 3,
        setting_classification_id: 1,
        description: "同じ動画をループ再生",
      },
    ]
  end
end

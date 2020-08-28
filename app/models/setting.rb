class Setting < ApplicationRecord
  has_and_belongs_to_many :users

  validates :id, presence: true
  validates_uniqueness_of :id
  validates_numericality_of :id, only_integer: true,
                                 greater_than: 0
  validates :description, presence: true
  validates_uniqueness_of :description, case_sensitive: true

  def self.post_data_to_db
    data.each do |setting|
      Setting.find_or_initialize_by(id: setting[:id]).update(setting)
    end
  end

  def self.data
    [
      {
        id: 1,
        description: "動画が終了した後、次の曲を自動で再生する",
      },
      {
        id: 2,
        description: "動画が終了した後、次の動画を自動で再生する",
      },
    ]
  end
end

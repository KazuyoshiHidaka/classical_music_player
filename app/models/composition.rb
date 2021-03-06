class Composition < ApplicationRecord
  has_many :songs
  has_many :composers, -> { distinct }, through: :songs

  validates :name, presence: true
  validates_uniqueness_of :name, case_sensitive: true
end

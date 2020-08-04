class Song < ApplicationRecord
  belongs_to :composer
  belongs_to :composition

  validates :title, presence: true
  validates_uniqueness_of :title, case_sensitive: true, scope: %i(composer_id composition_id)
end

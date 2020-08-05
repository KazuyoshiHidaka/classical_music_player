class Song < ApplicationRecord
  belongs_to :composer
  belongs_to :composition

  validates_numericality_of :opus, only_integer: true,
                                   greater_than: 0,
                                   message: "opus: 整数 | 'posthumous'",
                                   unless: -> { opus == "posthumous" }
  validates_numericality_of :number, only_integer: true,
                                     greater_than: 0,
                                     allow_nil: true
  validates :number, presence: true, if: -> {
                                           Song.where(
                                             composer_id: composer_id,
                                             composition_id: composition_id
                                           ).exists?
                                         }
  validates_uniqueness_of :opus, case_sensitive: true,
                                 scope: %i(composer_id number),
                                 message: "複合キー[composer_id opus number]はuniqueness"
end

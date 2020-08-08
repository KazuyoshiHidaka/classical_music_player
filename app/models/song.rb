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

  def query_to_search_youtube
    words = [composer.name, composition.name]
    if opus == 'posthumous'
      words << opus << number
    else
      words << "op #{opus}"
      words << "no" if number
      words << number
    end
    words << alt_name

    words.compact.join(" ")
  end
end

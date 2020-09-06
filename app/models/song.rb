class Song < ApplicationRecord
  belongs_to :composer
  belongs_to :composition

  validates :title, presence: true

  def next_in(collection:)
    i_self = collection.ids.index(id)
    i_next = i_self + 1
    i_next -= collection.length if i_next >= collection.length
    collection.find(collection.ids[i_next])
  end
end

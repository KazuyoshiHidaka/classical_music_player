class Song < ApplicationRecord
  belongs_to :composer
  belongs_to :composition

  validates :title, presence: true

  def title_with(composer: false, composition: false)
    if !composer && !composition
      raise ArgumentError,
            "代わりにSong#titleメソッドを使用してください"
    end

    words = [title]
    words.unshift(self.composition.name.titleize) if composition
    words.unshift(self.composer.name.titleize)    if composer

    words.join(' ')
  end

  def next_in(collection:)
    i_self = collection.ids.index(id)
    i_next = i_self + 1
    i_next -= collection.length if i_next >= collection.length
    collection.find(collection.ids[i_next])
  end
end

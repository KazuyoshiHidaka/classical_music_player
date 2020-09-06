class SongDecorator < ApplicationDecorator
  delegate_all

  def title_with(composer: false, composition: false)
    if !composer && !composition
      raise ArgumentError,
            "代わりにSong#titleメソッドを使用してください"
    end

    words = [model.title]
    words.unshift(model.composition.name.titleize) if composition
    words.unshift(model.composer.name.titleize)    if composer

    words.join(' ')
  end

  def next_song_in_all_songs_list(parent_class:)
    return unless parent_class
    if parent_class != Composer && parent_class != Composition
      raise ArgumentError, ":parent_classにはComposerかCompositionを与えてください"
    end
    if parent_class == Composer
      songs = self.class.songs_index_in_composer_songs_list
    elsif parent_class == Composition
      songs = self.class.songs_index_in_composition_songs_list
    end
    model.next_in(collection: songs)
  end

  def self.songs_index_in_composer_songs_list
    joins(:composer, :composition).order("composers.name", "compositions.name", :id)
  end

  def self.songs_index_in_composition_songs_list
    joins(:composition, :composer).order("compositions.name", "composers.name", :id)
  end
end

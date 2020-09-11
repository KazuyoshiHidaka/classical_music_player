class Song < ApplicationRecord
  belongs_to :composer
  belongs_to :composition
  has_one :youtube_search_list, class_name: "SongYoutubeSearchList",
                                foreign_key: "song_id"

  validates :title, presence: true

  def next_in(collection:)
    i_self = collection.ids.index(id)
    i_next = i_self + 1
    i_next -= collection.length if i_next >= collection.length
    collection.find(collection.ids[i_next])
  end

  def search_and_save_youtube_video_ids
    video_ids = Apis::Youtube.new.search_video_ids(
      q: decorate.title_with(composer: true, composition: true)
    )

    if youtube_search_list
      youtube_search_list.update(result_video_ids: video_ids)
    else
      create_youtube_search_list(result_video_ids: video_ids)
    end
  end
end

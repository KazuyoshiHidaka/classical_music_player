class SongYoutubeSearchList < ApplicationRecord
  belongs_to :song
  validates_uniqueness_of :song_id
  validates :result_video_ids, presence: true

  def video_ids
    JSON.parse result_video_ids
  end
end

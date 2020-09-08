class CreateSongYoutubeSearchLists < ActiveRecord::Migration[6.0]
  def change
    create_table :song_youtube_search_lists do |t|
      t.belongs_to :song, index: { unique: true }, foreign_key: true
      t.text :result_video_ids, null: false, array: true
      t.timestamps
    end
  end
end

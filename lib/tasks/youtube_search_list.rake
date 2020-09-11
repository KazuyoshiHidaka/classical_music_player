namespace :youtube_search_list do
  desc "全てのSongに対してYoutubeDataAPi#search_listを実行し、結果をDBに保存するタスク"
  task update_all: :environment do
    Song.where.not(id: SongYoutubeSearchList.select(:song_id)).find_each do |song|
      song.search_and_save_youtube_video_ids
    end

    SongYoutubeSearchList.joins(:song).order(:updated_at).find_each do |song_youtube_search_list|
      song_youtube_search_list.song.search_and_save_youtube_video_ids
    end
  end
end

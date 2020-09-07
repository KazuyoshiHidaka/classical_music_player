namespace :youtube_search_list do
  desc "YoutubeDataAPi#search_listを実行し、結果をDBに保存するタスク"
  task update: :environment do
    Song.where.not(id: SongYoutubeSearchList.select(:song_id)).find_each do |song|
      save_youtube_video_ids(song: song)
    end

    SongYoutubeSearchList.joins(:song).order(:updated_at).find_each do |song_youtube_search_list|
      save_youtube_video_ids(song: song_youtube_search_list.song)
    end
  end

  def save_youtube_video_ids(song:)
    search_result = Apis::Youtube.new.search_videos(
      q: song.decorate.title_with(composer: true, composition: true)
    )
    video_ids = search_result[:items].pluck(:id).pluck(:video_id)
    song_youtube_search_list = song.youtube_search_list

    if song_youtube_search_list
      song_youtube_search_list.update(result_video_ids: video_ids)
    else
      song.create_youtube_search_list(result_video_ids: video_ids)
    end
  end
end

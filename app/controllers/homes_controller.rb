class HomesController < ApplicationController
  def home
    @random_song =
      SongYoutubeSearchList.all[rand(SongYoutubeSearchList.all.length)]&.song
    @random_song ||= Song.first
  end

  def cached_all_songs_list
    render partial: "share/songs_lists/cached_all_songs_list"
  end
end

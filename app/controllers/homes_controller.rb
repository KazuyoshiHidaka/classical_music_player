class HomesController < ApplicationController
  def home
    @random_song = Song.all[rand(Song.all.length)]
  end

  def cached_all_songs_list
    render partial: "share/songs_lists/cached_all_songs_list"
  end
end

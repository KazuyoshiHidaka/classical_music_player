class HomesController < ApplicationController
  def home
    @random_song = Song.all[rand(Song.all.length)]
  end
end

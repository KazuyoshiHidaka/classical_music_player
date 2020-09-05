class SongsController < ApplicationController
  def show
    @song = Song.find_by(id: params[:id])
    @videos = get_videos(q: @song.title_with(composer: true, composition: true)).to_h
  end

  def index
  end

  def get_videos(**options)
    Apis::Youtube.new.search_videos(**options)
  end
end

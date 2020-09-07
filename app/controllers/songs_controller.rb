class SongsController < ApplicationController
  def show
    @song = Song.find_by(id: params[:id])
    @all_songs_list_parent_class = params[:all_songs_list_parent_class]&.constantize
    @video_ids = @song.youtube_search_list&.video_ids
  end

  def index
  end
end

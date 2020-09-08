class SongsController < ApplicationController
  def show
    @song = Song.find_by(id: params[:id])
    @all_songs_list_parent_class = params[:all_songs_list_parent_class]&.constantize
    @video_ids = if @song.youtube_search_list
                   @song.youtube_search_list.video_ids
                 else
                   flash[:notice] = "動画データがありません"
                   Apis::Youtube.new.mock_video_ids
                 end
  end

  def index
  end
end

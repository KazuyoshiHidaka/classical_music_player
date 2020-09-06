class SongsController < ApplicationController
  def show
    @song = Song.find_by(id: params[:id])
    @all_songs_list_parent_class = params[:all_songs_list_parent_class]&.constantize
    begin
      @videos = get_videos(q: @song.decorate.title_with(composer: true, composition: true)).to_h
    rescue Google::Apis::ClientError => e
      flash[:danger] = google_apis_client_error_result(e)
    end
  end

  def index
  end

  def get_videos(**options)
    Apis::Youtube.new.search_videos(**options)
  end

  private

  def google_apis_client_error_result(e)
    unless e.instance_of? Google::Apis::ClientError
      raise ArgumentError,
            "Google::Apis::ClientErrorインスタンスを引数に与えてください"
    end

    e_body = JSON.parse e.body
    code = e_body.dig("error", "code")
    reason = e_body.dig("error", "errors")[0]["reason"]
    if reason == "quotaExceeded"
      "Youtube Data Apiの1日の割り当て上限を超えました"
    else
      "#{code}: #{reason}"
    end
  end
end

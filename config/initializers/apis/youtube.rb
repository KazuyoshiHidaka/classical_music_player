require 'google/apis/youtube_v3'

module Apis
  class Youtube
    def get_service
      service = Google::Apis::YoutubeV3::YouTubeService.new
      service.key = ENV.fetch('YOUTUBE_API_KEY')
      service
    end

    def search_videos(q, page_token: nil, type: 'video', max_results: 10)
      opt = {
        q: q,
        type: type,
        max_results: max_results,
        page_token: page_token,
      }
      get_service.list_searches(:snippet, opt)
    end
  end
end

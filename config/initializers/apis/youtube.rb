require 'google/apis/youtube_v3'

module Apis
  class Youtube
    def get_service
      service = Google::Apis::YoutubeV3::YouTubeService.new
      service.key = ENV.fetch('YOUTUBE_API_KEY')
      service
    end

    def search_videos(**options)
      opt = {
        type: 'video',
        max_results: 10,
      }.merge(options)
      get_service.list_searches(:snippet, opt)
    end

    def hash_mock_response_search_videos
      {
        :etag => "BowX6BR2zsByn6tUSobQ09MdIE4",
        :items => [
          {
            :etag => "dHJ7ugniDs2hRXWOYtbtkmSBaKk",
            :id => {
              :kind => "youtube#video",
              :video_id => "wygy721nzRc",
            },
            :kind => "youtube#searchResult",
            :snippet => {
              :channel_id => "UCyOfqgtsQaM3S-VZnsYnHjQ",
              :channel_title => "HALIDONMUSIC",
              :description => "Buy the MP3 album on the Official Halidon Music Store: http://bit.ly/VzxEKC Stream it on Spotify: https://spoti.fi/2NtSPPg iTunes & Apple Music: ...", # rubocop:disable LineLength
              :live_broadcast_content => "none",
              :published_at => "2012-10-04T12:20:38Z",
              :thumbnails => {
                :default => {
                  :height => 90,
                  :url => "https://i.ytimg.com/vi/wygy721nzRc/default.jpg",
                  :width => 120,
                },
                :high => {
                  :height => 360,
                  :url => "https://i.ytimg.com/vi/wygy721nzRc/hqdefault.jpg",
                  :width => 480,
                },
                :medium => {
                  :height => 180,
                  :url => "https://i.ytimg.com/vi/wygy721nzRc/mqdefault.jpg",
                  :width => 320,
                },
              }, :title => "The Best of Chopin",
            },
          },
        ],
        :kind => "youtube#searchListResponse",
        :next_page_token => "CAEQAA",
        :page_info => {
          :results_per_page => 1,
          :total_results => 1000000,
        },
        :region_code => "JP",
      }
    end
  end
end

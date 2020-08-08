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
        :etag => "-muP1GtgGV8_NRNjKiNMRbLSRNw",
        :items =>
        [
          {
            :etag => "dHJ7ugniDs2hRXWOYtbtkmSBaKk",
            :id => { :kind => "youtube#video", :video_id => "wygy721nzRc" },
            :kind => "youtube#searchResult",
            :snippet =>
              {
                :channel_id => "UCyOfqgtsQaM3S-VZnsYnHjQ",
                :channel_title => "HALIDONMUSIC",
                :description =>
                "Buy the MP3 album on the Official Halidon Music Store: http://bit.ly/VzxEKC Stream it on Spotify: https://spoti.fi/2NtSPPg iTunes & Apple Music: ...", # rubocop:disable LineLength
                :live_broadcast_content => "none",
                :published_at => "2012-10-04T12:20:38Z",
                :thumbnails =>
                {
                  :default =>
                            {
                              :height => 90,
                              :url => "https://i.ytimg.com/vi/wygy721nzRc/default.jpg",
                              :width => 120,
                            },
                  :high =>
                  {
                    :height => 360,
                    :url => "https://i.ytimg.com/vi/wygy721nzRc/hqdefault.jpg",
                    :width => 480,
                  },
                  :medium =>
                  {
                    :height => 180,
                    :url => "https://i.ytimg.com/vi/wygy721nzRc/mqdefault.jpg",
                    :width => 320,
                  },
                },
                :title => "The Best of Chopin",
              },
          },
          {
            :etag => "rTM1Mo7PK_jpTGM7s39fytpSFUs",
            :id => { :kind => "youtube#video", :video_id => "Jn09UdSb3aA" },
            :kind => "youtube#searchResult",
            :snippet =>
            {
              :channel_id => "UCyOfqgtsQaM3S-VZnsYnHjQ",
              :channel_title => "HALIDONMUSIC",
              :description =>
              "Buy the MP3 album on the Official Halidon Music Store: http://bit.ly/2VsAYhx Listen to our playlist on Spotify: http://bit.ly/ChopinEssentialClassics Order “100 ...", # rubocop:disable LineLength
              :live_broadcast_content => "none",
              :published_at => "2020-03-04T12:00:04Z",
              :thumbnails =>
              {
                :default =>
                      {
                        :height => 90,
                        :url => "https://i.ytimg.com/vi/Jn09UdSb3aA/default.jpg",
                        :width => 120,
                      },
                :high =>
                {
                  :height => 360,
                  :url => "https://i.ytimg.com/vi/Jn09UdSb3aA/hqdefault.jpg",
                  :width => 480,
                },
                :medium =>
                {
                  :height => 180,
                  :url => "https://i.ytimg.com/vi/Jn09UdSb3aA/mqdefault.jpg",
                  :width => 320,
                },
              },
              :title => "The Best of Chopin",
            },
          },
          {
            :etag => "r_dnZbsPFyX3mRtdimo5nyduXas",
            :id => { :kind => "youtube#video", :video_id => "Jz1gvBluvc8" },
            :kind => "youtube#searchResult",
            :snippet =>
            {
              :channel_id => "UCZaJ3OMCshUvMqhxLokaYhA",
              :channel_title => "Vadim Chaimovich - Topic",
              :description =>
              "Provided to YouTube by CDBaby Frédéric Chopin: Nocturne in E-Flat Major, Op. 9, No. 2 · Vadim Chaimovich Frédéric Chopin: Nocturne in E-Flat Major, Op. 9, ...", # rubocop:disable LineLength
              :live_broadcast_content => "none",
              :published_at => "2017-12-07T10:19:15Z",
              :thumbnails =>
              {
                :default =>
                      {
                        :height => 90,
                        :url => "https://i.ytimg.com/vi/Jz1gvBluvc8/default.jpg",
                        :width => 120,
                      },
                :high =>
                {
                  :height => 360,
                  :url => "https://i.ytimg.com/vi/Jz1gvBluvc8/hqdefault.jpg",
                  :width => 480,
                },
                :medium =>
                {
                  :height => 180,
                  :url => "https://i.ytimg.com/vi/Jz1gvBluvc8/mqdefault.jpg",
                  :width => 320,
                },
              },
              :title => "Frédéric Chopin: Nocturne in E-Flat Major, Op. 9, No. 2",
            },
          },
        ],
        :kind => "youtube#searchListResponse",
        :next_page_token => "CAMQAA",
        :page_info => { :results_per_page => 3, :total_results => 1000000 },
        :region_code => "JP",
      }
    end
  end
end

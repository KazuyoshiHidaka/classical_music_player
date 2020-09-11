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
        max_results: 20,
        video_embeddable: true,
      }.merge(options)
      get_service.list_searches(:id, opt).to_h
    end

    def mock_video_ids
      ["wygy721nzRc", "Jn09UdSb3aA", "Jz1gvBluvc8"]
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
          },
          {
            :etag => "rTM1Mo7PK_jpTGM7s39fytpSFUs",
            :id => { :kind => "youtube#video", :video_id => "Jn09UdSb3aA" },
            :kind => "youtube#searchResult",
          },
          {
            :etag => "r_dnZbsPFyX3mRtdimo5nyduXas",
            :id => { :kind => "youtube#video", :video_id => "Jz1gvBluvc8" },
            :kind => "youtube#searchResult",
          },
        ],
        :kind => "youtube#searchListResponse",
        :next_page_token => "CAMQAA",
        :page_info => { :results_per_page => 3, :total_results => 1000000 },
        :region_code => "JP",
      }
    end

    def error_body_mock(reason: "invalidParameter", code: 400)
      {
        "error": {
          "errors": [
            {
              "domain": "global",
              "reason": reason,
              "message": "Invalid string value: 'asdf'. Allowed values: [mostpopular]",
              "locationType": "parameter",
              "location": "chart",
            },
          ],
          "code": code,
          "message": "Invalid string value: 'asdf'. Allowed values: [mostpopular]",
        },
      }.to_json
    end
  end
end

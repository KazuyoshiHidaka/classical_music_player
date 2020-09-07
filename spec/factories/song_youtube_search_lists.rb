FactoryBot.define do
  factory :song_youtube_search_list do
    association :song
    result_video_ids { Apis::Youtube.new.mock_video_ids }
  end
end

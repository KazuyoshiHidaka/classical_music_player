module CustomMacros
  def allow_get_youtube_videos
    allow_any_instance_of(SongsController).to receive(:get_videos).and_return(
      Apis::Youtube.new.hash_mock_response_search_videos
    )
  end
end

RSpec.configure do |config|
  config.include CustomMacros
end

require 'rails_helper'

RSpec.describe "Songs", type: :request do
  describe "GET #index" do
    before { get songs_path }

    it "200レスポンスを返す" do
      expect(response).to have_http_status 200
    end
  end

  describe "GET #show" do
    let(:song) { create(:song) }

    it "200レスポンスを返す" do
      allow_any_instance_of(SongsController).to receive(:get_videos).
        and_return(Apis::Youtube.new.hash_mock_response_search_videos)
      get song_path(song.id)
      expect(response).to have_http_status 200
    end

    it "#get_videosは1回だけ呼ばれる" do
      expect_any_instance_of(SongsController).to receive(:get_videos).once.
        and_return(Apis::Youtube.new.hash_mock_response_search_videos)
      get song_path(song.id)
    end
  end
end

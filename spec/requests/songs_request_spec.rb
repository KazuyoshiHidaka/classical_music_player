require 'rails_helper'

RSpec.describe "Songs", type: :request do
  before { login }

  describe "GET #show" do
    let(:song) { create(:song) }

    before do
      allow_get_youtube_videos
      get song_path(song.id)
    end

    it_behaves_like 'HTTP200を返す'

    describe "Google::Api::ClientErrorハンドリングテスト" do
      let(:error) { Google::Apis::ClientError.new(body: "a") }

      before do
        allow_any_instance_of(SongsController).to receive(:get_videos).
          and_raise(error)
        allow(error).to receive(:body).
          and_return(Apis::Youtube.new.error_body_mock)

        get song_path(song.id)
      end

      it_behaves_like 'HTTP200を返す'
    end
  end
end

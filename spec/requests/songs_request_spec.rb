require 'rails_helper'

RSpec.describe "Songs", type: :request do
  describe "#index" do
    before { get songs_path }

    it "200レスポンスを返す" do
      expect(response).to have_http_status 200
    end
  end

  describe "#search" do
    before { get search_songs_path }

    it "200レスポンスを返す" do
      expect(response).to have_http_status 200
    end
  end
end

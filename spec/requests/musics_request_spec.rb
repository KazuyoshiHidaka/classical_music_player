require 'rails_helper'

RSpec.describe "Musics", type: :request do
  describe "#index" do
    before { get musics_path }

    it "200レスポンスを返す" do
      expect(response).to have_http_status 200
    end
  end

  describe "#search" do
    before { get search_musics_path }

    it "200レスポンスを返す" do
      expect(response).to have_http_status 200
    end
  end
end

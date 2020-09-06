require 'rails_helper'

RSpec.describe "Homes", type: :request do
  before { login }

  let!(:song) { create(:song) }

  describe "GET #home(root)" do
    before { get root_path }

    it "200レスポンスを返す" do
      expect(response).to have_http_status 200
    end
  end
end

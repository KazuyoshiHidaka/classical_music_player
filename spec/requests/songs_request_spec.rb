require 'rails_helper'

RSpec.describe "Songs", type: :request do
  before { login }

  describe "GET #show" do
    let(:song) { create(:song) }

    before do
      get song_path(song.id)
    end

    it_behaves_like 'HTTP200を返す'
  end
end

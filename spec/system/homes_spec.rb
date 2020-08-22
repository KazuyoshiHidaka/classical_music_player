require 'rails_helper'
require 'system/layouts/songs_lists_spec'

RSpec.describe "Homes", type: :system do
  describe "#home" do
    let!(:song) { create(:song) }

    before { visit root_path }

    it_behaves_like "Layouts::SongsLists"
  end
end

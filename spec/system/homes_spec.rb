require 'rails_helper'
require 'system/shared_widgets/all_songs_list_spec'

RSpec.describe "Homes", type: :system do
  describe "#search" do
    let!(:song) { create(:song) }

    before { visit root_path }

    it_behaves_like "SharedWidgets::AllSongsList"
  end
end

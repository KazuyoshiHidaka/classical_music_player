require 'system/shared_widgets/all_songs_list_spec'
require 'system/shared_widgets/user_liked_songs_list_spec'
require 'system/shared_widgets/user_history_songs_list_spec'

RSpec.shared_examples "SharedWidgets::SongsLists" do
  describe "AllSongsListタブ" do
    def open_all_songs_list_tab
      tab = page.find "##{parent_container_name}AllSongsTab"
      tab.click
    end

    before { open_all_songs_list_tab }

    it_behaves_like "SharedWidgets::AllSongsList"
  end

  describe "UserLikedSongsListタブ" do
    before do
      tab = page.find "##{parent_container_name}UserLikedSongsTab"
      tab.click
    end

    it_behaves_like "SharedWidgets::UserLikedSongsList"
  end

  describe "UserLikedSongsListタブ" do
    before do
      tab = page.find "##{parent_container_name}UserHistorySongsTab"
      tab.click
    end

    it_behaves_like "SharedWidgets::UserHistorySongsList"
  end
end

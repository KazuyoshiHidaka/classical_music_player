require 'rails_helper'
require 'system/layouts/songs_lists_spec'

RSpec.describe "Homes", type: :system do
  before { login }

  describe "#home" do
    let!(:song) { create(:song) }
    let(:random_song_i) { 0 }

    before do
      allow_any_instance_of(HomesController).to receive(:rand).and_return(random_song_i)
      visit root_path
    end

    it "導入文が表示されている" do
      expect(page).to have_selector "#homeSentence"
    end

    it "導入文の中に、ランダムな曲のリンクが機能している" do
      home_sentence = find "#homeSentence"
      random_song = Song.all[random_song_i]
      home_sentence.find_link(
        "ランダムな曲",
        href: song_path(random_song.id, all_songs_list_parent_class: Composer)
      ).click
      expect(current_path).to eq song_path(random_song.id)
    end

    it "アカウント情報変更リンクが機能している" do
      click_link "アカウント情報変更", href: edit_user_registration_path
      expect(current_path).to eq edit_user_registration_path
    end

    it "ログアウトリンクが機能している" do
      click_link "ログアウト", href: destroy_user_session_path
      expect(current_path).to eq new_user_session_path
    end

    # it_behaves_like "Layouts::SongsLists"
  end
end

require 'rails_helper'
require 'system/layouts/songs_lists_spec'

RSpec.describe "Homes", type: :system do
  before { login }

  describe "#home" do
    let!(:song) { song_youtube_search_list.song }
    let!(:song_youtube_search_list) { create(:song_youtube_search_list) }
    let!(:song_with_no_youtube_list) { create(:song) }

    before do
      visit root_path
    end

    it "導入文が表示されている" do
      expect(page).to have_selector "#homeSentence"
    end

    describe "ランダムな曲" do
      context "YoutubeSearchListを持つSongと、持たないSongがある場合" do
        it "YoutubeSearchListを持つSongが優先的に選ばれる" do
          link = page.find_link("ランダムな曲")
          expect(link[:href].include?(song_path(song.id))).to be true
        end
      end

      context "YoutubeSearchListを持たないSongしかない場合" do
        it "Song.firstが選ばれる" do
          link = page.find_link("ランダムな曲")
          expect(link[:href].include?(song_path(Song.first))).to be true
        end
      end

      it "導入文の中に、ランダムな曲のリンクが機能している" do
        home_sentence = find "#homeSentence"
        link = home_sentence.find_link("ランダムな曲")
        link.click
        expect(current_path).to eq song_path(song.id)
      end
    end

    it "アカウント情報変更リンクが機能している" do
      click_link "アカウント情報変更", href: edit_user_registration_path
      expect(current_path).to eq edit_user_registration_path
    end

    it "ログアウトリンクが機能している" do
      click_link "ログアウト", href: destroy_user_session_path
      expect(current_path).to eq new_user_session_path
    end

    it_behaves_like "Layouts::SongsLists"
  end
end

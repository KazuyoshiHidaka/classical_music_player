require 'rails_helper'
require 'system/layouts/songs_lists_spec'

RSpec.describe "Songs", type: :system do
  let(:user) { create(:user) }

  before { login(user: user) }

  describe "/songs/:id" do
    let!(:song) { create(:song) }
    let!(:setting) { create(:setting) }

    before do
      allow_get_youtube_videos
      visit song_path(song.id)
    end

    it "期待するyoutubeの動画が表示されている" do
      items = Apis::Youtube.new.hash_mock_response_search_videos[:items]
      aggregate_failures do
        items.each do |item|
          id = item.dig(:id, :video_id)
          expect(page.has_selector?("iframe[src='https://www.youtube.com/embed/#{id}']")).to be true
        end
      end
    end

    it "songのcomposer, composition付きタイトルが表示されている" do
      expect(page).to have_content song.title_with(composer: true, composition: true)
    end

    it_behaves_like "Layouts::SongsLists"

    shared_examples "UserSettings" do
      def click_setting_checkbox
        checkbox = page.find(
          "#userSettings form input[type='checkbox']"
        )
        form_action = if checkbox.checked?
                        setting_create_setting_user_path(setting.id)
                      else
                        setting_destroy_setting_user_path(setting.id)
                      end
        checkbox.click
        page.find "#userSettings form[action='#{form_action}']"
      end

      it "Settingの情報が表示されている" do
        expect(page).to have_content setting.description
      end

      context "Settingのcheckboxをクリックした時" do
        before { click_setting_checkbox }

        it "Settingとcurrent_userの関連レコードが作成されている" do
          expect(user.settings.exists?(setting.id)).to be true
        end

        it "destroy_setting_user_formが表示されている" do
          expect(page).to have_selector(
            "#userSettings form[" \
              "action='#{setting_destroy_setting_user_path(setting.id)}'" \
            "]"
          )
        end

        context "さらにクリックしたとき" do
          before { click_setting_checkbox }

          it "Settingとcurrent_userの関連レコードが削除されている" do
            expect(user.settings.exists?(setting.id)).to be false
          end

          it "create_setting_user_formが表示されている" do
            expect(page).to have_selector(
              "#userSettings form[" \
                "action='#{setting_create_setting_user_path(setting.id)}'" \
              "]"
            )
          end
        end
      end
    end

    it_behaves_like "UserSettings"

    describe "レスポンシブ対応のテスト" do
      context "画面の横幅が992px未満の時" do
        before do
          current_window.resize_to(991, 700)
        end

        after do
          current_window.resize_to(1200, 900)
        end

        describe "UserSettingsがモーダルで表示されているか" do
          before do
            button = page.find "[data-toggle='modal'][data-target='#userSettingsModal']"
            button.click
          end

          it_behaves_like "UserSettings"
        end
      end
    end
  end
end

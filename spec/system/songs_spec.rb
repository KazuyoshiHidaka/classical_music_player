require 'rails_helper'
require 'system/shared_widgets/all_songs_list_spec'

RSpec.describe "Songs", type: :system do
  describe "/songs/:id" do
    let(:song) { create(:song) }

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

    it_behaves_like "SharedWidgets::AllSongsList"

    describe "レスポンシブ対応のテスト" do
      shared_examples "モーダルで表示されているか" do |widget_name, target_id|
        let(:in_modal) { true }

        before do
          button = page.find "[data-toggle='modal'][data-target='##{target_id}']"
          button.click
        end

        it_behaves_like widget_name
      end

      context "画面の横幅が768px未満の時" do
        before do
          current_window.resize_to(767, 500)
        end

        it_behaves_like "モーダルで表示されているか",
                        "SharedWidgets::AllSongsList",
                        "songsListModal"
      end
    end
  end
end

require 'rails_helper'

RSpec.describe "Songs", type: :system do
  describe "/songs/:id" do
    let(:song) { create(:song) }

    it "期待するyoutubeの動画が表示されている" do
      allow_any_instance_of(SongsController).to receive(:get_videos).
        and_return(Apis::Youtube.new.hash_mock_response_search_videos)
      visit song_path(song.id)

      items = Apis::Youtube.new.hash_mock_response_search_videos[:items]
      aggregate_failures do
        items.each do |item|
          id = item.dig(:id, :video_id)
          expect(page.has_selector?("iframe[src='https://www.youtube.com/embed/#{id}']")).to be true
        end
      end
    end
  end
end

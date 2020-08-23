require 'system/shared_widgets/songs_lists_spec'

RSpec.shared_examples "Layouts::SongsLists" do
  let(:parent_container_name) { "sidebar" }
  it_behaves_like "SharedWidgets::SongsLists"

  describe "レスポンシブ対応のテスト" do
    context "画面の横幅が768px未満の時" do
      before do
        current_window.resize_to(767, 500)
      end

      after do
        current_window.resize_to(1200, 900)
      end

      describe "モーダルで表示されるか" do
        def open_modal
          button = page.find "[data-toggle='modal'][data-target='#songsListsModal']"
          button.click
        end

        let(:parent_container_name) { "modal" }

        before { open_modal }

        it_behaves_like "SharedWidgets::SongsLists"
      end
    end
  end
end

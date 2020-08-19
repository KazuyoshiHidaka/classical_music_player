RSpec.configure do |config|
  config.include ApplicationHelper, type: :system
end

RSpec.shared_examples "SharedWidgets::AllSongsList" do
  let(:composer) { song.composer }
  let(:composition) { song.composition }
  let(:in_modal) { false } unless method_defined?(:in_modal)

  shared_examples "songタブの共通テスト" do
    context "クリックした時" do
      before do
        click_song_tab

        if in_modal
          button = page.find "[data-toggle='modal'][data-target='#songsListModal']"
          button.click
        end
      end

      it "song詳細画面が表示される", js: true do
        expect(current_path).to eq song_path(song.id)
      end

      it "遷移後、クリックしたsongタブが表示された状態になっている", js: true do
        expect(page).to have_link song.title
      end

      it "遷移後、クリックしたsongタブが .border-left-blue classを持っている", js: true do
        expect(page.find_link(song.title)).to match_css ".border-left-blue"
      end
    end
  end

  describe "composer_songs_list" do
    def click_composer_tab
      page.find_link(composer.name.titleize).click
    end

    def click_composition_tab
      click_composer_tab

      id = "##{songs_list_collapse_id(parent_id: composer.id, is_parent_composer: true)}"
      page.find(id).find_link(composition.name.titleize).click
    end

    def click_song_tab
      click_composition_tab

      id = "##{
          songs_list_collapse_id(
            parent_id: composer.id, child_id: composition.id, is_parent_composer: true
          )
        }"
      allow_get_youtube_videos
      page.find(id).find_link(song.title).click
    end

    describe "composerタブ" do
      it "表示されている", js: true do
        expect(page).to have_link composer.name.titleize
      end

      it "クリックした時, compositionタブが表示される", js: true do
        click_composer_tab

        id = "##{
          songs_list_collapse_id(parent_id: composer.id, is_parent_composer: true)
        }"
        expect(page.find(id)).to have_link composition.name.titleize
      end
    end

    describe "compositionタブ" do
      it "クリックした時, songタブが表示される", js: true do
        click_composition_tab

        id = "##{
            songs_list_collapse_id(
              parent_id: composer.id, child_id: composition.id,
              is_parent_composer: true
            )
          }"
        expect(page.find(id)).to have_link song.title
      end
    end

    it_behaves_like "songタブの共通テスト"
  end

  describe "composition_songs_list" do
    def click_composition_tab
      page.find_link(composition.name.titleize).click
    end

    def click_composer_tab
      click_composition_tab

      id = "##{songs_list_collapse_id(parent_id: composition.id, is_parent_composition: true)}"
      page.find(id).find_link(composer.name.titleize).click
    end

    def click_song_tab
      click_composer_tab

      id = "##{
          songs_list_collapse_id(
            parent_id: composition.id, child_id: composer.id, is_parent_composition: true
          )
        }"
      allow_get_youtube_videos
      page.find(id).find_link(song.title).click
    end

    describe "compositionタブ" do
      it "表示されている", js: true do
        expect(page).to have_link composition.name.titleize
      end

      it "クリックした時, composerタブが表示される", js: true do
        click_composition_tab

        id = "##{
          songs_list_collapse_id(parent_id: composition.id, is_parent_composition: true)
        }"
        expect(page.find(id)).to have_link composer.name.titleize
      end
    end

    describe "composerタブ" do
      it "クリックした時, songタブが表示される", js: true do
        click_composer_tab

        id = "##{
            songs_list_collapse_id(
              parent_id: composition.id, child_id: composer.id,
              is_parent_composition: true
            )
          }"
        expect(page.find(id)).to have_link song.title
      end
    end

    it_behaves_like "songタブの共通テスト"
  end
end

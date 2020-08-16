RSpec.configure do |config|
  config.include ApplicationHelper, type: :system
end

RSpec.shared_examples "SharedWidgets::AllSongsList", type: :system do
  let(:composer) { song.composer }
  let(:composition) { song.composition }
  let!(:song) { create(:song) }

  before { visit current_path }

  describe "composer_songs_list" do
    def click_composer_tab
      page.find_link(composer.name.titleize).click
    end

    def click_composition_tab
      click_composer_tab

      id = "##{sidebar_collapse_id(parent_id: composer.id, is_parent_composer: true)}"
      page.find(id).find_link(composition.name.titleize).click
    end

    def click_song_tab
      click_composition_tab

      id = "##{
          sidebar_collapse_id(
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
          sidebar_collapse_id(parent_id: composer.id, is_parent_composer: true)
        }"
        expect(page.find(id)).to have_link composition.name.titleize
      end
    end

    describe "compositionタブ" do
      it "クリックした時, songタブが表示される", js: true do
        click_composition_tab

        id = "##{
            sidebar_collapse_id(
              parent_id: composer.id, child_id: composition.id,
              is_parent_composer: true
            )
          }"
        expect(page.find(id)).to have_link song.title
      end
    end

    describe "songタブ" do
      it "クリックした時, song詳細画面が表示される", js: true do
        click_song_tab
        expect(current_path).to eq song_path(song.id)
      end
    end
  end

  describe "composition_songs_list" do
    def click_composition_tab
      page.find_link(composition.name.titleize).click
    end

    def click_composer_tab
      click_composition_tab

      id = "##{sidebar_collapse_id(parent_id: composition.id, is_parent_composition: true)}"
      page.find(id).find_link(composer.name.titleize).click
    end

    def click_song_tab
      click_composer_tab

      id = "##{
          sidebar_collapse_id(
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
          sidebar_collapse_id(parent_id: composition.id, is_parent_composition: true)
        }"
        expect(page.find(id)).to have_link composer.name.titleize
      end
    end

    describe "composerタブ" do
      it "クリックした時, songタブが表示される", js: true do
        click_composer_tab

        id = "##{
            sidebar_collapse_id(
              parent_id: composition.id, child_id: composer.id,
              is_parent_composition: true
            )
          }"
        expect(page.find(id)).to have_link song.title
      end
    end

    describe "songタブ" do
      it "クリックした時, song詳細画面が表示される", js: true do
        click_song_tab
        expect(current_path).to eq song_path(song.id)
      end
    end
  end
end

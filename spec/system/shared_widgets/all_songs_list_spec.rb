RSpec.configure do |config|
  config.include ApplicationHelper, type: :system
end

RSpec.shared_examples "SharedWidgets::AllSongsList" do
  let(:composer) { song.composer }
  let(:composition) { song.composition }

  shared_examples "songタブの共通テスト" do
    context "クリックした時" do
      before do
        click_song_tab
      end

      describe "AllSongsListウィジェット外のテスト" do
        it "次の曲のリンクが表示されている" do
          next_song_link_container = page.find '#nextSongLink'
          expect(next_song_link_container).to have_link(
            song.decorate.next_song_in_all_songs_list(parent_class: all_songs_list_parent_class).
            decorate.title_with(composer: true, composition: true)
          )
        end
      end

      describe "AllSongsListウィジェット内のテスト" do
        before do
          open_modal if defined? open_modal
          open_all_songs_list_tab if defined? open_all_songs_list_tab
        end

        let(:list) { page.find "#allSongsList" }

        it "song詳細画面が表示される" do
          expect(current_path).to eq song_path(song.id)
        end

        it "遷移後、クリックしたsongタブが .border-left-blue classを持っている" do
          expect(list).to have_link song.title, class: "border-left-blue"
        end
      end
    end
  end

  describe "composer_songs_list" do
    let(:all_songs_list_parent_class) { Composer }

    def click_composer_tab
      page.find_link(composer.name.titleize).click
    end

    def click_composition_tab
      click_composer_tab

      id = "##{all_songs_list_collapse_id(parent_id: composer.id, is_parent_composer: true)}"
      page.find(id).find_link(composition.name.titleize).click
    end

    def click_song_tab
      click_composition_tab

      id = "##{
          all_songs_list_collapse_id(
            parent_id: composer.id, child_id: composition.id, is_parent_composer: true
          )
        }"
      allow_get_youtube_videos
      page.find(id).find_link(song.title).click
    end

    describe "composerタブ" do
      it "表示されている" do
        expect(page).to have_link composer.name.titleize
      end

      it "クリックした時, compositionタブが表示される" do
        click_composer_tab

        id = "##{
          all_songs_list_collapse_id(parent_id: composer.id, is_parent_composer: true)
        }"
        expect(page.find(id)).to have_link composition.name.titleize
      end
    end

    describe "compositionタブ" do
      it "クリックした時, songタブが表示される" do
        click_composition_tab

        id = "##{
            all_songs_list_collapse_id(
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
    let(:all_songs_list_parent_class) { Composition }

    def click_composition_tab
      page.find_link(composition.name.titleize).click
    end

    def click_composer_tab
      click_composition_tab

      id = "##{all_songs_list_collapse_id(parent_id: composition.id, is_parent_composition: true)}"
      page.find(id).find_link(composer.name.titleize).click
    end

    def click_song_tab
      click_composer_tab

      id = "##{
          all_songs_list_collapse_id(
            parent_id: composition.id, child_id: composer.id, is_parent_composition: true
          )
        }"
      allow_get_youtube_videos
      page.find(id).find_link(song.title).click
    end

    describe "compositionタブ" do
      it "表示されている" do
        expect(page).to have_link composition.name.titleize
      end

      it "クリックした時, composerタブが表示される" do
        click_composition_tab

        id = "##{
          all_songs_list_collapse_id(parent_id: composition.id, is_parent_composition: true)
        }"
        expect(page.find(id)).to have_link composer.name.titleize
      end
    end

    describe "composerタブ" do
      it "クリックした時, songタブが表示される" do
        click_composer_tab

        id = "##{
            all_songs_list_collapse_id(
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

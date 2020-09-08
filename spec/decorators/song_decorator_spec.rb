require 'rails_helper'

RSpec.describe SongDecorator do
  describe "#title_with" do
    subject do
      song.decorate.title_with(composer: with_composer, composition: with_composition)
    end

    let(:song) { create(:song) }

    context "引数を指定しなかった場合" do
      it "ArgumentErrorが発生する" do
        expect { song.decorate.title_with }.to raise_error ArgumentError
      end
    end

    context "with_composer: false, with_composition: false" do
      let(:with_composer) { false }
      let(:with_composition) { false }

      it "ArgumentErrorが発生する" do
        expect { subject }.to raise_error ArgumentError
      end
    end

    context "with_composer: trueの場合" do
      let(:with_composer) { true }
      let(:with_composition) { false }

      it "'composerの名前 songのタイトル'を返す" do
        is_expected.to eq(
          "#{song.composer.name.titleize} #{song.title}"
        )
      end
    end

    context "with_composition: trueの場合" do
      let(:with_composer) { false }
      let(:with_composition) { true }

      it "'compositionの名前 songのタイトル'を返す" do
        is_expected.to eq(
          "#{song.composition.name.titleize} #{song.title}"
        )
      end
    end

    context "with_composer: true, with_composition: trueの場合" do
      let(:with_composer) { true }
      let(:with_composition) { true }

      it "'composerの名前 compositionの名前 songのタイトル'を返す" do
        is_expected.to eq(
          "#{song.composer.name.titleize} " \
          "#{song.composition.name.titleize} " +
          song.title
        )
      end
    end
  end

  describe "#all_songs_list_link_id" do
    subject { song.decorate.all_songs_list_link_id(parent_class: parent_class) }

    let(:song) { create(:song) }

    context ":parent_classを与えなかった場合" do
      it "ArgumentErrorが発生する" do
        expect { song.decorate.all_songs_list_link_id }.to(
          raise_error ArgumentError
        )
      end
    end

    context "parent_class: nilを与えた場合" do
      let(:parent_class) { nil }

      it "ArgumentErrorが発生する" do
        expect { subject }.to raise_error ArgumentError
      end
    end

    context "parent_class: Composer,Composition以外の値を与えた場合" do
      let(:parent_class) { Song }

      it "ArgumentErrorが発生する" do
        expect { subject }.to raise_error ArgumentError
      end
    end

    context "parent_class: ComposerかCompositionを与えた場合" do
      let(:parent_class) { Composer }

      it "期待する文字列を返す" do
        is_expected.to eq "ComposerSongsListSong#{song.id}Link"
      end
    end
  end

  describe "#next_song_in_all_songs_list" do
    subject { song.decorate.next_song_in_all_songs_list(parent_class: parent_class) }

    let(:song) { create(:song) }

    context ":parent_classを与えなかった場合" do
      it "ArgumentErrorが発生する" do
        expect { song.decorate.next_song_in_all_songs_list }.to(
          raise_error ArgumentError
        )
      end
    end

    context "parent_class: nilを与えた場合" do
      let(:parent_class) { nil }

      it "nilを返す" do
        is_expected.to be nil
      end
    end

    context "parent_class: Composer,Composition以外の値を与えた場合" do
      let(:parent_class) { Song }

      it "ArgumentErrorが発生する" do
        expect { subject }.to raise_error ArgumentError
      end
    end

    context "parent_class: Composerを与えた場合" do
      let(:parent_class) { Composer }

      it "期待するnext songが取得できる" do
        is_expected.to eq(
          song.next_in(collection: Song.decorator_class.songs_index_in_composer_songs_list)
        )
      end
    end

    context "parent_class: Compositionを与えた場合" do
      let(:parent_class) { Composition }

      it "期待するnext songが取得できる" do
        is_expected.to eq(
          song.next_in(collection: Song.decorator_class.songs_index_in_composition_songs_list)
        )
      end
    end
  end

  describe "#self.songs_index_in_composer_songs_list" do
    subject { Song.decorator_class.songs_index_in_composer_songs_list }

    let(:first_composer) { create(:composer, name: "a") }
    let(:last_composer) { create(:composer, name: "b") }
    let(:first_composition) { create(:composition, name: "a") }
    let(:last_composition) { create(:composition, name: "b") }
    let!(:song) do
      create(:song, composer: last_composer, composition: last_composition)
    end
    let!(:second_song) do
      create(:song, composer: first_composer, composition: last_composition)
    end
    let!(:third_song) do
      create(:song, composer: last_composer, composition: first_composition)
    end

    it "SongCollectionが期待する並び順になっている" do
      aggregate_failures do
        expect(subject.first).to eq second_song
        expect(subject.second).to eq third_song
        expect(subject.third).to eq song
      end
    end
  end

  describe "#self.songs_index_in_composer_songs_list" do
    subject { Song.decorator_class.songs_index_in_composition_songs_list }

    let(:first_composition) { create(:composition, name: "a") }
    let(:last_composition) { create(:composition, name: "b") }
    let(:first_composer) { create(:composer, name: "a") }
    let(:last_composer) { create(:composer, name: "b") }
    let!(:song) do
      create(:song, composer: last_composer, composition: last_composition)
    end
    let!(:second_song) do
      create(:song, composer: first_composer, composition: last_composition)
    end
    let!(:third_song) do
      create(:song, composer: last_composer, composition: first_composition)
    end

    it "SongCollectionが期待する並び順になっている" do
      aggregate_failures do
        expect(subject.first).to eq third_song
        expect(subject.second).to eq second_song
        expect(subject.third).to eq song
      end
    end
  end
end

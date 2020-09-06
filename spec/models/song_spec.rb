require 'rails_helper'

RSpec.describe Song, type: :model do
  describe "Validation" do
    subject { song.valid? }

    describe "title:string" do
      context "nilの場合" do
        let(:song) { build(:song, title: nil) }

        it_behaves_like '無効になる'
      end

      context "空文字の場合" do
        let(:song) { build(:song, title: '') }

        it_behaves_like '無効になる'
      end
    end

    context "有効な値のみの場合" do
      let(:song) { build(:song) }

      it_behaves_like '有効になる'
    end
  end

  describe "Instance Methods" do
    describe "#next_in" do
      subject { song.next_in(collection: collection) }

      context "collection中の最初のSongの場合" do
        let!(:songs) { create_list(:song, 3) }
        let(:song) { songs.first }
        let(:collection) { Song.all }

        it "最初から2番目のSongを取得する" do
          is_expected.to eq songs.second
        end
      end

      context "collection中の最後のSongの場合" do
        let!(:songs) { create_list(:song, 3) }
        let(:song) { songs.last }
        let(:collection) { Song.all }

        it "最初のSongを取得する" do
          is_expected.to eq songs.first
        end
      end

      context "collectionの並び順を反対にした場合" do
        let!(:songs) { create_list(:song, 3) }
        let(:song) { songs.last }
        let(:collection) { Song.order(id: :desc) }

        it "期待するNextSongを取得する" do
          is_expected.to eq songs.second
        end
      end
    end
  end
end

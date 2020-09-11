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

    describe "#search_and_save_youtube_video_ids" do
      subject { song.youtube_search_list.video_ids }

      let(:mock_video_ids) { Apis::Youtube.new.mock_video_ids }

      before do
        allow_any_instance_of(Apis::Youtube).to receive(:search_video_ids).
          and_return(Apis::Youtube.new.mock_video_ids)
        song.search_and_save_youtube_video_ids
      end

      context "youtube_search_listを持っていた場合" do
        let(:song) { song_youtube_search_list.song }
        let(:song_youtube_search_list) { create(:song_youtube_search_list) }

        it "youtube_search_listが更新されている" do
          is_expected.to eq mock_video_ids
        end
      end

      context "youtube_search_listを持っていなかった場合" do
        let(:song) { create(:song) }

        it "youtube_search_listが作成されている" do
          is_expected.to eq mock_video_ids
        end
      end
    end
  end
end

require 'rails_helper'

RSpec.describe Song, type: :model do
  let(:song) { create(:song) }

  describe "Validation" do
    subject { song_invalid.valid? }

    context "titleがnilの場合" do
      let(:song_invalid) { build(:song, title: nil) }

      it "無効になる" do
        is_expected.to be false
      end
    end

    context "titleが空白の場合" do
      let(:song_invalid) { build(:song, title: '') }

      it "無効になる" do
        is_expected.to be false
      end
    end

    describe "複合キー[composer_id, composition_id, title]" do
      context "キーが重複する場合" do
        let(:song_invalid) do
          build(:song,
                composer_id: song.composer_id,
                composition_id: song.composition_id,
                title: song.title)
        end

        it "無効になる" do
          is_expected.to be false
        end
      end

      context "キーが重複しない場合" do
        it "有効になる" do
          aggregate_failures do
            songs = [
              # rubocop:disable Metrics/LineLength
              ["song_dup_composer",                 build(:song, composer_id: song.composer_id)],
              ["song_dup_composition",              build(:song, composition_id: song.composition_id)],
              ["song_dup_title",                    build(:song, title: song.title)],
              ["song_dup_composer_and_composition", build(:song, composer_id: song.composer_id, composition_id: song.composition_id)],
              ["song_dup_composer_and_title",       build(:song, composer_id: song.composer_id, title: song.title)],
              ["song_dup_composition_and_title",    build(:song, composition_id: song.composition_id, title: song.title)],
              # rubocop:enable Metrics/LineLength
            ]
            songs.each do |type, song|
              expect(song.valid?).to be(true), "無効になったsongの種類: #{type}"
            end
          end
        end
      end
    end

    context "正常な値のみの場合" do
      let(:song_valid) { build(:song) }

      it "有効になる" do
        expect(song_valid.valid?).to be true
      end
    end
  end
end

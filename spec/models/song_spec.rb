require 'rails_helper'

RSpec.describe Song, type: :model do
  describe "Validation" do
    subject { song.valid? }

    shared_examples '有効になる' do
      it { is_expected.to be true }
    end

    shared_examples '無効になる' do
      it { is_expected.to be false }
    end

    describe "opus:stringカラム" do
      context "空文字の場合" do
        let(:song) { build(:song, opus: '') }

        it_behaves_like '無効になる'
      end

      context "nilの場合" do
        let(:song) { build(:song, opus: nil) }

        it_behaves_like '無効になる'
      end

      context "整数以外の場合" do
        let(:song) { build(:song, opus: 1.1) }

        it_behaves_like '無効になる'
      end

      context "0の場合" do
        let(:song) { build(:song, opus: 0) }

        it_behaves_like '無効になる'
      end

      context "整数の場合" do
        let(:song) { build(:song, opus: 1) }

        it_behaves_like '有効になる'
      end

      context "'posthumous'以外の文字列の場合" do
        let(:song) { build(:song, opus: "opus") }

        it_behaves_like '無効になる'
      end

      context "'posthumous'の場合" do
        let(:song) { build(:song, :posthumous) }

        it_behaves_like '有効になる'
      end
    end

    describe "number:integerカラム" do
      context "整数以外の場合" do
        let(:song) { build(:song, number: 1.1) }

        it_behaves_like '無効になる'
      end

      context "0の場合" do
        let(:song) { build(:song, opus: 0) }

        it_behaves_like '無効になる'
      end

      context "整数の場合" do
        let(:song) { build(:song, number: 1) }

        it_behaves_like '有効になる'
      end

      context "nilの場合" do
        let(:composer) { create(:composer) }
        let(:composition) { create(:composition) }
        let(:song) do
          build(:song, :no_number, composer_id: composer.id, composition_id: composition.id)
        end

        context "同じcomposer, 同じcompositionのSongレコードが他にある場合" do
          before do
            create(:song, composer_id: composer.id, composition_id: composition.id)
          end

          it_behaves_like '無効になる'
        end

        context "同じcomposer, 同じcompositionのSongレコードが他にない場合" do
          it_behaves_like '有効になる'
        end
      end
    end

    describe "複合キー[composer_id, opus, number]" do
      context "キーが重複する場合" do
        let(:song_valid) { create(:song) }
        let(:song) do
          build(:song,
                composer_id: song_valid.composer_id,
                opus: song_valid.opus,
                number: song_valid.number)
        end

        it_behaves_like '無効になる'
      end

      context "キーが重複しない場合" do
        let(:song) { create(:song) }

        it "有効になる" do
          aggregate_failures "複合キーの組み合わせの中に、別の一意制約のキーが入っていない" do
            songs = [
              ["song_dup_composer",            build(:song, composer_id: song.composer_id)],
              ["song_dup_opus",                build(:song, opus: song.opus)],
              ["song_dup_number",              build(:song, number: song.number)],
              ["song_dup_composer_and_opus",   build(:song, composer_id: song.composer_id, opus: song.opus)], # rubocop:disable LineLength
              ["song_dup_composer_and_number", build(:song, composer_id: song.composer_id, number: song.number)], # rubocop:disable LineLength
              ["song_dup_opus_and_number",     build(:song, opus: song.opus, number: song.number)],
            ]
            songs.each do |type, song|
              expect(song.valid?).to be(true), "無効になったsongの種類: #{type}"
            end
          end
        end
      end
    end

    context "有効な値のみの場合" do
      let(:song) { build(:song) }

      it_behaves_like '有効になる'
    end
  end

  describe "Instance Methods" do
    describe "#query_to_search_youtube" do
      subject { song.query_to_search_youtube }

      let(:composer) { song.composer }
      let(:composition) { song.composition }

      context "opusがposthumousの場合" do
        let(:song) { create(:song, :posthumous) }

        it "値はcomposer composition posthumous numberとなる" do
          is_expected.to eq "#{composer.name} #{composition.name} #{song.opus} #{song.number}"
        end
      end

      context "opusがposthumous以外の場合" do
        context "numberがnilの場合" do
          let(:song) { create(:song, :no_number) }

          it "値はcomposer composition op opusとなる" do
            is_expected.to eq "#{composer.name} #{composition.name} op #{song.opus}"
          end
        end

        context "numberがnil以外の場合" do
          let(:song) { create(:song) }

          it "値はcomposer composition op opus no numberとなる" do
            is_expected.to eq(
              "#{composer.name} #{composition.name} op #{song.opus} no #{song.number}"
            )
          end
        end
      end

      context "alt_nameがnil以外の場合" do
        let(:song) { create(:song, :alt_name) }

        it "値はcomposer composition op opus no number alt_nameとなる" do
          is_expected.to eq(
            "#{composer.name} #{composition.name} op #{song.opus} no #{song.number} #{song.alt_name}" # rubocop:disable Metrics/LineLength
          )
        end
      end
    end
  end
end

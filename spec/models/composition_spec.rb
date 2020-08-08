require 'rails_helper'

RSpec.describe Composition, type: :model do
  describe "Association" do
    let(:composition) { create(:composition) }
    let(:composer) { create(:composer) }
    let!(:song_list) do
      create_list(:song, 2,
                  composition_id: composition.id,
                  composer_id: composer.id)
    end

    it "compositionが重複せず取得できる" do
      expect(composition.composers).to match_array composition.composers.distinct
    end

    it "songsが取得できる" do
      expect(composition.songs).to match_array song_list
    end
  end

  describe "Validation" do
    subject { composition.valid? }

    shared_examples '有効になる' do
      it { is_expected.to be true }
    end

    shared_examples '無効になる' do
      it { is_expected.to be false }
    end

    context "nameがnilの場合" do
      let(:composition) { build(:composition, name: nil) }

      it_behaves_like "無効になる"
    end

    context "nameが空白の場合" do
      let(:composition) { build(:composition, name: '') }

      it_behaves_like "無効になる"
    end

    context "nameが重複する場合" do
      let(:composition_valid) { create(:composition) }
      let(:composition) { build(:composition, name: composition_valid.name) }

      it_behaves_like "無効になる"
    end

    context "正常な値のみの場合" do
      let(:composition) { build(:composition) }

      it_behaves_like "有効になる"
    end
  end
end

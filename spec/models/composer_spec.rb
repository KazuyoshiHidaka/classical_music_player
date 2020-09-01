require 'rails_helper'

RSpec.describe Composer, type: :model do
  describe "Association" do
    let(:composer) { create(:composer) }
    let(:composition) { create(:composition) }
    let!(:song_list) do
      create_list(:song, 2,
                  composer_id: composer.id,
                  composition_id: composition.id)
    end

    it "compositionが重複せず取得できる" do
      expect(composer.compositions).to match_array composer.compositions.distinct
    end

    it "songsが取得できる" do
      expect(composer.songs).to match_array song_list
    end
  end

  describe "Validation" do
    subject { composer.valid? }

    context "nameがnilの場合" do
      let(:composer) { build(:composer, name: nil) }

      it_behaves_like "無効になる"
    end

    context "nameが空白の場合" do
      let(:composer) { build(:composer, name: '') }

      it_behaves_like "無効になる"
    end

    context "nameが重複する場合" do
      let(:composer_valid) { create(:composer) }
      let(:composer) { build(:composer, name: composer_valid.name) }

      it_behaves_like "無効になる"
    end

    context "正常な値のみの場合" do
      let(:composer) { build(:composer) }

      it_behaves_like "有効になる"
    end
  end
end

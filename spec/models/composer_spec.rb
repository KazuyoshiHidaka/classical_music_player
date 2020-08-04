require 'rails_helper'

RSpec.describe Composer, type: :model do
  let(:composer) { create(:composer) }

  describe "Validation" do
    subject { composer_invalid.valid? }

    context "nameがnilの場合" do
      let(:composer_invalid) { build(:composer, name: nil) }

      it "無効になる" do
        is_expected.to be false
      end
    end

    context "nameが空白の場合" do
      let(:composer_invalid) { build(:composer, name: '') }

      it "無効になる" do
        is_expected.to be false
      end
    end

    context "nameが重複する場合" do
      let(:composer_invalid) { build(:composer, name: composer.name) }

      it "無効になる" do
        is_expected.to be false
      end
    end

    context "正常な値のみの場合" do
      let(:composer_valid) { build(:composer) }

      it "有効になる" do
        expect(composer_valid.valid?).to be true
      end
    end
  end
end

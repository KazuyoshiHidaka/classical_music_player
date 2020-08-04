require 'rails_helper'

RSpec.describe Composition, type: :model do
  let(:composition) { create(:composition) }

  describe "Validation" do
    subject { composition_invalid.valid? }

    context "nameがnilの場合" do
      let(:composition_invalid) { build(:composition, name: nil) }

      it "無効になる" do
        is_expected.to be false
      end
    end

    context "nameが空白の場合" do
      let(:composition_invalid) { build(:composition, name: '') }

      it "無効になる" do
        is_expected.to be false
      end
    end

    context "nameが重複する場合" do
      let(:composition_invalid) { build(:composition, name: composition.name) }

      it "無効になる" do
        is_expected.to be false
      end
    end

    context "正常な値のみの場合" do
      let(:composition_valid) { build(:composition) }

      it "有効になる" do
        expect(composition_valid.valid?).to be true
      end
    end
  end
end

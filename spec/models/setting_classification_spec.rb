require 'rails_helper'

RSpec.describe SettingClassification, type: :model do
  describe "Validation" do
    subject { setting_classification.valid? }

    shared_examples '有効になる' do
      it { is_expected.to be true }
    end

    shared_examples '無効になる' do
      it { is_expected.to be false }
    end

    describe "id:integer" do
      context "nilを与えた場合" do
        let(:setting_classification) { build(:setting_classification, id: nil) }

        it_behaves_like '無効になる'
      end

      context "0を与えた場合" do
        let(:setting_classification) { build(:setting_classification, id: 0) }

        it_behaves_like '無効になる'
      end

      context "他のレコードと値が重複する場合" do
        let(:other_setting_classification) { create(:setting_classification) }
        let(:setting_classification) { build(:setting_classification, id: other_setting_classification.id) }

        it_behaves_like '無効になる'
      end

      context "小数を与えた場合" do
        let(:setting_classification) { build(:setting_classification, id: 0.1) }

        it_behaves_like '無効になる'
      end

      context "整数を与えた場合" do
        let(:setting_classification) { build(:setting_classification) }

        it_behaves_like '有効になる'
      end
    end

    describe "description:string" do
      context "nilを与えた場合" do
        let(:setting_classification) { build(:setting_classification, description: nil) }

        it_behaves_like '無効になる'
      end

      context "空文字を与えた場合" do
        let(:setting_classification) { build(:setting_classification, description: '') }

        it_behaves_like '無効になる'
      end

      context "他のレコードと値が重複する場合" do
        let(:other_setting_classification) { create(:setting_classification) }
        let(:setting_classification) { build(:setting_classification, description: other_setting_classification.description) }

        it_behaves_like '無効になる'
      end

      context "通常の文字列の場合" do
        let(:setting_classification) { build(:setting_classification) }

        it_behaves_like '有効になる'
      end
    end
  end

  describe "Class Methods" do
    describe "#post_data_to_db" do
      subject do
        SettingClassification.select(:id, :description).map do |setting_classification|
          setting_classification.attributes.symbolize_keys
        end
      end

      before { SettingClassification.post_data_to_db }

      it "dataが保存されている" do
        is_expected.to match_array SettingClassification.data
      end
    end
  end
end

require 'rails_helper'

RSpec.describe UserSetting, type: :model do
  describe "Validation" do
    subject do
      user_setting.valid?
    end

    describe "uniqueness of [:user_id, :setting_classification_id]" do
      context "重複する場合" do
        let(:other_user_setting) { create(:user_setting) }
        let(:setting) do
          create(:setting,
                 setting_classification: other_user_setting.setting_classification)
        end
        let(:user_setting) do
          build(
            :user_setting,
            user: other_user_setting.user,
            setting: setting
          )
        end

        it_behaves_like '無効になる'
      end
    end

    context "正常な値のみの場合" do
      let(:user_setting) do
        build(:user_setting)
      end

      it_behaves_like '有効になる'
    end
  end
end

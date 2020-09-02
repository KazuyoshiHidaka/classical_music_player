require 'rails_helper'

RSpec.describe "UserSettings", type: :request do
  let(:user) { create(:user) }

  before { login(user: user) }

  describe "POST #create" do
    let(:params) do
      { setting_id: setting.id, setting_classification_id: setting.setting_classification_id }
    end

    context "UserSettingがまだなかった場合" do
      let(:setting) { create(:setting) }

      before { post user_settings_path(params), xhr: true }

      it_behaves_like 'HTTP200を返す'

      it "UserSettingが作成されている" do
        expect(user.settings.exists?(setting.id)).to be true
      end
    end

    context "UserSettingがあった場合" do
      let!(:other_setting) do
        create(:setting,
               setting_classification: setting.setting_classification)
      end
      let!(:other_user_setting) do
        create(:user_setting, user: user, setting: other_setting)
      end

      context "同じSettingClassificationに属する別のSettingを登録する時" do
        let(:setting) { create(:setting) }

        before { post user_settings_path(params), xhr: true }

        it_behaves_like 'HTTP200を返す'

        it "UserSettingが更新されている" do
          expect(user.settings.exists?(setting.id)).to be true
        end
      end

      context "UserSettingを削除する場合" do
        let(:setting) { create(:setting) }

        before do
          params.delete(:setting_id)
          post user_settings_path(params), xhr: true
        end

        it_behaves_like 'HTTP200を返す'

        it "UserSettingが削除されている" do
          expect(user.settings.exists?(other_setting.id)).to be false
        end
      end
    end
  end
end

require 'rails_helper'

RSpec.describe "Settings", type: :request do
  let(:user) { create(:user) }

  before { login(user: user) }

  describe "POST #create_setting_user" do
    context "settingとuserの関連レコードが既に存在した場合" do
      let(:setting) { create(:setting, users: [user]) }

      before { post setting_create_setting_user_path(setting.id) }

      it "http_status :no_contentを返す" do
        expect(response).to have_http_status :no_content
      end
    end

    context "settingとuserの関連レコードがなかった場合" do
      let(:setting) { create(:setting) }

      context "format: htmlのレスポンスを要求した場合" do
        before { post setting_create_setting_user_path(setting.id) }

        it "rootにリダイレクトする" do
          expect(response).to redirect_to root_path
        end
      end

      context "format: jsのレスポンスを要求した場合" do
        before { post setting_create_setting_user_path(setting.id), xhr: true }

        it "200レスポンスを返す" do
          expect(response).to have_http_status :ok
        end
      end
    end
  end

  describe "POST #create_setting_user" do
    context "settingとuserの関連レコードが既に存在した場合" do
      let(:setting) { create(:setting, users: [user]) }

      context "format: htmlのレスポンスを要求した場合" do
        before { delete setting_destroy_setting_user_path(setting.id) }

        it "rootにリダイレクトする" do
          expect(response).to redirect_to root_path
        end
      end

      context "format: jsのレスポンスを要求した場合" do
        before { delete setting_destroy_setting_user_path(setting.id), xhr: true }

        it "200レスポンスを返す" do
          expect(response).to have_http_status :ok
        end
      end
    end

    context "settingとuserの関連レコードがなかった場合" do
      let(:setting) { create(:setting) }

      before { delete setting_destroy_setting_user_path(setting.id) }

      it "http_status :no_contentを返す" do
        expect(response).to have_http_status :no_content
      end
    end
  end
end

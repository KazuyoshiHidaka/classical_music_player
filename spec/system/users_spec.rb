require 'rails_helper'

RSpec.describe "Users", type: :system do
  describe "devise" do
    describe "sessions#new" do
      let!(:song) { create(:song) }

      it "ゲストユーザーとしてログインするリンクが機能している" do
        visit new_user_session_path
        click_link "ログインしないで利用する", href: users_sign_in_guest_path
        expect(current_path).to eq root_path
        expect(page).to have_content "ゲストユーザーとしてログインしました。"
      end
    end
  end
end

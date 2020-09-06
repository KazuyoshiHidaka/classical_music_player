require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "devise" do
    describe "POST sessions#sign_in_guest" do
      before { post users_sign_in_guest_path }

      it "rootにリダイレクトする" do
        expect(response).to redirect_to root_path
      end
    end
  end
end

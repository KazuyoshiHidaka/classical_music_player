require 'rails_helper'

RSpec.describe User, type: :model do
  describe "#self.guest" do
    subject { User.guest }

    it "ゲストユーザーが返る" do
      expect(subject.is_guest).to be true
    end
  end
end

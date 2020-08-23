RSpec.shared_examples "SharedWidgets::UserLikedSongsList" do
  it "表示されている" do
    expect(page).to have_selector "#userLikedSongsList"
  end
end

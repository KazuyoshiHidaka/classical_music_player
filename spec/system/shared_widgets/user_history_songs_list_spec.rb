RSpec.shared_examples "SharedWidgets::UserHistorySongsList" do
  it "表示されている" do
    expect(page).to have_selector "#userHistorySongsList"
  end
end

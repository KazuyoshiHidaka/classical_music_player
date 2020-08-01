require 'rails_helper'

RSpec.describe "Examples", type: :system do
  it "example rack test" do
    visit '/'
  end

  it "example browser test", js: true do
    visit '/'
  end
end

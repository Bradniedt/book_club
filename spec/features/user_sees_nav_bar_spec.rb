require "rails_helper"

describe "As a visitor" do
  describe "when I visit /" do
    it "sees link to home page" do
      visit '/'

      expect(page).to have_link('Home', href: "/")
    end
  end
end

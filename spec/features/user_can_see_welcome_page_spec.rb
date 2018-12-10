require "rails_helper"

describe "as a user" do
  describe "when I visit the home page" do
    it "should show a welcome message" do
      visit '/'

      within('.welcome') do
        expect(page).to have_content("Welcome to Book Club!")
      end
    end
    it "should see links to home and all books" do
      visit '/'

      expect(page).to have_link("Home")
      expect(page).to have_link("Books")
    end
  end
end

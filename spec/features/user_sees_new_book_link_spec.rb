require "rails_helper"

describe "As a visitor" do
  describe "when I visit /books" do
    it "should see a link to create a new book" do
      visit '/books'

      expect(page).to have_link("Create a new book!", href: "/books/new")
    end
  end
end

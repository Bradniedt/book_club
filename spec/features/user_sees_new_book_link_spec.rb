require "rails_helper"

describe "As a visitor" do
  describe "when I visit /books" do
    it "should see a link to create a new book" do
      visit '/books'

      expect(page).to have_link("Create a new book!", href: "/books/new")
    end
  end
  describe "when I click visit /books/new" do
    it "should take me to a page with a form to create a book" do
      visit '/books/new'

      expect(page).to have_field("Title")
      expect(page).to have_field("Pages")
      expect(page).to have_field("Year")
      expect(page).to have_field("Authors")
    end
  end
end

require "rails_helper"

describe "As a visitor" do
  describe "when I visit /" do
    it "sees link to home page" do
      visit '/'

      expect(page).to have_link('Home', href: "/")
    end

    it "sees link to browse all books" do
      visit '/books'

      expect(page).to have_link('Books', href: "/books")
    end
  end
end

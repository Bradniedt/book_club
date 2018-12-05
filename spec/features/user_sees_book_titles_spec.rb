require "rails_helper"

describe "As a visitor" do
  describe "when I visit /books" do
    it "should see all book titles" do
      book_1 = Book.create(title: "book_1", pages: 100, author: "me")

      visit '/books'

      expect(page).to have_content(book_1.title)
    end
  end
end 

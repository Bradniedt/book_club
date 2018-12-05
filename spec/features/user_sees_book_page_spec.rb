require "rails_helper"

describe "As a visitor" do
  describe "when I visit /books/show" do
    it "should see all book info" do
      book_1 = Book.create(title: "book_1", pages: 100, author: "me", year: 2018)

      visit book_path(book_1)

      expect(page).to have_content(book_1.title)
      expect(page).to have_content(book_1.pages)
      expect(page).to have_content(book_1.author)
    end
  end
end

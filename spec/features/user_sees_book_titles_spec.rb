require "rails_helper"

describe "As a visitor" do
  describe "when I visit /books" do
    it "should see all book titles" do
      book_1 = Book.create(title: "book_1", pages: 100, author: "me")
      book_2 = Book.create(title: "book_2", pages: 200, author: "you")

      visit books_path

      expect(page).to have_content(book_1.title)
      expect(page).to have_content(book_2.title)
      expect(page).to have_content(book_1.pages)
      expect(page).to have_content(book_2.pages)
      expect(page).to have_content(book_1.author)
      expect(page).to have_content(book_2.author)
    end
  end
end

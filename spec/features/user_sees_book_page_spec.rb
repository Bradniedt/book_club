require "rails_helper"

describe "As a visitor" do
  describe "when I visit /books/show" do
    it "should see all book info" do
      book_1 = Book.create(title: "book_1", pages: 100, year: 1900)
      review_1 = book_1.reviews.create(title: "review_1", description: "ehfladhflad", rating: 4)
      review_2 = book_1.reviews.create(title: "review_2", description: "ehfladhflad", rating: 5)
      author_1 = book_1.authors.create(name: "Author One")

      visit book_path(book_1)

      expect(page).to have_content(book_1.title)
      expect(page).to have_content(book_1.pages)
      expect(page).to have_content(book_1.year)
      expect(page).to have_content(book_1.authors.name)
      expect(page).to have_content(review_1.title)
      expect(page).to have_content(review_1.description)
      expect(page).to have_content(review_1.rating)
    end
  end
end

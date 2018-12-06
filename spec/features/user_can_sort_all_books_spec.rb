require 'rails_helper'

describe 'as a visitor' do
  describe 'when I visit the book index page' do
    it "should let me sort by avg rating in ascending order" do
      book_1 = Book.create(title: "book_1", pages: 100, year: 2000)
      book_2 = Book.create(title: "book_2", pages: 200, year: 2001)
      book_3 = Book.create(title: "book_3", pages: 240, year: 2004)
      review_1 = book_1.reviews.create(title: "good book" , description:"amazing", rating: 5)
      review_2 = book_1.reviews.create(title: "bad book" , description:"lame", rating: 1)
      review_3 = book_2.reviews.create(title: "good book" , description:"amazing", rating: 5)
      review_4 = book_2.reviews.create(title: "not great" , description:"blah", rating: 3)
      review_5 = book_3.reviews.create(title: "good book" , description:"amazing", rating: 4)
      review_6 = book_3.reviews.create(title: "not great" , description:"blah", rating: 2)

      visit books_path

      expect(page).to have_link("avg_rating_ascending")
      click_on "avg_rating_ascending"
    end
  end
end

require 'rails_helper'

describe 'as a visitor' do
  describe 'when I visit the user show page' do
    it 'should show all reviews from that user' do
      book_1 = Book.create(title: "book_1", pages: 100, year: 2000)
      book_2 = Book.create(title: "book_2", pages: 200, year: 2001)
      book_3 = Book.create(title: "book_3", pages: 240, year: 2004)
      user_1 = User.create(name: "Peregrin")
      user_2 = User.create(name: "Merriadoc")

      review_1 = user_1.reviews.create!(title: "good book" , description:"amazing", rating: 5, book: book_1)
      review_2 = user_2.reviews.create!(title: "bad book" , description:"lame", rating: 1, book: book_1)
      review_3 = user_1.reviews.create!(title: "good book" , description:"amazing", rating: 5, book: book_2)
      review_4 = user_2.reviews.create!(title: "not great" , description:"blah", rating: 3, book: book_2)


      visit user_path(user_1)

      expect(page).to have_content(user_1.name)
      expect(page).to have_content(review_1.title)
      expect(page).to have_content(review_3.title)
    end
  end
end

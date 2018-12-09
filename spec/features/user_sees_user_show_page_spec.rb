require 'rails_helper'

describe 'as a visitor' do
  describe 'when I visit the user show page' do
    it 'should show all reviews from that user' do
      book_1 = Book.create(title: "book_1", pages: 100, year: 2000)
      book_2 = Book.create(title: "book_2", pages: 200, year: 2001)
      book_3 = Book.create(title: "book_3", pages: 240, year: 2004)
      user_1 = User.create(name: "Peregrin")
      user_2 = User.create(name: "Merriadoc")
      review_1 = user_1.reviews.create(title: "good book" , description:"amazing", rating: 5)
      review_2 = user_2.reviews.create(title: "bad book" , description:"lame", rating: 1)
      book_1.reviews << [review_1, review_2]
      review_3 = user_1.reviews.create(title: "good book" , description:"amazing", rating: 5)
      review_4 = user_2.reviews.create(title: "not great" , description:"blah", rating: 3)
      book_2.reviews << [review_3, review_4]

      visit user_path(user_1)

      expect(page).to have_content(user_1.name)
      expect(page).to have_content(review_1.title)
      expect(page).to have_content(review_3.title)
    end
    include ActiveSupport::Testing::TimeHelpers
    it 'should show a sort reviews newest first link' do
      book_1 = Book.create(title: "book_1", pages: 100, year: 2000)
      book_2 = Book.create(title: "book_2", pages: 200, year: 2001)
      book_3 = Book.create(title: "book_3", pages: 240, year: 2004)
      user_1 = User.create(name: "Peregrin")

      review_1 = user_1.reviews.create(title: "good book" , description:"amazing", rating: 5, book: book_1)
      review_2 = travel_to 2.days.ago do
        user_1.reviews.create(title: "bad book" , description:"lame", rating: 1, book: book_3)
      end

      review_3 = travel_to 4.days.ago do
        user_1.reviews.create(title: "good book" , description:"amazing", rating: 5, book: book_2)
      end

      visit user_path(user_1)

      expect(page).to have_link("Newest First")
      expect(page).to have_link("Oldest First")

      click_on("Newest First")

      expect(all('.review-box')[0]).to have_content(review_1.title)
      expect(all('.review-box')[1]).to have_content(review_2.title)
      expect(all('.review-box')[2]).to have_content(review_3.title)

      click_on("Oldest First")

      expect(all('.review-box')[0]).to have_content(review_3.title)
      expect(all('.review-box')[1]).to have_content(review_2.title)
      expect(all('.review-box')[2]).to have_content(review_1.title)
    end
  end
end

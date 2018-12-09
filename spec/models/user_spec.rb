require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do

    it { should validate_presence_of(:name) }

  end

  describe 'relationships' do
    it { should have_many(:reviews)}
  end

  describe 'instance methods' do
    it 'review_count' do
      user_1 = User.create(name: "Person One")
      book_1 = Book.create(title: "Book One", pages: 100, year: 2000)
      book_2 = Book.create(title: "Book Two", pages: 101, year: 2001)
      book_3 = Book.create(title: "Book Three", pages: 102, year: 2002)
      review_1 = user_1.reviews.create(title: "good book" , description:"amazing", rating: 5, book: book_1)
      review_2 = user_1.reviews.create(title: "bad book" , description:"lame", rating: 1, book: book_2)
      review_3 = user_1.reviews.create(title: "bad book" , description:"lame", rating: 4, book: book_3)

      expect(user_1.review_count).to eq(3)
    end
  end

  describe 'class methods' do
    it 'top_users' do
      book_1 = Book.create(title: "Book One", pages: 100, year: 2000)
      book_2 = Book.create(title: "Book Two", pages: 100, year: 2000)
      book_3 = Book.create(title: "Book Three", pages: 100, year: 2000)
      book_4 = Book.create(title: "Book Four", pages: 100, year: 2000)

      user_1 = User.create(name: "Person One")
      review_1 = user_1.reviews.create(title: "good book" , description:"amazing", rating: 5, book: book_1)
      review_2 = user_1.reviews.create(title: "bad book" , description:"lame", rating: 1, book: book_2)
      review_3 = user_1.reviews.create(title: "bad book" , description:"lame", rating: 4, book: book_3)
      review_4 = user_1.reviews.create(title: "bad book" , description:"lame", rating: 4, book: book_4)

      user_2 = User.create(name: "Person Two")
      review_5 = user_2.reviews.create(title: "good book" , description:"amazing", rating: 5, book: book_1)
      review_6 = user_2.reviews.create(title: "bad book" , description:"lame", rating: 1, book: book_2)
      review_7 = user_2.reviews.create(title: "bad book" , description:"lame", rating: 1, book: book_3)

      user_3 = User.create(name: "Person Three")
      review_8 = user_3.reviews.create(title: "good book" , description:"amazing", rating: 5, book: book_1)
      review_9 = user_3.reviews.create(title: "good book" , description:"amazing", rating: 5, book: book_2)

      user_4 = User.create(name: "Person One")
      review_10 = user_4.reviews.create(title: "good book" , description:"amazing", rating: 5, book: book_4)

      expect(User.top_users).to eq([user_1, user_2, user_3])
    end
  end
end

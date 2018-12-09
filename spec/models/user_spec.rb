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
      review_1 = user_1.reviews.create(title: "good book" , description:"amazing", rating: 5)
      review_2 = user_1.reviews.create(title: "bad book" , description:"lame", rating: 1)
      review_3 = user_1.reviews.create(title: "bad book" , description:"lame", rating: 4)
      book_1.reviews << [review_1, review_2, review_3]

      expect(user_1.review_count).to eq(3)
    end
  end

  describe 'class methods' do
    it 'top_users' do
      book_1 = Book.create(title: "Book One", pages: 100, year: 2000)
      user_1 = User.create(name: "Person One")
      review_1 = user_1.reviews.create(title: "good book" , description:"amazing", rating: 5)
      review_2 = user_1.reviews.create(title: "bad book" , description:"lame", rating: 1)
      review_3 = user_1.reviews.create(title: "bad book" , description:"lame", rating: 4)
      review_4 = user_1.reviews.create(title: "bad book" , description:"lame", rating: 4)
      book_1.reviews << [review_1, review_2, review_3, review_4]

      user_2 = User.create(name: "Person Two")
      book_2 = Book.create(title: "Book Two", pages: 100, year: 2000)
      review_5 = user_2.reviews.create(title: "good book" , description:"amazing", rating: 5)
      review_6 = user_2.reviews.create(title: "bad book" , description:"lame", rating: 1)
      review_7 = user_2.reviews.create(title: "bad book" , description:"lame", rating: 1)
      book_2.reviews << [review_5, review_6, review_7]

      user_3 = User.create(name: "Person Three")
      book_3 = Book.create(title: "Book Three", pages: 100, year: 2000)
      review_8 = user_3.reviews.create(title: "good book" , description:"amazing", rating: 5)
      review_9 = user_3.reviews.create(title: "good book" , description:"amazing", rating: 5)
      book_3.reviews << [review_8, review_9]

      user_4 = User.create(name: "Person One")
      book_4 = Book.create(title: "Book Four", pages: 100, year: 2000)
      review_10 = user_4.reviews.create(title: "good book" , description:"amazing", rating: 5)
      book_3.reviews << [review_10]


      expect(User.top_users).to eq([user_1, user_2, user_3])
    end
  end
end

require 'rails_helper'

RSpec.describe Review, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:title)}
    it { should validate_presence_of(:description)}
    it { should validate_presence_of(:rating)}
  end

  describe 'relationships' do
    it { should belong_to(:book)}
  end

  describe 'class methods' do
    include ActiveSupport::Testing::TimeHelpers
    it '.sorting()' do
      book_1 = Book.create(title: "book_1", pages: 100, year: 2000)
      book_2 = Book.create(title: "book_2", pages: 200, year: 2001)
      book_3 = Book.create(title: "book_3", pages: 240, year: 2004)
      user_1 = User.create(name: "Peregrin")

      review_1 = user_1.reviews.create(title: "good book" , description:"amazing", rating: 5, book: book_1)
      review_2 = user_1.reviews.create(title: "bad book" , description:"lame", rating: 1, book: book_3, created_at: 2.days.ago)

      review_3 = user_1.reviews.create(title: "good book" , description:"review_3", rating: 5, book: book_2, created_at: 4.days.ago)
    
      expect(Review.sorting("asc")).to eq([review_3, review_2, review_1])
      expect(Review.sorting("desc")).to eq([review_1, review_2, review_3])
    end
  end
end

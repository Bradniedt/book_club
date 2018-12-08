require 'rails_helper'

RSpec.describe Book, type: :model do
  describe 'validations' do

    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:pages) }

  end

  describe 'relationships' do
    it { should have_many(:reviews)}
    it { should have_many(:book_authors)}
    it { should have_many(:authors).through(:book_authors)}

  end

  describe 'class method' do
    it "avg_rating()" do
      book_1 = Book.create!(title: "book_1", pages: 100, year: 2000)
      book_2 = Book.create!(title: "book_2", pages: 200, year: 2001)
      book_3 = Book.create!(title: "book_3", pages: 240, year: 2004)
      user_1 = User.create(name: "Peregrin")
      user_2 = User.create(name: "Merriadoc")
      review_1 = user_1.reviews.create!(title: "good book" , description:"amazing", rating: 5)
      review_2 = user_2.reviews.create!(title: "bad book" , description:"lame", rating: 1)
      book_1.reviews << [review_1, review_2]
      review_3 = user_1.reviews.create!(title: "good book" , description:"amazing", rating: 5)
      review_4 = user_2.reviews.create!(title: "not great" , description:"blah", rating: 3)
      book_1.reviews << [review_3, review_4]
      review_5 = user_1.reviews.create!(title: "good book" , description:"amazing", rating: 4)
      review_6 = user_2.reviews.create!(title: "not great" , description:"blah", rating: 1)
      book_1.reviews << [review_5, review_6]

      expect(Book.avg_rating("asc")).to eq([book_3, book_1, book_2])
      expect(Book.avg_rating("desc")).to eq([book_2, book_1, book_3])
   end

   it "number_of_pages()" do
     book_1 = Book.create!(title: "book_1", pages: 500, year: 2000)
     book_2 = Book.create!(title: "book_2", pages: 200, year: 2001)
     book_3 = Book.create!(title: "book_3", pages: 240, year: 2004)

     expect(Book.number_of_pages("asc")).to eq([book_2, book_3, book_1])
     expect(Book.number_of_pages("desc")).to eq([book_1, book_3, book_2])
   end

   it "number_of_reviews()" do
     book_1 = Book.create!(title: "book_1", pages: 100, year: 2000)
     book_2 = Book.create!(title: "book_2", pages: 200, year: 2001)
     book_3 = Book.create!(title: "book_3", pages: 240, year: 2004)
     user_1 = User.create(name: "Peregrin")
     user_2 = User.create(name: "Merriadoc")
     review_1 = user_1.reviews.create!(title: "good book" , description:"amazing", rating: 5)
     review_2 = user_2.reviews.create!(title: "bad book" , description:"lame", rating: 1)
     book_1.reviews << [review_1, review_2]
     review_3 = user_1.reviews.create!(title: "good book" , description:"amazing", rating: 5)
     review_4 = user_2.reviews.create!(title: "not great" , description:"blah", rating: 3)
     book_1.reviews << [review_3, review_4]
     review_5 = user_1.reviews.create!(title: "good book" , description:"amazing", rating: 4)
     review_6 = user_2.reviews.create!(title: "not great" , description:"blah", rating: 1)
     book_1.reviews << [review_5, review_6]

     expect(Book.number_of_reviews("asc")).to eq([book_1, book_3, book_2])
     expect(Book.number_of_reviews("desc")).to eq([book_2, book_3, book_1])
   end
  end
end

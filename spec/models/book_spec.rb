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

  describe 'instance method' do

    it "avg_rating" do
      book_1 = Book.create(title: "book_1", pages: 100, year: 2000)
      user_1 = User.create(name: "Person One")
      user_2 = User.create(name: "Person Two")
      review_1 = user_1.reviews.create(title: "good book" , description:"amazing", rating: 5)
      review_2 = user_2.reviews.create(title: "bad book" , description:"lame", rating: 1)
      book_1.reviews << [review_1, review_2]

      expect(book_1.avg_rating).to eq(3)
    end

    it "total_reviews" do
      book_1 = Book.create(title: "book_1", pages: 100, year: 2000)
      user_1 = User.create(name: "Person One")
      user_2 = User.create(name: "Person Two")
      review_1 = user_1.reviews.create(title: "good book" , description:"amazing", rating: 5)
      review_2 = user_2.reviews.create(title: "bad book" , description:"lame", rating: 1)
      book_1.reviews << [review_1, review_2]

      expect(book_1.total_reviews).to eq(2)
    end

    it 'top_reviews' do
      book_1 = Book.create(title: "book_1", pages: 100, year: 1900)
      user_1 = User.create(name: "Person One")
      user_2 = User.create(name: "Person Two")
      user_3 = User.create(name: "Person Three")
      user_4 = User.create(name: "Person Four")
      review_1 = user_1.reviews.create(title: "good book" , description:"amazing", rating: 5, book: book_1)
      review_2 = user_2.reviews.create(title: "bad book" , description:"lame", rating: 1, book: book_1)
      review_3 = user_3.reviews.create(title: "bad book" , description:"lame", rating: 4, book: book_1)
      review_4 = user_4.reviews.create(title: "bad book" , description:"lame", rating: 4, book: book_1)

      expect(book_1.top_reviews(3)).to eq([review_1, review_3, review_4])
      expect(book_1.top_reviews).to eq([review_1])
    end

    it 'bottom_three_reviews' do
      book_1 = Book.create(title: "book_1", pages: 100, year: 1900)
      user_1 = User.create(name: "Person One")
      user_2 = User.create(name: "Person Two")
      user_3 = User.create(name: "Person Three")
      user_4 = User.create(name: "Person Four")
      review_1 = user_1.reviews.create(title: "good book" , description:"amazing", rating: 1, book: book_1)
      review_2 = user_2.reviews.create(title: "bad book" , description:"lame", rating: 2, book: book_1)
      review_3 = user_3.reviews.create(title: "bad book" , description:"lame", rating: 4, book: book_1)
      review_4 = user_4.reviews.create(title: "bad book" , description:"lame", rating: 3, book: book_1)

      expect(book_1.bottom_three_reviews).to eq([review_1, review_2, review_4])
    end
  end

  describe 'class method' do

    it "all_avg_rating()" do
      book_1 = Book.create(title: "book_1", pages: 100, year: 2000)
      book_2 = Book.create(title: "book_2", pages: 200, year: 2001)
      book_3 = Book.create(title: "book_3", pages: 240, year: 2004)
      user_1 = User.create(name: "Peregrin")
      user_2 = User.create(name: "Merriadoc")

      review_1 = user_1.reviews.create!(title: "good book" , description:"amazing", rating: 5, book: book_1)
      review_2 = user_2.reviews.create!(title: "bad book" , description:"lame", rating: 1, book: book_1)
      review_3 = user_1.reviews.create!(title: "good book" , description:"amazing", rating: 5,book: book_2)
      review_4 = user_2.reviews.create!(title: "not great" , description:"blah", rating: 3, book: book_2)
      review_5 = user_1.reviews.create!(title: "good book" , description:"amazing", rating: 4, book: book_3)
      review_6 = user_2.reviews.create!(title: "not great" , description:"blah", rating: 1, book: book_3)

      expect(Book.all_avg_rating("asc")).to eq([book_3, book_1, book_2])
      expect(Book.all_avg_rating("desc")).to eq([book_2, book_1, book_3])
    end
    it 'highest_rated_books' do
     book_1 = Book.create(title: "book_1", pages: 100, year: 2000)
     book_2 = Book.create(title: "book_2", pages: 200, year: 2001)
     book_3 = Book.create(title: "book_3", pages: 240, year: 2004)
     book_4 = Book.create(title: "book_4", pages: 250, year: 2003)
     book_5 = Book.create(title: "book_5", pages: 1000, year: 2015)
     book_6 = Book.create(title: "book_6", pages: 1050, year: 2016)
     user_1 = User.create(name: "Person One")
     user_2 = User.create(name: "Person Two")
     user_3 = User.create(name: "Person Three")
     user_4 = User.create(name: "Person Four")
     review_1 = user_1.reviews.create(title: "good book" , description:"amazing", rating: 5)
     review_7 = user_3.reviews.create(title: "bad book" , description:"lame", rating: 3)
     book_1.reviews << [review_1, review_7]
     review_2 = user_2.reviews.create(title: "bad book" , description:"lame", rating: 4)
     review_3 = user_1.reviews.create(title: "good book" , description:"amazing", rating: 5)
     review_4 = user_2.reviews.create(title: "not great" , description:"blah", rating: 3)
     review_8 = user_3.reviews.create(title: "not great" , description:"blah", rating: 5)
     book_2.reviews << [review_2, review_3, review_4, review_8]
     review_5 = user_3.reviews.create(title: "not great" , description:"blah", rating: 3)
     review_6 = user_4.reviews.create(title: "not great" , description:"blah", rating: 4)
     book_3.reviews << [review_5, review_6]
     review_9 = user_3.reviews.create(title: "not great" , description:"blah", rating: 2)
     book_4.reviews << [review_9]
     review_10 = user_2.reviews.create(title: "not great" , description:"blah", rating: 3)
     book_5.reviews << [review_10]
     review_11 = user_2.reviews.create(title: "not great" , description:"blah", rating: 1)
     book_6.reviews << [review_11]

     expect(Book.highest_rated_books).to eq([book_2, book_1, book_3])
    end
    it 'lowest_rated_books' do
     book_1 = Book.create!(title: "book_1", pages: 100, year: 2000)
     book_2 = Book.create!(title: "book_2", pages: 200, year: 2001)
     book_3 = Book.create!(title: "book_3", pages: 240, year: 2004)
     book_4 = Book.create!(title: "book_4", pages: 250, year: 2003)
     book_5 = Book.create!(title: "book_5", pages: 1000, year: 2015)
     book_6 = Book.create!(title: "book_6", pages: 1050, year: 2016)
     user_1 = User.create(name: "Person One")
     user_2 = User.create(name: "Person Two")
     user_3 = User.create(name: "Person Three")
     user_4 = User.create(name: "Person Four")
     review_1 = user_1.reviews.create(title: "good book" , description:"amazing", rating: 5)
     review_7 = user_3.reviews.create(title: "bad book" , description:"lame", rating: 3)
     book_1.reviews << [review_1, review_7]
     review_2 = user_2.reviews.create(title: "bad book" , description:"lame", rating: 4)
     review_3 = user_1.reviews.create(title: "good book" , description:"amazing", rating: 5)
     review_4 = user_2.reviews.create(title: "not great" , description:"blah", rating: 3)
     review_8 = user_3.reviews.create(title: "not great" , description:"blah", rating: 5)
     book_2.reviews << [review_2, review_3, review_4, review_8]
     review_5 = user_3.reviews.create(title: "not great" , description:"blah", rating: 4)
     review_6 = user_4.reviews.create(title: "not great" , description:"blah", rating: 4)
     book_3.reviews << [review_5, review_6]
     review_9 = user_3.reviews.create(title: "not great" , description:"blah", rating: 2)
     book_4.reviews << [review_9]
     review_10 = user_2.reviews.create(title: "not great" , description:"blah", rating: 3)
     book_5.reviews << [review_10]
     review_11 = user_2.reviews.create(title: "not great" , description:"blah", rating: 1)
     book_6.reviews << [review_11]

     expect(Book.lowest_rated_books).to eq([book_6, book_4, book_5])
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
     user_3 = User.create(name: "Frodo")
     review_1 = user_1.reviews.create!(title: "good book" , description:"amazing", rating: 5, book: book_1)
     review_2 = user_2.reviews.create!(title: "bad book" , description:"lame", rating: 1, book: book_2)
     review_3 = user_3.reviews.create!(title: "good book" , description:"amazing", rating: 5, book: book_3)
     review_4 = user_3.reviews.create!(title: "not great" , description:"blah", rating: 3, book: book_2)
     review_5 = user_1.reviews.create!(title: "good book" , description:"amazing", rating: 4, book: book_3)
     review_6 = user_2.reviews.create!(title: "not great" , description:"blah", rating: 1, book: book_3)

     expect(Book.number_of_reviews("asc")).to eq([book_1, book_2, book_3])
     expect(Book.number_of_reviews("desc")).to eq([book_3, book_2, book_1])
    end
  end
end

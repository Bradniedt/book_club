require "rails_helper"

describe "As a visitor" do
  describe "when I visit /books" do
    it "should see all book titles" do
      book_1 = Book.create(title: "book_1", pages: 100, year: 2000)
      book_2 = Book.create(title: "book_2", pages: 200, year: 2001)

      visit books_path

      expect(page).to have_content(book_1.title)
      expect(page).to have_content(book_2.title)
      expect(page).to have_content(book_1.pages)
      expect(page).to have_content(book_2.pages)
      expect(page).to have_content(book_1.year)
      expect(page).to have_content(book_2.year)
    end
    it "should see each book's average rating" do
      book_1 = Book.create(title: "book_1", pages: 100, year: 2000)
      book_2 = Book.create(title: "book_2", pages: 200, year: 2001)
      book_3 = Book.create(title: "book_3", pages: 240, year: 2004)
      user_1 = User.create(name: "Person One")
      user_2 = User.create(name: "Person Two")
      review_1 = user_1.reviews.create(title: "good book" , description:"amazing", rating: 5)
      review_2 = user_2.reviews.create(title: "bad book" , description:"lame", rating: 1)
      book_1.reviews << [review_1, review_2]
      review_3 = user_1.reviews.create(title: "good book" , description:"amazing", rating: 5)
      review_4 = user_2.reviews.create(title: "not great" , description:"blah", rating: 3)
      book_2.reviews << [review_3, review_4]
      review_5 = user_1.reviews.create(title: "good book" , description:"amazing", rating: 5)
      review_6 = user_2.reviews.create(title: "not great" , description:"blah", rating: 5)
      book_3.reviews << [review_5, review_6]

      visit books_path
      within "#book_#{book_1.id}" do
        expect(page).to have_content(book_1.avg_rating)
      end
      within "#book_#{book_2.id}" do
        expect(page).to have_content(book_2.avg_rating)
      end
      within "#book_#{book_3.id}" do
        expect(page).to have_content(book_3.avg_rating)
      end
    end
    it "should see each book's total reviews" do
      book_1 = Book.create(title: "book_1", pages: 100, year: 2000)
      book_2 = Book.create(title: "book_2", pages: 200, year: 2001)
      book_3 = Book.create(title: "book_3", pages: 240, year: 2004)
      user_1 = User.create(name: "Person One")
      user_2 = User.create(name: "Person Two")
      review_1 = user_1.reviews.create(title: "good book" , description:"amazing", rating: 5)
      review_2 = user_2.reviews.create(title: "bad book" , description:"lame", rating: 1)
      book_1.reviews << [review_1, review_2]
      review_3 = user_1.reviews.create(title: "good book" , description:"amazing", rating: 5)
      review_4 = user_2.reviews.create(title: "not great" , description:"blah", rating: 3)
      book_2.reviews << [review_3, review_4]
      review_5 = user_1.reviews.create(title: "good book" , description:"amazing", rating: 5)
      review_6 = user_2.reviews.create(title: "not great" , description:"blah", rating: 5)
      book_3.reviews << [review_5, review_6]

      visit books_path

      within "#book_#{book_1.id}" do
        expect(page).to have_content("Total Reviews : #{book_1.total_reviews}")
      end
      
      within "#book_#{book_2.id}" do
        expect(page).to have_content("Total Reviews : #{book_2.total_reviews}")
      end

      within "#book_#{book_3.id}" do
        expect(page).to have_content("Total Reviews : #{book_3.total_reviews}")
      end

    end
  end
end

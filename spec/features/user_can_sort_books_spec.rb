require "rails_helper"

describe "as a user" do
  describe "when I visit /books" do
    describe "when I click on the links for average rating" do
      it "should show books sorted by rating" do
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

        click_on("Rating: Lowest to Highest")

        expect(all('.book')[0]).to have_content(book_1.title)
        expect(all('.book')[1]).to have_content(book_2.title)
        expect(all('.book')[2]).to have_content(book_3.title)

        click_on("Rating: Highest to Lowest")

        expect(all('.book')[0]).to have_content(book_3.title)
        expect(all('.book')[1]).to have_content(book_2.title)
        expect(all('.book')[2]).to have_content(book_1.title)
      end

      describe "when I click on the links to sort by number of pages" do
        it "should show books sorted by number of pages" do
          book_1 = Book.create(title: "book_1", pages: 300, year: 2000)
          book_2 = Book.create(title: "book_2", pages: 200, year: 2001)
          book_3 = Book.create(title: "book_3", pages: 240, year: 2004)

          visit books_path

          click_on("Number of Pages: Lowest to Highest")

          expect(all('.book')[0]).to have_content(book_2.title)
          expect(all('.book')[1]).to have_content(book_3.title)
          expect(all('.book')[2]).to have_content(book_1.title)

          click_on("Number of Pages: Highest to Lowest")

          expect(all('.book')[0]).to have_content(book_1.title)
          expect(all('.book')[1]).to have_content(book_3.title)
          expect(all('.book')[2]).to have_content(book_2.title)
        end
      end

      describe "when I click on the links to sort by number of reviews" do
        it "should show books sorted by number of reviews" do
          book_1 = Book.create!(title: "book_1", pages: 100, year: 2000)
          book_2 = Book.create!(title: "book_2", pages: 200, year: 2001)
          book_3 = Book.create!(title: "book_3", pages: 240, year: 2004)
          user_1 = User.create(name: "Person One")
          user_2 = User.create(name: "Person Two")
          review_1 = user_1.reviews.create(title: "good book" , description:"amazing", rating: 5)
          review_2 = user_2.reviews.create(title: "bad book" , description:"lame", rating: 1)
          book_1.reviews << [review_1]
          review_3 = user_1.reviews.create(title: "good book" , description:"amazing", rating: 5)
          review_4 = user_2.reviews.create(title: "not great" , description:"blah", rating: 3)
          book_2.reviews << [review_2, review_3, review_4]
          review_5 = user_1.reviews.create(title: "good book" , description:"amazing", rating: 4)
          review_6 = user_2.reviews.create(title: "not great" , description:"blah", rating: 1)
          book_3.reviews << [review_5, review_6]

          visit books_path

          click_on("Number of Reviews: Lowest to Highest")

          expect(all('.book')[0]).to have_content(book_1.title)
          expect(all('.book')[1]).to have_content(book_3.title)
          expect(all('.book')[2]).to have_content(book_2.title)

          click_on("Number of Reviews: Highest to Lowest")

          expect(all('.book')[0]).to have_content(book_2.title)
          expect(all('.book')[1]).to have_content(book_3.title)
          expect(all('.book')[2]).to have_content(book_1.title)
        end
      end
    end
  end
end

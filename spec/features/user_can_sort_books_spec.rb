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
      describe 'I see a book statistics section' do
        it 'should show book stats' do
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
          review_2 = user_2.reviews.create(title: "bad book" , description:"lame", rating: 1)
          review_7 = user_3.reviews.create(title: "bad book" , description:"lame", rating: 4)
          book_1.reviews << [review_1, review_7]
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

          visit books_path

          within('.highest_rated_books') do
            expect(page).to have_content(book_1.title)
            expect(page).to have_content(book_3.title)
            expect(page).to have_content(book_2.title)
          end

          within('.lowest_rated_books') do
            expect(page).to have_content(book_6.title)
            expect(page).to have_content(book_4.title)
            expect(page).to have_content(book_5.title)
          end

        end
        it 'shows a list of the three users with the most reviews' do
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
          review_2 = user_2.reviews.create(title: "bad book" , description:"lame", rating: 1)
          review_7 = user_3.reviews.create(title: "bad book" , description:"lame", rating: 4)
          book_1.reviews << [review_1, review_7]
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
          review_11 = user_3.reviews.create(title: "not great" , description:"blah", rating: 1)
          book_6.reviews << [review_11]

          visit books_path

          within('.top_users') do
            expect(page).to have_content("#{user_3.name} with #{user_3.review_count} reviews.")
            expect(page).to have_content("#{user_2.name} with #{user_2.review_count} reviews.")
            expect(page).to have_content("#{user_1.name} with #{user_1.review_count} reviews.")
          end
        end
        it "should show all usernames as links" do
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
          review_2 = user_2.reviews.create(title: "bad book" , description:"lame", rating: 1)
          review_7 = user_3.reviews.create(title: "bad book" , description:"lame", rating: 4)
          book_1.reviews << [review_1, review_7]
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
          review_11 = user_3.reviews.create(title: "not great" , description:"blah", rating: 1)
          book_6.reviews << [review_11]

          visit books_path

          within('.top_users') do
            expect(page).to have_link("Person One")
            expect(page).to have_link("Person Two")
            expect(page).to have_link("Person Three")
          end
        end
      end

    end
  end
end

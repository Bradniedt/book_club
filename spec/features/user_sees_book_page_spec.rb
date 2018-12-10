require "rails_helper"

describe "As a visitor" do
  describe "when I visit /books/show" do
    it "should see all book info" do
      book_1 = Book.create(title: "book_1", pages: 100, year: 1900)
      user_1 = User.create(name: "Person One")
      review_1 = user_1.reviews.create(title: "review_1", description: "ehfladhflad", rating: 4)
      review_2 = user_1.reviews.create(title: "review_2", description: "ehfladhflad", rating: 5)
      book_1.reviews << [review_1, review_2]
      author_1 = book_1.authors.create(name: "Author One")

      visit book_path(book_1)

      expect(page).to have_content(book_1.title)
      expect(page).to have_content(book_1.pages)
      expect(page).to have_content(book_1.year)
      expect(page).to have_content(book_1.authors.name)
      expect(page).to have_content(review_1.title)
      expect(page).to have_content(review_1.description)
      expect(page).to have_content(review_1.rating)
    end

    it 'should see all user names as links to that user show page' do
      book_1 = Book.create(title: "book_1", pages: 100, year: 1900)
      user_1 = User.create(name: "Person One")
      user_2 = User.create(name: "Person Two")
      review_1 = user_1.reviews.create(title: "review_1", description: "ehfladhflad", rating: 4)
      review_2 = user_2.reviews.create(title: "review_2", description: "ehfladhflad", rating: 5)
      book_1.reviews << [review_1, review_2]
      author_1 = book_1.authors.create(name: "Author One")

      visit book_path(book_1)

      expect(page).to have_link("Person One")
      expect(page).to have_link("Person Two")
    end

    it "should display the top three reviews" do
      book_1 = Book.create(title: "book_1", pages: 100, year: 1900)
      user_1 = User.create(name: "Person One")
      user_2 = User.create(name: "Person Two")
      user_3 = User.create(name: "Person Three")
      user_4 = User.create(name: "Person Four")
      review_1 = user_1.reviews.create(title: "good book" , description:"amazing", rating: 5, book: book_1)
      review_2 = user_2.reviews.create(title: "bad book" , description:"lame", rating: 1, book: book_1)
      review_3 = user_3.reviews.create(title: "bad book" , description:"lame", rating: 4, book: book_1)
      review_4 = user_4.reviews.create(title: "bad book" , description:"lame", rating: 4, book: book_1)

      visit book_path(book_1)

      within('.top-reviews') do
        expect(page).to have_content(review_1.title)
        expect(page).to have_content(review_1.rating)
        expect(page).to have_content(review_1.user.name)
        expect(page).to have_content(review_3.title)
        expect(page).to have_content(review_3.rating)
        expect(page).to have_content(review_3.user.name)
        expect(page).to have_content(review_4.title)
        expect(page).to have_content(review_4.rating)
        expect(page).to have_content(review_4.user.name)
      end
    end

    it "should display the bottom three reviews" do
      book_1 = Book.create(title: "book_1", pages: 100, year: 1900)
      user_1 = User.create(name: "Person One")
      user_2 = User.create(name: "Person Two")
      user_3 = User.create(name: "Person Three")
      user_4 = User.create(name: "Person Four")
      review_1 = user_1.reviews.create(title: "good book" , description:"amazing", rating: 1, book: book_1)
      review_2 = user_2.reviews.create(title: "bad book" , description:"lame", rating: 2, book: book_1)
      review_3 = user_3.reviews.create(title: "bad book" , description:"lame", rating: 4, book: book_1)
      review_4 = user_4.reviews.create(title: "bad book" , description:"lame", rating: 3, book: book_1)

      visit book_path(book_1)

      within('.bottom-reviews') do
        expect(page).to have_content(review_1.title)
        expect(page).to have_content(review_1.rating)
        expect(page).to have_content(review_1.user.name)
        expect(page).to have_content(review_2.title)
        expect(page).to have_content(review_2.rating)
        expect(page).to have_content(review_2.user.name)
        expect(page).to have_content(review_4.title)
        expect(page).to have_content(review_4.rating)
        expect(page).to have_content(review_4.user.name)
      end
    end

    it "should display the average rating" do
      book_1 = Book.create(title: "book_1", pages: 100, year: 1900)
      user_1 = User.create(name: "Person One")
      user_2 = User.create(name: "Person Two")
      user_3 = User.create(name: "Person Three")
      user_4 = User.create(name: "Person Four")
      review_1 = user_1.reviews.create(title: "good book" , description:"amazing", rating: 1, book: book_1)
      review_2 = user_2.reviews.create(title: "bad book" , description:"lame", rating: 2, book: book_1)
      review_3 = user_3.reviews.create(title: "bad book" , description:"lame", rating: 4, book: book_1)
      review_4 = user_4.reviews.create(title: "bad book" , description:"lame", rating: 3, book: book_1)

      visit book_path(book_1)

      within('.avg-rating') do
        expect(page).to have_content(book_1.avg_rating)
      end
    end
    it "should have a delete book link" do
      book_1 = Book.create(title: "book_1", pages: 100, year: 1900)
      author_1 = book_1.authors.create(name: "Bob")
      user_1 = User.create(name: "Person One")
      review_1 = user_1.reviews.create(title: "good book" , description:"amazing", rating: 1, book: book_1)

      visit book_path(book_1)

      expect(page).to have_link("Delete this Book")
    end

    it "can delete the book when user clicks delete this book link" do
      book_1 = Book.create(title: "book_1", pages: 100, year: 1900)
      author_1 = book_1.authors.create(name: "Bob")
      user_1 = User.create(name: "Person One")
      review_1 = user_1.reviews.create(title: "good book" , description:"amazing", rating: 1, book: book_1)
      book_2 = Book.create(title: "book_2", pages: 100, year: 1900)
      author_2 = book_2.authors.create(name: "Jenny")
      user_2 = User.create(name: "Person Two")
      review_2 = user_2.reviews.create(title: "good book" , description:"amazing", rating: 1, book: book_2)

      visit book_path(book_1)

      click_on("Delete this Book")

      expect(current_path).to eq(books_path)

      expect(page).to_not have_content(author_1.name)
      expect(page).to_not have_content(book_1.title)
      expect(page).to have_content(book_2.title)
      expect(page).to have_content(book_2.authors[0].name)
    end
  end
end

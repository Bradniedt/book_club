require 'rails_helper'

describe 'as a visitor' do
  describe 'when I click on author name' do
    it 'show show author show page' do
      author_1= Author.create(name: "Jones")
      book_1 = author_1.books.create(title: "book_1", pages: 100, year: 2000)
      book_2 = author_1.books.create(title: "book_2", pages: 100, year: 2001)

      visit books_path

      within("#book_#{book_1.id}") do
        click_on("#{author_1.name}")
      end

      expect(page.current_path).to eq(author_path(author_1))
    end
    it "should show author's top review" do
      book_1 = Book.create(title: "book_1", pages: 100, year: 1900)
      user_1 = User.create(name: "Person One")
      user_2 = User.create(name: "Person Two")

      review_1 = user_1.reviews.create(title: "review_1", description: "ehfladhflad", rating: 1, book: book_1)
      review_2 = user_2.reviews.create(title: "review_2", description: "ehfladhflad", rating: 5, book: book_1)
      author_1 = book_1.authors.create(name: "Author One")

      visit author_path(author_1)

      within ('.top_review') do
       expect(page).to have_content(review_2.title)
       expect(page).to have_content(review_2.rating)
       expect(page).to have_content(review_2.user.name)
      end
    end
    it "should show a delete author button" do
      book_1 = Book.create(title: "book_1", pages: 100, year: 1900)
      author_1 = book_1.authors.create(name: "Author One")

      visit author_path(author_1)

      expect(page).to have_link("Delete Author")
    end
    it "can delete an author when user clicks delete author" do
      user_1 = User.create(name: "Person One")
      user_2 = User.create(name: "Person Two")
      author_1 = Author.create(name: "Author One")
      author_2 = Author.create(name: "Author Two")
      book_1 = Book.create(title: "book_1", pages: 100, year: 1900, authors: [author_1, author_2])
      book_2 = Book.create(title: "book_2", pages: 200, year: 2000, authors: [author_2])

      review_1 = user_1.reviews.create(title: "review_1", description: "ehfladhflad", rating: 1, book: book_1)
      review_2 = user_2.reviews.create(title: "review_2", description: "ehfladhflad", rating: 5, book: book_1)

      visit author_path(author_1)

      click_on("Delete Author")

      expect(current_path).to eq(books_path)

      expect(page).to_not have_content(author_1.name)
      expect(page).to_not have_content(book_1.title)
      expect(page).to have_content(book_2.title)
      expect(page).to have_content(book_2.authors[0].name)
    end
  end
end

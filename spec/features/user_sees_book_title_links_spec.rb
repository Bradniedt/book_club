describe "as a user" do
  describe "when I see a book title" do
    it "is a link to the book's show page" do
      author_1 = Author.create(name: "Joe")
      book_1 = author_1.books.create(title: "book_1", pages: 100, year: 1900)
      user_1 = User.create(name: "Bob")
      review_1 = user_1.reviews.create(title: "good book" , description:"amazing", rating: 5, book: book_1)
      
      visit books_path

      expect(page).to have_link("Book 1")
    end
  end
end

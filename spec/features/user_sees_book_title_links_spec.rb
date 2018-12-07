describe "as a user" do
  describe "when I see a book title" do
    it "is a link to the book's show page" do
      book_1 = Book.create(title: "book_1", pages: 100, year: 1900)

      visit books_path

      expect(page).to have_link("Book 1")
    end
  end
end

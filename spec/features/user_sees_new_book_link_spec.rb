require "rails_helper"

describe "As a visitor" do
  describe "when I visit /books" do
    it "should see a link to create a new book" do
      visit '/books'

      expect(page).to have_link("Create a new book!", href: "/books/new")
    end
  end
  describe "when I click visit /books/new" do
    it "should take me to a page with a form to create a book" do
      visit '/books/new'

      expect(page).to have_field("Title")
      expect(page).to have_field("Pages")
      expect(page).to have_field("Author")
      expect(page).to have_field("Year")
    end
  end
  describe "when I click Create Book" do
    it "takes me to the book's show page" do

      visit new_book_path

      fill_in 'Title', with: "Book 1"
      fill_in 'Pages', with: 100
      fill_in 'Author', with: "Name 1"
      fill_in 'Year', with: 1970
      click_button 'Create Book'

      expect(current_path).to eq("/books/#{Book.last.id}")
      expect(page).to have_content(Book.last.title)
    end
  end
end

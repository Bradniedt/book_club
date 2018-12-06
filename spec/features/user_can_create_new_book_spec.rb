require "rails_helper"
describe "As a visitor" do
  describe "when I fill out the new book form" do
    describe "when I click Create Book" do
      it "takes me to the book's show page" do

        visit new_book_path

        fill_in 'Title', with: "Book 1"
        fill_in 'Pages', with: 100
        fill_in 'Author', with: "Name 1"
        click_button 'Create Book'

        expect(current_path).to eq("/books/#{Book.last.id}")
        expect(page).to have_content(Book.last.title)
      end
    end
    describe "when I create a book with lowercased title and author" do
      it "should titleize the title and author before saving" do
        visit new_book_path

        fill_in 'Title', with: "book one"
        fill_in 'Pages', with: 100
        fill_in 'Author', with: "name one"
        click_button 'Create Book'

        expect(page).to have_content("Book One")
        expect(page).to have_content("Name One")

        expect(Author.last.name).to eq("Name One")
      end
      it "when I provide two author names separated by a comma, both are created" do
        visit new_book_path

        fill_in 'Title', with: "book one"
        fill_in 'Pages', with: 100
        fill_in 'Author', with: "name one, name two"
        click_button 'Create Book'

        expect(page).to have_content("Book One")
        expect(page).to have_content("Name One")
        expect(page).to have_content("Name Two")

        expect(Author.last.name).to eq("Name Two")
      end
    end
  end
end

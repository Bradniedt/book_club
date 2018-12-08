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
  end
end

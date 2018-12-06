require 'rails_helper'

describe 'as a visitor' do
  describe 'when I visit an author show page'do
    it 'should see all book titles by that author' do
      book_1 = Book.create(title: "book_1", pages: 100, year: 2000)
      book_2 = Book.create(title: "book_2", pages: 200, year: 2001)
      author_1= book_1.authors.create(name: "Jones")

      visit author_path(author_1)

      expect(page).to have_content(author_1.name)
      expect(page).to have_content(book_1.title)
      expect(page).to have_content(book_1.pages)
      expect(page).to have_content(book_1.year)
    end
    it 'should see all book titles by that author' do
      author_1= Author.create(name: "Jones")
      book_1 = author_1.books.create(title: "book_1", pages: 100, year: 2000)
      book_2 = author_1.books.create(title: "book_2", pages: 100, year: 2001)

      visit author_path(author_1)

      expect(page).to have_content(author_1.name)
      expect(page).to have_content(book_1.title)
      expect(page).to have_content(book_1.pages)
      expect(page).to have_content(book_1.year)
      expect(page).to have_content(book_2.title)
      expect(page).to have_content(book_2.pages)
      expect(page).to have_content(book_2.year)
    end

  end
end

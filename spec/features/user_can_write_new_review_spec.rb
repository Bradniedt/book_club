require 'rails_helper'

describe 'as a visitor' do
  describe 'when I visit /books/show' do
    it 'I see a link to add a new review' do
      book_1 = Book.create(title: "book_1", pages: 100, year: 2000)

      visit book_path(book_1)
        expect(page).to have_link("Add Review")
    end
  end
end

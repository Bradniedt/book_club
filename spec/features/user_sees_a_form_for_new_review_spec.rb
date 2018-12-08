require 'rails_helper'

describe 'as a visitor' do
  describe 'when I click on add review' do
    it 'should show a form' do
      book_1 = Book.create(title: "book_1", pages: 100, year: 2000)

      visit new_book_review_path(book_1)

      fill_in 'Title', with: "Would suggest"
      fill_in 'Username', with: "my name"
      fill_in 'Description', with: "Good book"
      fill_in 'Rating', with: 4

      click_button 'Create Review'

      user = User.last.name

      expect(page).to have_content("Would suggest")
      expect(page).to have_content("Good book")
      expect(page).to have_content(4)
      expect(user.name).to eq("My Name")
    end
  end
end

require 'rails_helper'

describe 'as a visitor' do
  describe 'when writing a review' do
    context 'user name has not been used before' do
      it 'should be able to create a new review' do
        book_1 = Book.create(title: "book_1", pages: 100, year: 2000)

        visit new_book_review_path(book_1)

        fill_in 'Title', with: "Would suggest"
        fill_in 'Username', with: "my name"
        fill_in 'Description', with: "Good book"
        fill_in 'Rating', with: 4

        click_button 'Create Review'

        user = User.last

        expect(page).to have_content("Would suggest")
        expect(page).to have_content("Good book")
        expect(page).to have_content(4)
        expect(user.name).to eq("My Name")
      end
    end
    context 'user name has been used before' do
      it "should not let me create a already existing username" do
        book_1 = Book.create(title: "book_1", pages: 100, year: 2000)
        user_1 = User.create(name: "Maddie")
        review_1 = user_1.reviews.create(title: "bad book",
          description: "horrible, could not make it past the first page!!!",
          rating: 1,
          book: book_1)


        visit new_book_review_path(book_1)

        fill_in 'Title', with: "Would suggest"
        fill_in 'Username', with: "my name"
        fill_in 'Description', with: "Good book"
        fill_in 'Rating', with: 4

        expect{
          click_button 'Create Review'

          expect(page).to have_content("You already reviewed")
        }.not_to change{Review.count}
      end
    end
  end
end

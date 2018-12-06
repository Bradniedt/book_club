require "rails_helper"

describe "as a user" do
  describe "when I visit /books" do
    describe "when I click on link for average rating ascending" do
      xit "should show books sorted by rating" do
        book_1 = Book.create(title: "book_1", pages: 100, year: 2000)
        book_2 = Book.create(title: "book_2", pages: 200, year: 2001)
        book_3 = Book.create(title: "book_3", pages: 240, year: 2004)
        review_1 = book_1.reviews.create(title: "good book" , description:"amazing", rating: 5)
        review_2 = book_1.reviews.create(title: "bad book" , description:"lame", rating: 1)
        review_3 = book_2.reviews.create(title: "good book" , description:"amazing", rating: 5)
        review_4 = book_2.reviews.create(title: "not great" , description:"blah", rating: 3)
        review_5 = book_3.reviews.create(title: "good book" , description:"amazing", rating: 5)
        review_6 = book_3.reviews.create(title: "not great" , description:"blah", rating: 5)

        visit books_path

        expected_1 = page.body =~ /Book 3/
        expected_2 = page.body =~ /Book 2/
        expected_3 = page.body =~ /Book 1/

        click_on("Rating: Lowest to Highest")
        save_and_open_page

        expect(page).to have_content([expected_1, expected_2, expected_3])
      end
    end
  end
end

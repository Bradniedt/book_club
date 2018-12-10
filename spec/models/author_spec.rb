require 'rails_helper'

RSpec.describe Author, type: :model do
  describe 'validations' do

    it { should validate_presence_of(:name) }

  end

  describe 'relationships' do
    it { should have_many(:book_authors)}
    it { should have_many(:books).through(:book_authors)}

  end

  describe 'instance methods' do
    it "top_review" do
      book_1 = Book.create(title: "book_1", pages: 100, year: 1900)
      user_1 = User.create(name: "Person One")
      review_1 = user_1.reviews.create(title: "review_1", description: "ehfladhflad", rating: 4, book: book_1)
      review_2 = user_1.reviews.create(title: "review_2", description: "ehfladhflad", rating: 5, book: book_1)
      author_1 = book_1.authors.create(name: "Author One")
binding.pry
      expect(author_1.top_review).to eq(review_2)
    end
  end
end

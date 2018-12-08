class ReviewsController < ApplicationController
  def new
    @book = Book.find(params[:book_id])
    @review = Review.new
  end
  def create
    book = Book.find(params[:book_id])
    user_name = params[:review]["username"].titleize
    user = User.find_or_create_by(:name => user_name)
    review = user.reviews.create(review_params)
    book.reviews << review
    redirect_to book_path(book)
  end

  private

  def review_params
    params.require(:review).permit(:title, :description, :rating)
  end
end

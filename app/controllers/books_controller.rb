class BooksController < ApplicationController
  def index
    @books = Book.sort(params)
    @highest_books = Book.highest_rated_books
    @lowest_books = Book.lowest_rated_books
    @top_users = User.top_users
  end

  def new
    @book = Book.new
  end

  def show
    @book = Book.find(params[:id])
    @authors = @book.authors
  end

  def create
    book = Book.create(book_params)
    author_array = params[:book]["authors"].split(",")
    author_array.each do |author|
      book.authors << Author.find_or_create_by(:name => author.strip)
    end
    redirect_to book_path(book)
  end

  private

  def book_params
    params.require(:book).permit(:title, :pages, :year)
  end
end

class BooksController < ApplicationController
  def index
    @books = Book.all
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
      book.authors << Author.find_or_create_by(:name => author)
    end
    redirect_to book_path(book)
  end

  private

  def book_params
    params.require(:book).permit(:title, :pages)
  end
end

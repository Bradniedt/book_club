class Book < ApplicationRecord
  validates_presence_of :title, :pages, :year
  before_save :titleizer

  has_many :book_authors, dependent: :destroy
  has_many :authors, through: :book_authors
  has_many :reviews, dependent: :destroy

  def titleizer
    self.title = self.title.titleize
  end

  def self.all_avg_rating(order)
    books = self.select("books.*, avg(reviews.rating) AS avg_rating")
                .joins(:reviews)
                .group("books.id")
                .order("avg_rating #{order}")
  end

  def self.highest_rated_books
    books = self.select("books.*, avg(reviews.rating) AS avg_rating").joins(:reviews).group("books.id").order("avg_rating desc").limit(3)
  end

  def self.lowest_rated_books
    books = self.select("books.*, avg(reviews.rating) AS avg_rating").joins(:reviews).group("books.id").order("avg_rating ").limit(3)
  end

  def self.number_of_pages(order)
    self.order("pages #{order}")
  end

  def self.number_of_reviews(order)
    self.select('books.*, reviews.count AS count').joins(:reviews).group(:id).order("count #{order}")
  end

  def self.sort(params)
    if params[:sort] == "asc_rating"
      all_avg_rating("asc")
    elsif params[:sort] == "desc_rating"
      all_avg_rating("desc")
    elsif params[:sort] == "asc_pages"
      number_of_pages("asc")
    elsif params[:sort] == "desc_pages"
      number_of_pages("desc")
    elsif params[:sort] == "asc_reviews"
      number_of_reviews("asc")
    elsif params[:sort] == "desc_reviews"
      number_of_reviews("desc")
    else
      all
    end
  end

  def avg_rating
    reviews.average(:rating)
  end

  def total_reviews
    reviews.count
  end

  def top_reviews(n = 1)
    reviews.order("reviews.rating desc").limit(n)
  end

  def bottom_three_reviews
    reviews.order(:rating).limit(3)
  end
end

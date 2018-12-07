class Book < ApplicationRecord
  validates_presence_of :title, :pages, :year
  before_save :titleizer

  has_many :reviews
  has_many :book_authors
  has_many :authors, through: :book_authors

  def titleizer
    self.title = self.title.titleize
  end

  def self.avg_rating(order)
    books = self.select("books.*, avg(reviews.rating) AS avg_rating")
                .joins(:reviews).group("books.id")
                .order("avg_rating #{order}")
  end

  def self.number_of_pages(order)
    self.order("pages #{order}")
  end

  def self.sort(params)
    if params[:sort] == "asc_rating"
      avg_rating("asc")
    elsif params[:sort] == "desc_rating"
      avg_rating("desc")
    else
      all
    end
  end
end

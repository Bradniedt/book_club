class Book < ApplicationRecord
  validates_presence_of :title, :pages, :year
  before_save :titleizer

  has_many :reviews
  has_many :book_authors
  has_many :authors, through: :book_authors

  def titleizer
    self.title = self.title.titleize
  end

  def self.avg_rating_asc
    self.select("books.*, avg(reviews.rating) AS avg_rating").joins(:reviews).group("books.id").reverse_order
  end

end

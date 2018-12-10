class Author < ApplicationRecord
  validates_presence_of :name
  validates_uniqueness_of :name, :case_sensitive => false
  before_save :titleizer

  has_many :book_authors
  has_many :books, through: :book_authors

  def titleizer
    self.name = self.name.titleize
  end

  def top_review
    books.reviews.order("review.rating desc").limit(1)
  end
end

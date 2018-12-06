class Book < ApplicationRecord
  validates_presence_of :title, :pages, :year
  before_save :titleizer

  has_many :reviews
  has_many :book_authors
  has_many :authors, through: :book_authors

  def titleizer
    self.title = self.title.titleize
  end

end

class Author < ApplicationRecord
  validates_presence_of :name
  before_save :titleizer

  has_many :book_authors
  has_many :books, through: :book_authors

  def titleizer
    self.name = self.name.titleize
  end 
end

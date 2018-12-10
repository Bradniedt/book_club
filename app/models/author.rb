class Author < ApplicationRecord
  validates_presence_of :name
  validates_uniqueness_of :name, :case_sensitive => false
  before_save :titleizer

  has_many :book_authors, dependent: :destroy
  has_many :books, through: :book_authors

  def titleizer
    self.name = self.name.titleize
  end

end

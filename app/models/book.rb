class Book < ApplicationRecord
  validates_presence_of :title, :pages, :author
  before_save :titleizer

  has_many :reviews

  def titleizer
    self.title = self.title.titleize
    self.author = self.author.titleize
  end

end

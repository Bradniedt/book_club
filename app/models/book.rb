class Book < ApplicationRecord
  validates_presence_of :title, :pages
  before_save :titleizer

  has_many :reviews

  def titleizer
    self.title = self.title.titleize
  end

end

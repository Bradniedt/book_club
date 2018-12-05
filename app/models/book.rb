class Book < ApplicationRecord
  validates_presence_of :title, :pages, :author

  has_many :reviews

end

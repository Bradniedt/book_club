class Review < ApplicationRecord
  validates_presence_of :title, :description, :rating

  belongs_to :book
  belongs_to :user
  validates :user, uniqueness: { scope: :book,
    message: "You already reviewed this book"
  }
end

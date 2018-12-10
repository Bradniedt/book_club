class Review < ApplicationRecord
  validates_presence_of :title, :description, :rating

  belongs_to :book
  belongs_to :user

  def self.sorting(direction)
    order("created_at #{direction}")
  end


  validates :user, uniqueness: { scope: :book,
    message: "You already reviewed this book"
  }
end

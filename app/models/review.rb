class Review < ApplicationRecord
  validates_presence_of :title, :description, :rating

  belongs_to :user
  belongs_to :book

  def self.sorting(direction)
    order("created_at #{direction}")
  end
end

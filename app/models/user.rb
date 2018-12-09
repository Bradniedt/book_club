class User < ApplicationRecord
  validates_presence_of :name

  has_many :reviews

  def review_count
    reviews.count
  end 
end

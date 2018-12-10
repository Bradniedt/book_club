class User < ApplicationRecord
  validates_presence_of :name

  has_many :reviews, dependent: :destroy

  def review_count
    reviews.count
  end

  def self.top_users
    self.select("users.*, reviews.count AS total_reviews")
        .joins(:reviews)
        .group("users.id")
        .order("total_reviews desc")
        .limit(3)
  end
end

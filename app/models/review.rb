class Review < ApplicationRecord
  validates_presence_of :title, :description, :rating

  belongs_to :user
end

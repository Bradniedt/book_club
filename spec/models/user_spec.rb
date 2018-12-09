require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do

    it { should validate_presence_of(:name) }

  end

  describe 'relationships' do
    it { should have_many(:reviews)}
  end

  describe 'instance methods' do
    it 'review_count' do
      user_1 = User.create(name: "Person One")
      review_1 = user_1.reviews.create(title: "good book" , description:"amazing", rating: 5)
      review_2 = user_1.reviews.create(title: "bad book" , description:"lame", rating: 1)
      review_7 = user_1.reviews.create(title: "bad book" , description:"lame", rating: 4)

      expect(user_1.review_count).to eq(3)
    end
  end
end

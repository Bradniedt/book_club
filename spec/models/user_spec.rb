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

  describe 'class methods' do
    it 'top_users' do
      user_1 = User.create(name: "Person One")
      review_1 = user_1.reviews.create(title: "good book" , description:"amazing", rating: 5)
      review_2 = user_1.reviews.create(title: "bad book" , description:"lame", rating: 1)
      review_3 = user_1.reviews.create(title: "bad book" , description:"lame", rating: 4)
      review_4 = user_1.reviews.create(title: "bad book" , description:"lame", rating: 4)
      user_2 = User.create(name: "Person Two")
      review_5 = user_2.reviews.create(title: "good book" , description:"amazing", rating: 5)
      review_6 = user_2.reviews.create(title: "bad book" , description:"lame", rating: 1)
      review_7 = user_2.reviews.create(title: "bad book" , description:"lame", rating: 1)
      user_3 = User.create(name: "Person Three")
      review_8 = user_3.reviews.create(title: "good book" , description:"amazing", rating: 5)
      review_9 = user_3.reviews.create(title: "good book" , description:"amazing", rating: 5)
      user_4 = User.create(name: "Person One")
      review_10 = user_4.reviews.create(title: "good book" , description:"amazing", rating: 5)

      expect(User.top_users).to eq([user_1, user_2, user_3])
    end
  end
end

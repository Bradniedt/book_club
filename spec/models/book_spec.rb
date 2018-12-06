require 'rails_helper'

RSpec.describe Book, type: :model do
  describe 'validations' do

    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:pages) }

  end

  describe 'relationships' do
    it { should have_many(:reviews)}
    it { should have_many(:book_authors)}
    it { should have_many(:authors).through(:book_authors)}

  end
end

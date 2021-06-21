require 'rails_helper'
RSpec.describe Friendship, type: :model do
  describe 'associations' do
    it { should belong_to(:user).class_name('User') }
    it { should belong_to(:friend).class_name('User') }
  end

  describe 'validations' do
    it { should validate_presence_of(:user) }
    it { should validate_presence_of(:friend) }
  end

  describe 'Friendship confirmed' do
    before :each do
      @user = User.create(id: 2, name: 'first', email: 'test@gmail.com', password: '1236476',
                          password_confirmation: '1236476')
      @friend = User.create(id: 1, name: 'second', email: 'testo@gmail.com', password: '1235679',
                            password_confirmation: '1235679')
    end
    after :each do
      @user.destroy
      @friend.destroy
    end
    it {
      friendship = Friendship.create(user_id: @user.id, friend_id: @friend.id, confirmed: true)
      expect(friendship.confirmed).to be true
    }

    it {
      Friendship.create(user_id: @user.id, friend_id: @friend.id, confirmed: true)
      expect(@user.friends.first.name).to eq 'first'
    }
  end
end

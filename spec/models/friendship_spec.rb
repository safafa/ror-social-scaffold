require 'rails_helper'
class FriendshipTest < ActiveSupport::TestCase
    context 'associations' do
      should belong_to(:user).class_name('User')
      should belong_to(:friend).class_name('User')
    end
    
    context 'validation' do
      should validate_presence_of(:user)
      should validate_uniqueness_of(:user).scoped_to(:user_id)
    end
  end
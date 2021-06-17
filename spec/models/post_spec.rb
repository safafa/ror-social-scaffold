require 'rails_helper'
RSpec.describe Post, type: :model do
  describe 'associations' do
    it { should belong_to(:user).class_name('User') }
    it { should have_many(:comments) }
    it { should have_many(:likes) }
  end
end
describe 'post process', type: :feature do
  before :each do
    @user = User.create(email: 'safa@gmail.com', password: '123456', name: '123456')
  end
  after :each do
    @user.destroy
  end

  it 'Add a like' do
    visit '/users/sign_in'
    fill_in 'Email', with: 'safa@gmail.com'
    fill_in 'Password', with: '123456'
    click_button 'Log in'
    visit '/posts/'
    fill_in 'Add New Post', with: 'test'
    click_button 'Save'
    expect(page).to have_text('Post was successfully created.')
  end
end

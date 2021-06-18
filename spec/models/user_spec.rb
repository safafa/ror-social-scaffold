require 'rails_helper'
RSpec.describe User, type: :model do
  describe 'associations' do
    it { should have_many(:comments) }
    it { should have_many(:likes) }
    it { should have_many(:posts) }
    it { should have_many(:friendships) }
    it { should have_many(:sent_friendships) }
    it { should have_many(:received_friendships) }
    it { should have_many(:confirmed_friendships) }
  end
end
describe 'the signin process', type: :feature do
  before :each do
    @user = User.create(email: 'safa@gmail.com', password: '123456', name: 'safa')
  end
  after :each do
    @user.destroy
  end
  it 'signs @user in' do
    visit '/users/sign_in'
    fill_in 'Email', with: 'safa@gmail.com'
    fill_in 'Password', with: '123456'
    click_button 'Log in'
    expect(current_path).to eq(root_path)
    expect(page).to have_text('Signed in successfully.')
  end

  it 'Should not signs @user in if not valid' do
    visit '/users/sign_in'
    fill_in 'Email', with: 'detola@gmail.com'
    fill_in 'Password', with: '123456'
    click_button 'Log in'
    expect(page).to have_text('Invalid Email or password.')
  end
end

describe 'the signout process', type: :feature do
  before :each do
    @user = User.create(email: 'deto@gmail.com', password: '123456', name: 'detola')
  end
  after :each do
    @user.destroy
  end
  it 'Log out the user' do
    visit '/users/sign_in'
    fill_in 'Email', with: 'deto@gmail.com'
    fill_in 'Password', with: '123456'
    click_button 'Log in'
    click_link 'Sign out'
    expect(current_path).to eq('/users/sign_in')
    expect(page).to have_text('You need to sign in or sign up before continuing.')
  end
end

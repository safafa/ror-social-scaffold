require 'rails_helper'
describe ' Send friendship process', type: :feature do
  before :each do
    @user = User.create(email: 'deto@gmail.com', password: '123456', name: 'detola')
    @friend = User.create(email: 'safa@gmail.com', password: '123456', name: 'safa')
  end
  after :each do
    @user.destroy
    @friend.destroy
  end
  it 'Visit profile' do
    visit '/users/sign_in'
    fill_in 'Email', with: 'deto@gmail.com'
    fill_in 'Password', with: '123456'
    click_button 'Log in'
    click_link 'All users'
    click_link 'My Profile'
    expect(page).to have_text('Name: detola')
  end
  it 'Visit profile' do
    visit '/users/sign_in'
    fill_in 'Email', with: 'deto@gmail.com'
    fill_in 'Password', with: '123456'
    click_button 'Log in'
    click_link 'All users'
    click_link 'My Profile'
    expect(page).to have_no_text('Name: safa')
  end
end

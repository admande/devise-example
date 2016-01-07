require 'rails_helper'
require 'spec_helper'

feature 'user signs in' do

  scenario 'an existing user specifies a valid email and password' do
    user = FactoryGirl.create(:user)
    visit root_path
    click_link 'Sign In'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Sign In'
    expect(page).to have_content "Welcome Back!"
    expect(page).to have_content "Sign Out"
  end

  scenario 'an nonexistant email and password are supplied' do
    visit root_path
    click_link 'Sign In'
    fill_in 'Email', with: 'nobody@example.com'
    fill_in 'Password', with: 'password'
    click_button 'Sign In'

    expect(page).to_not have_content "Welcome Back!"
    expect(page).to_not have_content "Sign Out"
    expect(page).to have_content "Invalid email or password"
  end

  scenario 'an existing email with wrong password is denied access' do
    user = FactoryGirl.create(:user)
    visit root_path
    click_link 'Sign In'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: '12345678'
    click_button 'Sign In'

    expect(page).to_not have_content "Welcome Back!"
    expect(page).to_not have_content "Sign Out"
    expect(page).to have_content "Invalid email or password"
  end

  scenario 'an already authenticated user cannot re-sign in' do
    user = FactoryGirl.create(:user)
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Sign In'

    expect(page).to have_content "Sign Out"
    expect(page).to_not have_content "Sign In"

    visit new_user_session_path
    expect(page).to have_content "You are already signed in."
  end
end

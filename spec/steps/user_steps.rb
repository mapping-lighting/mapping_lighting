module UserSteps

  step 'there is a user :email with password :password' do |email, password|
    User.create(email: email, password: password)
  end

  step 'I login as :email using password :password' do |email, password|
    visit new_user_session_path
    fill_in 'Email', with: email
    fill_in 'Password', with: password
    click_on 'Log in'
  end

  step 'I am signed in' do
    send 'there is a user :email with password :password', 'foo@bar.com', 'mapping.cool'
    send 'I login as :email using password :password', 'foo@bar.com', 'mapping.cool'
  end

  step 'I sign out' do
    click_on 'Logout'
  end

  step 'I should be signed in' do
    expect(page).to have_content("Signed in successfully.")
  end
  #
  step 'I should not be signed in' do
    expect(current_path).to eq '/users/sign_in'
  end
  #
  step 'I should be signed out' do
    expect(page).to have_content("Signed out successfully.")
  end
end


RSpec.configure { |c| c.include UserSteps }

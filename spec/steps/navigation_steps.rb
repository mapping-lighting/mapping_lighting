module NavigationSteps
  step 'I am on the homepage' do
    visit root_path
  end

  step 'I am on the manage observations page' do
    visit admin_observations_path
    expect(page).to have_content('Observation filters:')
  end
end

RSpec.configure { |c| c.include NavigationSteps }

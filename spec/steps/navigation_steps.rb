module NavigationSteps
  step 'I am on the homepage' do
    visit '/'
  end
end

RSpec.configure { |c| c.include NavigationSteps }

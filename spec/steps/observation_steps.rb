module ObservationSteps
  step 'there is a :observation_type observation' do |observation_type|
    ::Observation.create!(
        attachment: open('app/assets/images/IMG_3955.JPG'),
        recorder_location_data: {"latitude"=> -37.819766, "longitude"=>145.039041, "accuracy"=>40 },
        lighting_type: observation_type,
        note: 'This is a note',
        email: 'user_1@example.com',
        name: 'User 1',
        permission_given: true,
    )
  end

  step 'there should be an :observation_type observation' do |observation_type|
    within('table.observations_grid') do
      expect(page).to have_content(observation_type)
    end
  end

  step 'there should be no observations' do
    within('table.observations_grid') do
      expect(page).to have_css('td.noresults')
    end
  end

  step 'I delete an :observation_type observation' do |observation_type|
    within('table.observations_grid td.delete') do
      find('a').click()
    end
  end

  step 'I visit the manage observations page' do
    visit admin_observations_path
  end
end

RSpec.configure { |c| c.include ObservationSteps }
class ObservationsGrid

  include Datagrid

  scope do
    Observation
  end

  filter(:created_at,
         :date,
         :range => true,
         :class => 'datepicker',
         :header => "Created at (select date range)")

  filter(:lighting_type,
         :enum,
         :select => Observation::AVAILABLE_LIGHTING_TYPES,
         :checkboxes => true,
         :header => "Lighting type (multi select)",
         :class => 'checkbox')

  column(:attachment, :html => true) do |model|
    image_tag(model.attachment.thumb)
  end
  column(:lighting_type)
  column(:created_at) do |model|
    model.created_at.to_date
  end

  column(:name, :class => 'hidable')
  column(:email, :class => 'hidable')

  column(:view, :html => true) do |record|
    link_to observation_path(record), method: :get do
      raw('<span class="glyphicon glyphicon-eye-open"></span>')
    end
  end

  column(:delete, :html => true) do |record|
    link_to admin_observation_path(record), method: :delete, data: { confirm: 'Are you sure?' } do
      raw('<span class="glyphicon glyphicon-remove-circle"></span>')
    end
  end
end

class ObservationsGrid

  include Datagrid

  scope do
    Observation
  end

  filter(:created_at, :date, :range => true, :class => 'datepicker')
  filter(:lighting_type, :enum, :select => Observation::AVAILABLE_LIGHTING_TYPES, :multiple => true)

  column(:attachment, :html => true) do |model|
    image_tag(model.attachment.thumb)
  end
  column(:lighting_type)
  column(:created_at) do |model|
    model.created_at.to_datetime
  end

  column(:name)
  column(:email)

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

class ObservationsGrid

  def geographic_factory
    @geographic_factory ||= RGeo::Geographic.simple_mercator_factory
  end

  include Datagrid

  scope do
    Observation
  end

  filter(:created_at,
         :date,
         :range => true,
         :class => 'datepicker',
         :header => "Filter by date created (select date range)")

  filter(:lighting_type,
         :enum,
         :select => Observation::AVAILABLE_LIGHTING_TYPES,
         :checkboxes => true,
         :header => "Filter by lighting type (multi select)",
         :class => 'checkbox')

  column(:image, :html => true) do |model|
    image_tag(model.attachment.thumb)
  end
  column(:image, :html => false) do |model|
    model.attachment.url
  end

  column(:lighting_type)
  column(:created_at) do |model|
    format(model.created_at) do |value|
      value.to_date
    end
  end

  column(:latitude, :class => 'hidable')
  column(:longitude, :class => 'hidable')

  column(:geo, html: false) do |observation|
    begin
      location = geographic_factory.point(observation.longitude, observation.latitude)
      location.to_s
    rescue StandardError
      ""
    end
  end

  column(:name, :class => 'hidable')
  column(:email, :class => 'hidable')
  column(:note, :class => 'hidable')

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

json.array!(@observations) do |observation|
  json.extract! observation, :id, :hashid, :observed_at, :lighting_type, :recorder_location, :image_exif, :note, :email, :name, :session_id
  json.url observation_url(observation, format: :json)
end

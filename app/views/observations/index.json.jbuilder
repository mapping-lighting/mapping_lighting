json.array!(@observations) do |observation|
  json.extract! observation, :attachment, :id, :hashid, :observed_at, :lighting_type, :recorder_location, :image_exif, :note, :permission_given, :session_id
  json.url observation_url(observation, format: :json)
end

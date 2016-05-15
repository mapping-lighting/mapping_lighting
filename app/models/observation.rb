class Observation < ActiveRecord::Base
  # serialize :image_exif
  mount_uploader :attachment, ImageUploader

  AVAILABLE_LIGHTING_TYPES = [['Street lamp', 'street'], ['Bus stop','bus'], ['Retail/Industry', 'retail_industry'], ['Car park', 'car_park'], ['Advertising - General', 'advertising_general'], ['Other', 'other']]


  def latitude
    recorder_location_data['latitude'] unless !recorder_location_data
  end

  def longitude
    recorder_location_data['longitude'] unless !recorder_location_data
  end

  def lat_lng_display
    return "None recorded." if !latitude && !longitude;
    "#{latitude.round(5)} : #{longitude.round(5)}"
  end

  def lat_lng
    return "None recorded." if !latitude && !longitude;
    "#{latitude} : #{longitude}"
  end
end

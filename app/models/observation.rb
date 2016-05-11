class Observation < ActiveRecord::Base
  # serialize :image_exif
  mount_uploader :attachment, ImageUploader

  AVAILABLE_LIGHTING_TYPES = [['Street lamp', 'street'], ['Bus stop','bus'], ['Retail/Industry', 'retail_industry'], ['Car park', 'car_park'], ['Advertising - General', 'advertising_general'], ['Other', 'other']]


  def latitude
    recorder_location_data['latitude']
  end

  def longitude
    recorder_location_data['longitude']
  end
end

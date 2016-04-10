class Observation < ActiveRecord::Base
  # serialize :image_exif
  mount_uploader :attachment, ImageUploader
end

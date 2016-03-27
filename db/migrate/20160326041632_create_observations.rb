class CreateObservations < ActiveRecord::Migration
  def change
    create_table :observations do |t|
      t.string :hashid
      t.timestamp :observed_at
      t.st_point :recorder_location, geographic: true
      t.json :image_exif
      t.text :note
      t.string :email
      t.string :name
      t.string :session_id

      t.timestamps null: false
    end
  end
end

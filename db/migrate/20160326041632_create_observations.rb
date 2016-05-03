class CreateObservations < ActiveRecord::Migration
  def change
    create_table :observations do |t|
      t.string :hashid
      t.timestamp :observed_at
      t.string :attachment
      t.string :lighting_type
      t.st_point :recorder_location, geographic: true
      t.json :recorder_location_data
      t.json :image_exif
      t.text :note
      t.string :email
      t.string :name
      t.boolean :permission_given
      t.string :session_id

      t.timestamps null: false
    end
  end
end

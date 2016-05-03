# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
User.create(email: 'khodgkison@gmail.com', password: 'mapping')
User.create(email: 'garrow.bedrossian@gmail.com', password: 'mapping')

# Open image files, and create uploads

Observation.create(
  attachment: open('app/assets/images/IMG_3955.JPG'),
  recorder_location_data: {"latitude"=>-37.819766, "longitude"=>145.039041, "accuracy"=>40 },
  lighting_type: 'street',
  note: 'This is a note',
  email: 'user_1@example.com',
  name: 'User 1',
  permission_given: true,
)

Observation.create(
  attachment: open('app/assets/images/IMG_3956.JPG'),
  recorder_location_data: {"latitude"=>-37.820153, "longitude"=>145.041079, "accuracy"=>40 },
  lighting_type: 'street',
  note: 'This is another note',
  email: 'user_1@example.com',
  name: 'User 1',
  permission_given: true,
)

Observation.create(
  attachment: open('app/assets/images/IMG_3957.JPG'),
  recorder_location_data: {"latitude"=>-37.819094, "longitude"=>145.038990, "accuracy"=>40 },
  lighting_type: 'bus',
  note: 'This is a note from User 2',
  email: 'user_2@example.com',
  name: 'User 2',
  permission_given: true,
)

Observation.create(
  attachment: open('app/assets/images/IMG_3958.JPG'),
  recorder_location_data: {"latitude"=>-37.823047, "longitude"=>145.038861, "accuracy"=>40 },
  lighting_type: 'street',
  note: 'This is a note from User 3',
  email: 'user_3@example.com',
  name: 'User 3',
  permission_given: true,
)

Observation.create(
  attachment: open('app/assets/images/IMG_3959.JPG'),
  recorder_location_data: {"latitude"=>-37.821804, "longitude"=>145.041982, "accuracy"=>40 },
  lighting_type: 'car_park',
  note: 'This is another note from User 2',
  email: 'user_2@example.com',
  name: 'User 2',
  permission_given: true,
)

Observation.create(
  attachment: open('app/assets/images/IMG_3960.JPG'),
  recorder_location_data: {"latitude"=>-37.822483, "longitude"=>145.035235, "accuracy"=>40 },
  lighting_type: 'car_park',
  note: 'This is another note from User 2',
  email: 'user_2@example.com',
  name: 'User 2',
  permission_given: true,
)

Observation.create(
  attachment: open('app/assets/images/IMG_3961.JPG'),
  recorder_location_data: {"latitude"=>-37.822319, "longitude"=>145.039882, "accuracy"=>40 },
  lighting_type: 'car_park',
  note: 'This is another note from User 2',
  email: 'user_2@example.com',
  name: 'User 2',
  permission_given: true,
)

Observation.create(
  attachment: open('app/assets/images/IMG_3962.JPG'),
  recorder_location_data: {"latitude"=>-37.822394, "longitude"=>145.034838, "accuracy"=>40 },
  lighting_type: 'car_park',
  note: 'This is another note from User 2',
  email: 'user_4@example.com',
  name: 'User 4',
  permission_given: true,
)

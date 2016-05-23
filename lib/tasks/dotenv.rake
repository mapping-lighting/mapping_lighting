# See `config/database.yml`

desc 'Create a default .env local environment variables file.'
file '.env' do |task|
  dotenv_content = <<-DOTENV.strip_heredoc
  export MAPPING_LIGHTING_DATABASE_HOSTNAME=localhost
  export MAPPING_LIGHTING_DATABASE_USERNAME=postgres
  export MAPPING_LIGHTING_DATABASE_PASSWORD=

  # Enforce local links for development
  export PUBLIC_HOSTNAME=localhost:3000

  # AWS S3 Credentials and Bucket Name, for image uploads.
  # Production bucket is '2016-mapping-lighting'
  export AWS_ACCESS_KEY_ID=
  export AWS_SECRET_ACCESS_KEY=
  export AWS_S3_BUCKET_NAME=
  DOTENV

  puts "Writing default content into `#{task.name}`"

  puts
  puts dotenv_content

  File.write(task.name, dotenv_content)
end
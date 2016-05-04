# See `config/database.yml`

desc 'Create a default .env local environment variables file.'
file '.env' do |task|
  dotenv_content = <<-DOTENV.strip_heredoc
  export MAPPING_LIGHTING_DATABASE_HOSTNAME=localhost
  export MAPPING_LIGHTING_DATABASE_USERNAME=postgres
  export MAPPING_LIGHTING_DATABASE_PASSWORD=
  DOTENV

  puts "Writing default content into `#{task.name}`"

  puts
  puts dotenv_content

  File.write(task.name, dotenv_content)
end
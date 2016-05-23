# Configure the default hostname for use in generated links.
# Especially important for generating working password reset links in outbound mail.

ENV['PUBLIC_HOSTNAME'] ||= Rails.configuration.fallback_public_hostname

if ENV['PUBLIC_HOSTNAME']
  Rails.application.routes.default_url_options[:host] = ENV['PUBLIC_HOSTNAME']
end

require 'passwordless_config'

PasswordlessConfig.config = YAML.load_file("config/passwordless.yml")[Rails.env].symbolize_keys
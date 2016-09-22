OmniAuth.config.logger = Rails.logger


jwt_leeway = 5
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, '609202025898-351oqh8jsump2mjpupnu7e91qh98svj2.apps.googleusercontent.com', 'lZbKMUHPgUm-HFgmvuiA1KVj', {client_options: {ssl: {ca_file: Rails.root.join("cacert.pem").to_s}}}
end
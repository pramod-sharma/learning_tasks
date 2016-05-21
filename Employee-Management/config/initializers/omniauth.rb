Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_apps, :name => 'google', domain: 'vinsol.com'
end
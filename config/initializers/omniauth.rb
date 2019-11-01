Rails.application.config.middleware.use OmniAuth::Builder do
  # * credentialsを参照
  provider :google_oauth2, Rails.application.credentials.google[:google_client_id], Rails.application.credentials.google[:google_client_secret]
  provider :github, Rails.application.credentials.github[:github_client_id], Rails.application.credentials.github[:github_client_secret], scope: "user, repo"
end
# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_search_app_session',
  :secret      => '2793755031888845dafc25239bed07f86f9c1853ce89a463bcffc623f96c9eb778c10250ce97ecaf6dbb65d47fd7e75f4fee1234192c87870f02caf46bfbf9be'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store

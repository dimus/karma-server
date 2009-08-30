config.cache_classes = true # This must be true for Cucumber to operate correctly!

# Log error messages when you accidentally call methods on nil.
config.whiny_nils = true

# Show full error reports and disable caching
config.action_controller.consider_all_requests_local = true
config.action_controller.perform_caching             = false

# Disable request forgery protection in test environment
config.action_controller.allow_forgery_protection    = false

# Tell Action Mailer not to deliver emails to the real world.
# The :test delivery method accumulates sent emails in the
# ActionMailer::Base.deliveries array.
config.action_mailer.delivery_method = :test

config.gem 'cucumber',    :lib => false,        :version => '0.3.96'
config.gem 'webrat',      :lib => false,        :version => '0.5.0' 
config.gem 'rspec',       :lib => false,        :version => '1.2.6' 
config.gem 'rspec-rails', :lib => 'spec/rails', :version => '1.2.6' 
                                                                    

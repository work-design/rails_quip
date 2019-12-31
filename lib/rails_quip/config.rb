require 'active_support/configurable'

module RailsQuip #:nodoc:
  include ActiveSupport::Configurable

  configure do |config|
    config.admin_controller = 'AdminController'
    config.my_controller = 'MyController'
  end

end



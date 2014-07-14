require 'telesign/version'
require 'telesign/mock_service/railtie' if defined? Rails

module TeleSign
  autoload :TeleSignError, 'telesign/telesign_error'
  autoload :AuthorizationError, 'telesign/authorization_error'
  autoload :ValidationError, 'telesign/validation_error'
  autoload :Auth, 'telesign/auth'
  autoload :Response, 'telesign/response'
  autoload :Helpers, 'telesign/helpers'
  autoload :Verify, 'telesign/verify'
  autoload :PhoneId, 'telesign/phone_id'
  autoload :Api, 'telesign/api'
end

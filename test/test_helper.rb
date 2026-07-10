require 'uuid'
require 'time'
require 'test/unit'
require 'webmock/test_unit'

require 'telesignenterprise'

class TelesignEnterpriseTestCase < Test::Unit::TestCase

  def setup
    @customer_id = 'FFFFFFFF-EEEE-DDDD-1234-AB1234567890'
    @api_key = 'ABC12345yusumoN6BYsBVkh+yRJ5czgsnCehZaOYldPJdmFh6NeX8kunZ2zU1YWaUw/0wV6xfw=='
    @phone_number = '1234567890'
    @reference_id = '0123456789ABCDEF0123456789ABCDEF'
  end

end
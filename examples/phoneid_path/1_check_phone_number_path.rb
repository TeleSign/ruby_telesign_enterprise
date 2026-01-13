require 'telesign'
require 'telesignenterprise'

customer_id = 'FFFFFFFF-EEEE-DDDD-1234-AB1234567890'
api_key = 'ABC12345yusumoN6BYsBVkh+yRJ5czgsnCehZaOYldPJdmFh6NeX8kunZ2zU1YWaUw/0wV6xfw=='
phone_number = '11234567890'

phoneid_client = TelesignEnterprise::PhoneIdClient.new(customer_id, api_key)
response = phoneid_client.phone_id_path(phone_number)

puts "status_code=#{response.status_code}, ok=#{response.ok}, responsebody=#{response.body}"

if response.ok
  puts "Phone number %s carrier: '%s'" % [phone_number, response.json['carrier']['name']]
else
  puts "ERROR: #{response.status_code} - #{response.body}"
end

require 'telesign'
require 'telesignenterprise'

customer_id = 'FFFFFFFF-EEEE-DDDD-1234-AB1234567890'
api_key = 'ABC12345yusumoN6BYsBVkh+yRJ5czgsnCehZaOYldPJdmFh6NeX8kunZ2zU1YWaUw/0wV6xfw=='
phone_number = '11234567890' 

verify = TelesignEnterprise::AppVerifyClient.new(customer_id, api_key)

initiate_response = verify.initiate(phone_number)
puts "initiate response: #{initiate_response.body}\n"
reference_id = JSON.parse(initiate_response.body)['reference_id']
puts "Reference ID: #{reference_id}"
status_response = verify.get_transaction_status(reference_id)
puts "Status Code: #{status_response.status_code}"
puts "Status: #{JSON.parse(status_response.body)['status']['description']}"
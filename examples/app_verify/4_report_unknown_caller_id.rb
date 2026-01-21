require 'telesign'
require 'telesignenterprise'

customer_id = 'FFFFFFFF-EEEE-DDDD-1234-AB1234567890'
api_key = 'ABC12345yusumoN6BYsBVkh+yRJ5czgsnCehZaOYldPJdmFh6NeX8kunZ2zU1YWaUw/0wV6xfw=='
phone_number = '11234567890' 

verify = TelesignEnterprise::AppVerifyClient.new(customer_id, api_key)

initiate_response = verify.initiate(phone_number)
puts "initiate response: #{initiate_response.body}\n"
reference_id = JSON.parse(initiate_response.body)['reference_id']
prefix = JSON.parse(initiate_response.body)['prefix']

unless reference_id && prefix
  puts "Missing reference ID or prefix. Exiting."
  exit 1
end

unknown_caller_id = "#{prefix}99999" # simulate Unknown caller ID

unknown_response = verify.report_unknown_caller_id(reference_id, unknown_caller_id)
puts "Unknown caller ID report status code: #{unknown_response.status_code}\n"
puts "Unknown caller ID report response body: #{unknown_response.body}\n"
puts "Status: #{JSON.parse(unknown_response.body)['status']['description']}"
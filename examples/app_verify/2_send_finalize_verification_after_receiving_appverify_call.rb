require 'telesign'
require 'telesignenterprise'

customer_id = 'FFFFFFFF-EEEE-DDDD-1234-AB1234567890'
api_key = 'ABC12345yusumoN6BYsBVkh+yRJ5czgsnCehZaOYldPJdmFh6NeX8kunZ2zU1YWaUw/0wV6xfw=='
phone_number = '11234567890' 

app_verify = TelesignEnterprise::AppVerifyClient.new(customer_id, api_key)
initiate_response = app_verify.initiate(phone_number)
reference_id = JSON.parse(initiate_response.body)['reference_id']

unless reference_id
    puts "No reference ID returned from initiate call. Cannot finalize."
    exit 1
end

puts "Verification call initiated. Reference ID: #{reference_id}"
print "Please enter the verification code from the caller ID: "

verify_code = gets.chomp
finalize_response = app_verify.finalize(reference_id, verify_code: verify_code)

puts "Finalize response: #{finalize_response.body}"
puts "Status Code: #{finalize_response.status_code}"
puts "Status: #{JSON.parse(finalize_response.body)['status']['description']}"
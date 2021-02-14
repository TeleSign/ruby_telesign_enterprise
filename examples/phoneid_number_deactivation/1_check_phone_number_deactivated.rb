require 'telesignenterprise'

customer_id = 'Put your customer ID between these quotes.'
api_key = 'Put your API key between these quotes.'

phone_number = 'Put the complete phone number, no special characters or spaces and the country code here.'
ucid = "THEF"

phoneid_client = TelesignEnterprise::PhoneIdClient.new(customer_id, api_key)
response = phoneid_client.number_deactivation(phone_number, ucid)
pp(response.json)

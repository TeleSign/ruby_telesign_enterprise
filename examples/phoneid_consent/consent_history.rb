# Use the Consent History feature of the PhoneID Consent API to retrieve
# the complete consent history for a phone number.
# You can specify the add-on(s) the consent history is for.

require 'telesignenterprise'

customer_id = 'Put your customer ID between these quotes.'
api_key = 'Put your API key between these quotes.'

phone_number = 'Put the phone number you want to retrieve the consent history for here.'
consent_method = '1'

params = {:consent_history => consent_method, :addons => { :contact => {}}}

phoneid_client = TelesignEnterprise::PhoneIdClient.new(customer_id, api_key)
response = phoneid_client.consent_history(phone_number, **params)

pp(response.json)

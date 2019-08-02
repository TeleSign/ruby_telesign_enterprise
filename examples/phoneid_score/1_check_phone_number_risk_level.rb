require 'telesignenterprise'

customer_id = 'Put your customer ID between the quotes.'
api_key = 'Put your API key between the quotes.'

phone_number = 'Put your phone number between the quotes.'
account_lifecycle_event = "create"

phoneid_client = TelesignEnterprise::PhoneIdClient.new(customer_id, api_key)
response = phoneid_client.score(phone_number, account_lifecycle_event)
pp(response.json)

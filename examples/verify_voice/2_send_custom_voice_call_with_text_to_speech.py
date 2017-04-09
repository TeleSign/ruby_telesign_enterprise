from __future__ import print_function
from telesignenterprise.verify import VerifyClient
from telesign.util import random_with_n_digits

customer_id = "customer_id"
secret_key = "secret_key"

phone_number = "phone_number"
verify_code = random_with_n_digits(5)
tts_message = "Hello, your code is {verify_code}. Once again, your code is {verify_code}. Goodbye.".format(
    verify_code=", ".join(list(verify_code)))

verify = VerifyClient(customer_id, secret_key)
response = verify.voice(phone_number, tts_message=tts_message)

user_entered_verify_code = raw_input("Please enter the verification code you were sent: ")

if verify_code == user_entered_verify_code.strip():
    print("Your code is correct.")
else:
    print("Your code is incorrect.")

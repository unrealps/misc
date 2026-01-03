#!/bin/python3.12
import argparse
import pulsar
import time
from mq_authentication import get_authentication
from message_util import decrypt_message, message_id

# Parse command line arguments
parser = argparse.ArgumentParser(description="Pulsar Tuya MQ Authentication Reader")
parser.add_argument('--pulsar-url', required=True, help='Pulsar broker URL (e.g., pulsar://localhost:6650)')
parser.add_argument('--client-id', required=True, help='Tuya client_id')
parser.add_argument('--client-secret', required=True, help='Tuya client_secret')
parser.add_argument('--topic', default='my-topic', help='Topic name (default: my-topic)')
parser.add_argument('--start-message-id', default='earliest', help='Start message id: earliest, latest, or a specific id')
parser.add_argument('--regex', default=None, help='String to match against message content')

args = parser.parse_args()

# Create a Pulsar client with Tuya MQ authentication
client = pulsar.Client(
    args.pulsar_url,
    authentication=get_authentication(args.client_id,
                                      args.client_secret),
    tls_allow_insecure_connection=True
)

# Determine the start message id
if args.start_message_id == 'earliest':
    start_message_id = pulsar.MessageId.earliest
elif args.start_message_id == 'latest':
    start_message_id = pulsar.MessageId.latest
else:
    # For a specific message id, you would need to parse the id appropriately
    start_message_id = pulsar.MessageId.earliest  # Fallback

# Create a Pulsar reader
reader = client.create_reader(
    args.topic,
    start_message_id
)

print("Waiting for messages...")

try:
    while True:
        if reader.has_message_available():
            msg = reader.read_next(timeout_millis=5000)  # Wait up to 5 seconds
            decrypted_msg = decrypt_message(msg, args.client_secret)
                
            if args.regex == '' or args.regex is None:
                print(f"+(): ({msg.message_id()}): '{decrypted_msg}'")
            elif args.regex in decrypted_msg:
                highlighted = decrypted_msg.replace(args.regex, f"\033[32m{args.regex}\033[0m")
                print(f"+({args.regex}): ({msg.message_id()}): '{highlighted}'")
        else:
            time.sleep(1) # Sleep one seconde
except pulsar.Timeout:
    print("No messages received in the last 5 seconds.")
except KeyboardInterrupt:
    print("Stopped by user.")
finally:
    reader.close()
    client.close()

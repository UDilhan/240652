# Install dependencies
Run the following command :
`ansible-galaxy install -r ../requirements.yml`

# Run the playbook
## Inventory
Modify your inventory in `/ansible/inventory/hosts.init`

Go to `/ansible/config` and run the following command :

`ansible-playbook ../playbook.yml -u root --key-file "[specify your keyfile]"`


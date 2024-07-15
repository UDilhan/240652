# NCI Agency - DevOps Engineer - 240652 | Home assignment

## Assignment details
You are the engineer tasked to deploy and configure a system composed of two VMs, a webserver
and a database. The activity will target two environments at the same time.

Requirements:
- Deployment of the two VMs will be automated using Terraform
- Configuration of the two VMs will be automated using Ansible
- Write a simple REST call to read any data of the database

## Assumptions

### Environment
For this exercice, I will use a Proxmox hypervisor hosted in a physical bare metal at OVH that I have provisionned for the needs of the assignment. After the interview, the Proxmox node will be decommissioned.

### VMs
The 2 VMs will be using a default template of Debian 12 LXC container. They are deployed using Terraform.
They consist of :
1. One webserver
2. One database

I use Docker in each VM in order to show my ability to use that kind of technology, instead of directly installing the components in the 2 VMs.

I assign a public IP to my VMs to manage them

#### Webserver
The webserver will be a VM hosting a Docker image (php:8.2-apache) that includes the Apache 2 server (used for exposing the application using the HTTP protocol) and the PHP software for building and processing a PHP application.

#### Database
The database will also use a Docker image (mariadb:latest) of the famous MariaDB database. The application has a .SQL file that is actually a database backup that will be restored as soon as the database is installed. The data in that backup will then be used by the PHP application.

Here is the data that will be imported :

Database: app / Table: customers

| id | name   |
|----|--------|
| 1  | John   |
| 2  | Doe    |
| 3  | Robert |
| 4  | Justin |


### Application
The application is a PHP REST API that provides 3 routes :
#### Home
#### Listing all customers
Route: GET [API_URL]/customers (return 200 http code)
#### Details on a specified customer
Route: GET [API_URL]/customers/[id] (return 200 http code)

The API may return other HTTP codes depending on the received request. For example, 404 if the resource is not found using the second route, or 500 if the application is not able to connect to the database. In every cases, it will return a JSON output.

### Security
- The SQL connections between the 2 VMs are made using an internal network inside the Proxmox node.
- The application uses PDO connections in order to prevent SQL injection attacks.
- All the servers packages are updated in the first step of the Ansible script.

Some improvements could be done :
- Set an SSL certificate to enforce the SQL connections security
- Define a different SSH port and deny root authentication.
- Create a dedicated user for running Docker
- Using a technology like Hashicorp Vault to store the secrets used in the Terraform and Ansible scripts like passwords.
- Put an SSL certificate on the webserver (if possible, not a self-signed certificate so it should be pointing to a defined sub-domaine or FQDN)
- In a normal environment, the database VM should not be able to be accessed from internet. It should be through a trusted VPN for example.
- The internet exposure of the database VM could be closed after the Ansible script job.
- The packages downloaded for configuring the VMs should be downloaded from an internal package repository (like RedHat Satellite for the system packages and RedHat Automation Hub for the ansible scripts).

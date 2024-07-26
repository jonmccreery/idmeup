# idmeup
idmeup is a tiny web application that is deployed and managed using a custom designed build environment developed in four days.  The application itself along with other compute resources run on Google Compute instances under the management of Ansible, while the GCP envionment itself is provisioned using terraform.

# design principles
idme aims to be:

* automated:  The build system for idmeup is intened to 100% automated aside from populating site specific information such as ssh keys.  The entry point build.sh contains no logic and only executes terraform, ansible, and gcloud commands in sequence. 
* autonomous: other than the a working installtion of terraform and ansible, the only thing you need to run idmeup is a Google Cloud account and the gcloud command line client installed with authentication configured correctly.
* simple: in order to provide a clear view of the architecture of the system, all components have been built as minimally as possible while still retaining their purpose.
* scalable: although elements of the application are currently only represented by a single instance, the system is designed to scale horizontally.

# prereqs
--------
* a working Google Cloud account, and the gcloud command installed and authenticated. `gcloud auth login`
* this repo
* a service account in GCP project with appropriate permissions set.  gcp_tf_perms.sh in the root of the repository will do the work, but you need to edit it and change the PROJECT variable to match your project id, not friendly name
* a staging directory that contains both this repository and a directory named 'secret' containing:
  * the public half of an ssh key generated using ssh-keygen named 'ansible.pub'.  the private half should also be there named 'ansible'

# theory of operation
--------------------
The idmeup project has been designed from the ground up to be self contained and fully automated.  As such, other than a working internet connection and an account with Google, no other services or accounts should be necessary.

In order to achieve this goal, I needed to solve two fundamental problems.

First, how to managed connectivity between my development laptop and the resources I was managing in GCP, and also how to expose the application to the world in a scalable way.  For the first problem, the solution was to distribute keys to compute instances using GCP metadata at deployment time, then creating a bastion host with a public IP that I use to tunnnel Ansible traffic. For public consumption, I put the web application behind a pool of nginx servers running as pass through proxies.  Those in turn are located behind a GCP load balancers also configured as pass through proxies.  I adopted this two level approach in order to give myself the isolation and massive scale of google's load balancing while still retaining a greater level of control over inbound traffic using nginx as the application's needs evolve.

The second thing to design was a way to transfer information determined at build time, such as dynamically assigned IP address, from Terraform into Ansible.  The most straightforward way that I found was to directly create files in the idmeup working directory using a local_file resource in Terraform that I then reference during the Ansible run.

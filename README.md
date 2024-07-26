# idmeup
idmeup is a tiny web application that is deployed and managed using a custom designed build environment developed in four days.  The application itself, along with other compute resources, runs on Google Compute instances under the management of Ansible and the GCP envionment is provisioned using terraform.

# design principles
idmeup aims to be:

* automated:  The build system for idmeup is intened to be 100% automatic aside from populating site specific information such as ssh keys.  The entry point build.sh contains no logic and only executes terraform, ansible, and gcloud commands in sequence. 
* autonomous: other than the a working installtion of terraform and ansible, the only thing you need to run idmeup is a Google Cloud account and the gcloud command line client installed with authentication configured correctly.
* simple: in order to provide a clear view of the architecture of the system, all components have been built as minimally as possible while still retaining their function.
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

First, how to manage connectivity.  For command and control purposes, I needed a link to the project's VPC subnet and I also needed expose the application to the world in a scalable way.  For the first problem, I distribute keys to compute instances using GCP metadata at deployment time. I then create a bastion host with a public IP that I use to tunnnel Ansible traffic. 

To make the public interface between the application and the internet as robust as possible, I put the web application itself behind a pool of nginx servers running as pass through proxies.  Those in turn are located behind a GCP load balancer also configured as a raw TCP proxy.  I adopted this two level approach in order to give myself the isolation and massive scale of Google's load balancing infrstructure while still retaining a high level of control over inbound traffic using nginx.  As the application's needs evolve, it would be possible to implement more sophisticated balancing and routing stratagies, and terminating HTTPS traffic on infrastructure under our control gives similar benefits.

Secondly, I needed to design a way to transfer information determined at build time, like dynamically assigned IP addresses, from Terraform into Ansible.  The most straightforward way that I found was to directly create files in the idmeup working directory using a local_file resource in Terraform that I then reference during the Ansible run.

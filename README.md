# UPenn-Cybersecurity-Bootcamp
## Automated ELK Stack Deployment

The files in this repository were used to configure the network depicted below.





![Brett_Ott_Network_Diagram](https://user-images.githubusercontent.com/106977984/179813221-050d5e04-a30f-420c-ae46-0096b1ed1d60.PNG)

  
  These files have been tested and used to generate a live ELK deployment on Azure. They can be used to either recreate the entire deployment pictured above. Alternatively, select portions of the YAML files may be used to install only certain pieces of it, such as Filebeat.
  
  ![Install_ELK_YAML](https://user-images.githubusercontent.com/106977984/179809975-35aa2c5b-3b9f-4cce-83f5-f71c90f9aac3.png)
  
![Install_DVWA_YAML](https://user-images.githubusercontent.com/106977984/179812398-fa5d6ee2-e773-4d03-ba7c-50d6ab419448.png)
![Insall_Filebeat_YAML](https://user-images.githubusercontent.com/106977984/179812421-64c8a57e-882f-4cb8-9189-793eceaf1cf8.png)
![Install_MetricBeat_YAML](https://user-images.githubusercontent.com/106977984/179812437-3357f398-1a94-469b-a7de-f09b9b61bbd8.png)


This document contains the following details:
- Description of the Topology
- Access Policies
- ELK Configuration
  - Beats in Use
  - Machines Being Monitored
- How to Use the Ansible Build


### Description of the Topology

The main purpose of this network is to expose a load-balanced and monitored instance of DVWA, the D*mn Vulnerable Web Application.

Load balancing ensures that the application will be highly stable and available, in addition to restricting access to the network. Utilizing a load balancer helps ensure that the network remains available to be used as intended, it also helps protect the confidentiality of the netowrk by restricting access to only those who are authorized to access it. Utilizing a Jump Box offers the advantage of acting as a first line of defense against network intrusion as well as offering a consolidated starting point to administer the rest of the network.


Integrating an ELK server allows users to easily monitor the vulnerable VMs for changes to the system logs and system resources. Using Filebeat allows us to easily monitor the system logs for the network and record suspicious activity such as failed access attempts.  Metricbeat offers an additional layer of security by monitoring system resources such as CPU and Memory usage of the networked machines. Monitoring these resources could help to identify an Indicator of Attack (IOA).


The configuration details and function of each machine may be found below.

![Machine_Config_Table](https://user-images.githubusercontent.com/106977984/179812762-0809812e-1072-4c84-a35d-48cc37fdbb8d.png)

### Access Policies

The machines on the internal network are not exposed to the public Internet. However, the Web1, Web2 and ELK machines can accept connections via Port 80 from my personal machine. The only whitelisted IP address is:  71.164.113.222

Machines within the network can only be accessed by SSH via Port 22 from the Jump Box machine at IP 10.1.0.4


A summary of the access policies in place can be found in the table below.

![Access_Policies](https://user-images.githubusercontent.com/106977984/179812811-87f96561-4fe0-4817-96f7-a2d0e270cdb7.png)

### Elk Configuration

Ansible was used to automate configuration of the ELK machine. No configuration was performed manually, which is advantageous because it does not require any special coding knowledge to execute. Using Ansible playbooks also makes it very easy to create multiple copies of the same environment quickly. 

The playbook implements the following tasks:
•	Install docker module
•	Install python3
•	Increase the amount of memory available to the environment
•	Download and install the ELK container
•	Enable the docker container to start automatically on boot


The following screenshot displays the result of running `docker ps` after successfully configuring the ELK instance.

![Brett_Ott_Docker_ps](https://user-images.githubusercontent.com/106977984/179813397-1f3c49a5-f2b1-412a-a00c-8c8301ea3ee1.png)

### Target Machines & Beats
This ELK server is configured to monitor the following machines:

Web1-  10.1.0.5
Web2- 10.1.0.6


We have installed the following Beats on these machines:

Filebeat
Metricbeat

These Beats allow us to collect the following information from each machine:

Filebeat monitors system logs for Web1 and Web2 and records changes such as access attempts. Metricbeat keeps an eye on the system resources for Web1 and Web2 and can graphically display the load on CPU Usage, Memory Usage etc. Knowing the baseline, or what normal looks like for each machine, helps to identify if something is off that may be an indicator of an attack, such as a denial of service attack.


### Using the Playbook
In order to use the playbook, you will need to have an Ansible control node already configured. Assuming you have such a control node provisioned: 

SSH into the control node and follow the steps below:
- Copy the install_elk.yml file to the /etc/ansible directory.
- Update the hosts file to include the ip address for the ELK machine and include ansible_python_interpreter=/usr/bin/python3 after the ip address of the ELK machine.
- Run the playbook, and navigate to 20.9.39.118:5601  to check that the installation worked as expected.








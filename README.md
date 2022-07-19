# UPenn-Cybersecurity-Bootcamp
## Automated ELK Stack Deployment

The files in this repository were used to configure the network depicted below.

(c/Users/brett/Documents/CyberSecurityBootCamp/Week_13/Project_1/README/Images/Network_Diagram_2.png)

These files have been tested and used to generate a live ELK deployment on Azure. They can be used to either recreate the entire deployment pictured above. Alternatively, select portions of the Install ELK YAML file may be used to install only certain pieces of it, such as Filebeat.

  ![Network_Diagram_2](https://user-images.githubusercontent.com/106977984/179809201-cec1521c-5990-42d8-a432-560238c3f41a.png)

  ---
- name: Configure Elk VM with Docker
  hosts: elk
  remote_user: azadmin
  become: true
  tasks:
    # Use apt module
    - name: Install docker.io
      apt:
        update_cache: yes
        force_apt_get: yes
        name: docker.io
        state: present

      # Use apt module
    - name: Install python3-pip
      apt:
        force_apt_get: yes
        name: python3-pip
        state: present

      # Use pip module (It will default to pip3)
    - name: Install Docker module
      pip:
        name: docker
        state: present

      # Use command module
    - name: Increase virtual memory
      command: sysctl -w vm.max_map_count=262144

      # Use sysctl module
    - name: Use more memory
      sysctl:
        name: vm.max_map_count
        value: "262144"
        state: present
        reload: yes

      # Use docker_container module
    - name: download and launch a docker elk container
      docker_container:
        name: elk
        image: sebp/elk:761
        state: started
        restart_policy: always
        # Please list the ports that ELK runs on
        published_ports:
          -  5601:5601
          -  9200:9200
          -  5044:5044

      # Use systemd module
    - name: Enable service docker on boot
      systemd:
        name: docker
        enabled: yes

This document contains the following details:
- Description of the Topologu
- Access Policies
- ELK Configuration
  - Beats in Use
  - Machines Being Monitored
- How to Use the Ansible Build


### Description of the Topology

The main purpose of this network is to expose a load-balanced and monitored instance of DVWA, the D*mn Vulnerable Web Application.

Load balancing ensures that the application will be highly stable and available, in addition to restricting access to the network. Utilizing a load balancer helps ensure that the network remains available to be used as intended, it also helps protect the confidentiality of the netowrk by restricting access to only those who are authorized to access it. Utilizing a Jump Box offers the advantage of acting as a first line of defense against network intrusion as well as offering a consolidated starting point to administer the rest of the network.


Integrating an ELK server allows users to easily monitor the vulnerable VMs for changes to the system logs and system resources. Using Filebeat allows us to easily monitor the system logs for the network and record suspicious activity such as failed access attempts.  Metricbeat offers an additional layer of security by monitoring system resources such as CPU and Memory usage of the networked machines. Monitoring these resources could help to identify an Indicator of Attack (IOA).
- 

The configuration details and function of each machine may be found below.


|       NAME       |                             FUNCTION                             |                     IP ADDRESS                     | OPERATING   SYSTEM |   |
|:----------------:|:----------------------------------------------------------------:|:--------------------------------------------------:|:------------------:|---|
| Jump Box         | Gateway                                                          | 10.1.0.4-Network 20.119.167.247-Public(Not Static) | Linux              |   |
| Web 1            | DVWA Server                                                      | 10.1.0.5-Network 20.114.171.9-Public(Not Static)   | Linux              |   |
| Web 2            | DVWA Server                                                      | 10.1.0.6-Network 20.114.171.9-Public(Not Static)   | Linux              |   |
| ELK              | ELK Stack                                                        | 10.2.0.4-Network 20.9.39.118-Public(Not Static)    | Linux              |   |
| Personal Machine | Used to SSH into Jump Box,  Web1, Web2 and Connect to  ELK Stack | 71.164.113.222                                     | Windows 11         |   |



### Access Policies

The machines on the internal network are not exposed to the public Internet. However, the Web1, Web2 and ELK machines can accept connections via Port 80 from my personal machine. The only whitelisted IP address is:  71.164.113.222

Machines within the network can only be accessed by SSH via Port 22 from the Jump Box machine at IP 10.1.0.4
- _TODO: Which machine did you allow to access your ELK VM? What was its IP address?_

A summary of the access policies in place can be found in the table below.

| Name     | Publicly   Accessible | Allowed IP   Addresses            |   |   |
|----------|-----------------------|-----------------------------------|:-:|---|
| Jump Box | No                    | 71.164.113.222                    |   |   |
| Web 1    | No                    | 71.164.113.222 10.1.0.4 (via SSH) |   |   |
| Web 2    | No                    | 71.164.113.222 10.1.0.4 (via SSH) |   |   |
| ELK      | No                    | 71.164.113.222                    |   |   |
|          |                       |                                   |   |   |



### Elk Configuration

Ansible was used to automate configuration of the ELK machine. No configuration was performed manually, which is advantageous because it does not require any special coding knowledge to execute. Using Ansible playbooks also makes it very easy to create multiple copies of the same environment quickly. 

The playbook implements the following tasks:
•	Install docker module
•	Install python3
•	Increase the amount of memory available to the environment
•	Download and install the ELK container
•	Enable the docker container to start automatically on boot


The following screenshot displays the result of running `docker ps` after successfully configuring the ELK instance.

![TODO: Update the path with the name of your screenshot of docker ps output](/c/Users/brett/Documents/CyberSecurityBootCamp/Week_13/Project_1/Images/Brett_Ott_Docker_ps.png)

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

_TODO: Answer the following questions to fill in the blanks:_
- _Which file is the playbook? Where do you copy it?_
- _Which file do you update to make Ansible run the playbook on a specific machine? How do I specify which machine to install the ELK server on versus which to install Filebeat on?_
- _Which URL do you navigate to in order to check that the ELK server is running?






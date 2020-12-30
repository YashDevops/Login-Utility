# Login Utility (client-agent)

#### Problem Statement
Design a client server utility to fetch the number of ssh done from a particular node (where alpha-server is installed) to the server {where alpha-client is running} and get the details done by the respective node to that server

***

#### Approach

After going through the problem statement the first thing that came up on my mind was prometheus. Prometheus is a pull based metric fetcher. So I started designing same system design in my mind.


### Tool Used

* Terraform
* Ansible

# Installation

### Install Terraform

To install Terraform, find the [appropriate package](https://www.terraform.io/downloads.html) for your system and download it as a zip archive.

After downloading Terraform, unzip the package. Terraform runs as a single binary named `terraform`. Any other files in the package can be safely removed and Terraform will still function.

Finally, make sure that the `terraform` binary is available on your `PATH`. This process will differ depending on your operating system.

Print a colon-separated list of locations in your `PATH`.
```
    $ echo $PATH
```

Move the Terraform binary to one of the listed locations. This command assumes that the binary is currently in your downloads folder and that your `PATH` includes `/usr/local/bin`, but you can customize it if your locations are different.

```
$ mv ~/Downloads/terraform /usr/local/bin/
```

### Install Ansible

To install Ansible, find the [appropriate flavour](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html) for your system

```
$ sudo apt update
$ sudo apt install software-properties-common
$ sudo apt-add-repository --yes --update ppa:ansible/ansible
$ sudo apt install ansible
```

#### 1. Agent :
A simple python_flask api that uses external command `last` to fetch data from system and the create a json with metadata and all the login events.
```
uri : /login-metrics

method : GET

port : 5000
```
#### 2. Client :
A Python Utility that fetches the list of `IP's` from config.ini and use request module to call the `/login-metrics` URI from the agent and manage the state of all the events in `data` folder

### Language used :
- python3

### Prerequisites
:exclamation: Bugs

Both `Agent` and `Client` requires python3 to start and working



# :rocket: Launch


### Deployment

#### The above deployment setup a node for you and setup the application i.e agent in the node also. The complete deployment is written via terraform and ansible on top of it to configure the node.


1. Clone the following Repo

```
git clone https://github.com/YashDevops/Login-Utility.git

cd Login-Utility/deployment/projects/prod/assignment
```


2. Edit the `provider.tf`

- change  the following line and add `{user-name}` with your username
- change `{profile}` with your aws profile with all the access to allow run this terraform code

```
provider "aws" {
  region = "us-east-1"
  shared_credentials_file = "/Users/{user-name}/.aws/credentials"    ## {user-name} : Replace it with your username and path with your to allow access to aws credentials files
  profile                 = "{profile}"                        ## {profile} : Enter the profile that you want to use. By Default the profile is : default
}
```

3. Get the `canonical Id` for your account

Run the following Command and you will get the canonical Id for you account for the `data` in `terraform` to fetch `ami` with respective filters

```
aws ec2 describe-images --filters "Name=name,Values=ubuntu/images/hvm-ssd/ubuntu-bionic-18.04*"  --query 'Images[*].{CanonicalID:OwnerId, N:Name}' | head -n6
```

The output will looks something like this



4. Run the following command to run the `terraform` code

```
terraform init

terraform plan -var 'Name=yashshah' -var 'Team=infra-team' -var 'Project=login-utility'   -var 'account_id={canonical_id}'    #get the canonical_id from step 3

terraform apply -var 'Name=yashshah' -var 'Team=infra-team' -var 'Project=login-utility' -var 'account_id={canonical_id}' -auto-approve


```

The following variable pass on with the commands are for the Tagging purpose of the complete project. There is another variable called `{canonical_id}` you can substitute it with the `canonical id` of your account which you can get via `step3`

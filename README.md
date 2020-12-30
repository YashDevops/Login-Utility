# Login Utility {client-agent}

#### Problem Statement
* Design a {Client-Agent} utility such that the agent can be installed on any instance and client has the ability to fetch login details from all the instances such.
* Create adeployment Stack for the above utility too
***

#### Approach

After going through the problem statement the first thing that came up on my mind was prometheus. Prometheus is a pull based metric fetcher. So I started designing same system design in my mind.

* Created a flask api which call and external command `[last]` and generate a json with adding instance metadata with it.
* Created a python script that will call tha flask API and parse the json and manage state in local in flat file. And the provide the data by the state file.

### Language used :
- python3

### Tool Used For Deployment

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



#### 1. About Agent :
A simple python_flask api that uses external command `last` to fetch data from system and the create a json with metadata and all the login events.
```
uri : /login-metrics

method : GET

port : 5000
```
#### 2. Client :
A Python Utility that fetches the list of `IP's` from config.ini and use request module to call the `/login-metrics` URI from the agent and manage the state of all the events in `data` folder


### Prerequisites
:exclamation: Bugs

Both `Agent` and `Client` requires python3 to start and working



# :rocket: Launch {Agent Infra | Application Setup}


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



5. Copy The Node Ip

```
Apply complete! Resources: 22 added, 0 changed, 0 destroyed.

Outputs:

Node1 = X.X.X.X

```



# :rocket: Launch {Client}

1. Teleport yourself to the client code

```
cd Login-Utility/client/bin
```

2. Edit the `config.ini`

```
[config]
#List all the ips that have agent installed in it. You can add multiple ip like : ip1, ip2
ips = ## Paste Your Node IP which you copied in the step 5 of lauching client
#Port Number in which the application is running
port = 5000

```


3. Run the Client python app

## :warning: Make sure python3 is set as your default python. Coz some methods are not supported in python2

```
python3 app.py
```



### Built With : 
#### 1 https://api.ipify.org : For Fetching Public_Ip

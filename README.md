# Login Utility (client-agent)

#### Problem Statement
Design a client server utility to fetch the number of ssh done from a particular node (where alpha-server is installed) to the server {where alpha-client is running} and get the details done by the respective node to that server

***

#### Approach

After going through the problem statement the first thing that came up on my mind was prometheus. Prometheus is a pull based metric fetcher. So I started designing same system design in my mind.

#### 1. Agent :
A simple python_flask api that uses external command `last` to fetch data from system and the create a json with metadata and all the login events.

uri : /login-metrics
method : GET
port : 5000

#### 2. Client :
A Python Utility that fetches the list of `IP's` from config.ini and use request module to call the `/login-metrics` URI from the agent and manage the state of all the events in `data` folder

### Language used :
- python

### Prerequisites
:exclamation: Bugs

Both `Agent` and `Client` requires python3 to start and working



## Getting Started
---

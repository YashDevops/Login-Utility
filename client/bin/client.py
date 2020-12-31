import configparser, os
import json
import requests
from configparser import ConfigParser


config = configparser.ConfigParser()
config.read('config.ini')
save_path = '../data/'
completeName = os.path.join(save_path,"metadata.txt")

GET_URI = "login-metrics"

def main():
    config_details = config_parser()
    config_details=config_details[0]
    try:
        if config_parser != None:
            fetched_data = data_fetcher(config_details['ips_list'],config_details['port'])
            state_manager(fetched_data)
        else:
            print("host ip not found")
    except Exception as e:
        pass


def state_manager(fetched_data):
    '''
        method to save the fetched_data from agents
        params : fetched_data , all the agent events json

    '''
    result = []
    open(completeName, "w").close()
    for data in range(len(fetched_data)):
        new_data = fetched_data[data].json()
        result.append(new_data)
    with open(completeName,'a') as file:
        file.write(json.dumps(result))

def reader():
    '''
        method to read data from state file and pass on the output to cli_viewer() method
    '''
    response = []
    completeName = os.path.join(save_path,"metadata.txt")
    with open(completeName,'r') as file:
        for jsonobj in file:
            json_data = json.loads(jsonobj)
            for data in range(len(json_data)):
                response.append({"ip":json_data[data]["public_ip"],"hostname":json_data[data]["hostname"],"logged_events":json_data[data]["events"]})
    return response

def data_fetcher(ips_list,port):
    '''
        method fetched list of ips from config_parser() method and call the agents url under specific ip and port
        params:
            ips_list : list of ips where agents are setup
            port : The port where the agent is listening on

    '''
    response_list = []
    for data in range(len(ips_list)):
        ips=ips_list[data]
        try:
            url="http://"+ips+":"+port+"/"+GET_URI
            result=requests.get(url)
            response_list.append(result)
        except Exception as e:
            print("It's Seems like One of the agent is down",ips)
    return(response_list)

def config_parser():
    '''
        config_parser() method to parse data from config.ini which contains list of ips and port

    '''
    response=[]
    option_values = config.get("config","ips")
    port = config.get("config","port")
    option_values=option_values.split(",")
    response.append({"ips_list":option_values,"port":port})
    return response




if __name__ == "__main__":
    main()

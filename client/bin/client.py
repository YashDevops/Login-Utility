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
    lcompleteName = os.path.join(save_path,"metadata.txt")
    for data in range(len(fetched_data)):
        new_data = fetched_data[data].json()
        for logins in new_data:
            try:
                with open(completeName,'w') as file:
                    file.write(json.dumps(logins))
            except Exception as e:
                print(e)

def reader():
    response = []
    completeName = os.path.join(save_path,"metadata.txt")
    with open(completeName,'r') as file:
        file_data=file.read()
        json_data = json.loads(file_data)
        for data in json_data["events"]:
            if 'still' in data:
                response.append({"ip":json_data["public_ip"],"hostname":json_data["hostname"],"logged_events":data})
    return response

def data_fetcher(ips_list,port):
    response_list = []
    for data in range(len(ips_list)):
        ips=ips_list[data]
        try:
            url="http://"+ips+":"+port+"/"+GET_URI
            result=requests.get(url)
            response_list.append(result)
        except Exception as e:
            print("Exception occured")
    return(response_list)

def config_parser():
    response=[]
    option_values = config.get("config","ips")
    port = config.get("config","port")
    option_values=option_values.split(",")
    response.append({"ips_list":option_values,"port":port})
    return response




if __name__ == "__main__":
    main()

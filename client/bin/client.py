import configparser, os
import json
import requests
from configparser import ConfigParser


config = configparser.ConfigParser()
config.read('config.ini')


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
    for data in range(len(fetched_data)):
        for new_data in fetched_data[data].json():
            print(new_data['public_ip'])




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

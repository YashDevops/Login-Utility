import os
from requests import get

ip = get('https://api.ipify.org').text
print('My public IP address is: {}'.format(ip))

def parser(string):
    '''
        The following method parses the string and format it to a nested listed events

        params : string : <type(str)>
    '''
    result = []
    events = []
    try:
        metadata=metadata_fetcher()
        data = string.split("\n")
        for each_login in range(len(data)):
            new_data = data[each_login].split()
            events.append(new_data)
        print(metadata[0]['public_ip'])
        result.append({"public_ip":metadata[0]['public_ip'],"hostname":metadata[0]['hostname'],"release":metadata[0]['release'],"sysname":metadata[0]['sysname'],"events":events})
        return result
    except Exception as e:
        logger.debug("something went wrong",exception)
        return "something went wrong"



def metadata_fetcher():
    '''
        The following method fetches the public ip for the given machine and also generate a metadata json to be send via events

    '''
    metadata = []
    data=os.uname()
    try:
        ip = get('https://api.ipify.org').text
        metadata.append({"public_ip":ip,"hostname":data.nodename,"release":data.release,"arch":data.machine,"sysname":data.sysname})
        return metadata
    except Exception as e:
        logger.debug("While fetching the public ip via metadata following error occured",exception)
        return exception

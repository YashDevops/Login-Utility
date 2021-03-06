import os
from requests import get

ip = get('https://api.ipify.org').text

def parser(string):
    '''
        The following method parses the string and format it to a nested listed events

        params : string : <type(str)>
    '''
    try:
        result = []
        events = []
        metadata=metadata_fetcher()
        data = string.split("\n")
        for each_login in range(len(data)):
            new_data = data[each_login].split()
            if "still" in new_data:
                events.append(new_data)
        result={"public_ip":metadata[0]['public_ip'],"hostname":metadata[0]['hostname'],"release":metadata[0]['release'],"sysname":metadata[0]['sysname'],"events":events}
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

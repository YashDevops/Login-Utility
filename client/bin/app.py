import time
import os
import client



def main():
    '''
        main function which present the data from cli_viewer() method and shows the output in cli
        params : NULL

    '''
    print("ip","\t\t","Hostname","  ","User"," ","Terminal","Login At","\t\t","Status")
    cli_viewer()


def cli_viewer():
    '''
        function which reads the dynamic events from state file and

        params : NULL

    '''
    data = client.reader()
    for events in data:
        print(events["ip"],events["hostname"],events["logged_events"][0],events["logged_events"][1],events['logged_events'][2]+" "+events['logged_events'][3]+" "+events['logged_events'][4]+" "+events['logged_events'][5],events['logged_events'][6]+" "+events['logged_events'][7])


if __name__ == "__main__":
    client.main()
    main()

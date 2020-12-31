import time
import os
import client
import re



ip_patterns = re.compile("^\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}$")

def main():
    '''
        main function which present the data from cli_viewer() method and shows the output in cli
        params : NULL

    '''
    print("ip","\t\t","Hostname","\t ","User","\t    ","Terminal","\t","Client IP","\t  ","Login At","\t      ","Status")
    cli_viewer()


def cli_viewer():
    '''
        function which reads the dynamic events from state file and

        params : NULL

    '''
    data = client.reader()
    for events in range(len(data)):
        for logged_events in data[events]["logged_events"]:
            if logged_events[0] != "reboot":
                ip_check = ip_patterns.match(logged_events[2])
                if ip_check:
                    time_date = logged_events[3]+" "+logged_events[4]+" "+logged_events[5]+" "+logged_events[6]
                    status = logged_events[7]+" "+logged_events[8]
                    print(data[events]["ip"],data[events]["hostname"],"\t  ",logged_events[0],"  ",logged_events[1],"\t",logged_events[2],"  ",time_date,"  ",status)
                else:
                    host_ip="localhost"
                    time_date = logged_events[2]+" "+logged_events[3]+" "+logged_events[4]+" "+logged_events[5]
                    status = logged_events[6]+" "+logged_events[7]
                    print(data[events]["ip"],data[events]["hostname"],"\t",logged_events[0],"  ",logged_events[1],"\t",host_ip,"\t  ",time_date,"  ",status)
if __name__ == "__main__":
    client.main()
    main()

import time
import os
import client



def main():
    print("ip","\t\t","Hostname","  ","User"," ","Terminal","Login At","\t\t","Status")
    while True:
        cli_viewer()
        time.sleep(10)
        os.system('clear')

def cli_viewer():
    data = client.reader()
    for events in data:
        print(events["ip"],events["hostname"],events["logged_events"][0],events["logged_events"][1],events['logged_events'][2]+" "+events['logged_events'][3]+" "+events['logged_events'][4]+" "+events['logged_events'][5],events['logged_events'][6]+" "+events['logged_events'][7])


if __name__ == "__main__":
    main()

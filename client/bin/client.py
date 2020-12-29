import configparser, os
from configparser import ConfigParser



fileDir = os.path.dirname(os.path.abspath(__file__))
parentDir = os.path.dirname(fileDir)
parser = ConfigParser()
data=parser.read(parentDir+'/config/config.ini')
print(parser.sections())
for data in parser['settings']:
    print(parser[data])

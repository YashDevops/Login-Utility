from flask import Flask , request
from flask_restful import Resource, Api
import logging
import uuid
import json
import helper
import subprocess


# DEBUG: Detailed information, typically of interest only when diagnosing problems.

# INFO: Confirmation that things are working as expected.

# WARNING: An indication that something unexpected happened, or indicative of some problem in the near future (e.g. ‘disk space low’). The software is still working as expected.

# ERROR: Due to a more serious problem, the software has not been able to perform some function.

# CRITICAL: A serious error, indicating that the program itself may be unable to continue running.

logging.basicConfig(
    level=logging.INFO,
    format="%(asctime)s [%(levelname)s] %(message)s",
    handlers=[
        logging.FileHandler("debug.log"),
        logging.StreamHandler()
    ]
)

app=Flask(__name__)
api=Api(app)



class Datasource(Resource):
    def get(self):
        '''
            get function to fetch logging mertics from the server and parse it if the command exit code it 0
        '''
        try:
            process = subprocess.run("last",shell=True ,stdout = subprocess.PIPE, text=True)
            if process.returncode == 0:
                logging.debug("Command executed successfully sending stdout for parsing")
                output=helper.parser(process.stdout)
            return output
        except exception as e:
            logging.debug("The exist code is not 0 {}".format(process.stderr))
            print(process.stderr)




api.add_resource(Datasource,"/login-metrics")




app.run(host='0.0.0.0',port=5000)

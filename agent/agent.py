from flask import Flask , request
from flask_restful import Resource, Api
import uuid
import json
import subprocess


app=Flask(__name__)
api=Api(app)



class Datasource(Resource):
    def get(self):
        my_dict = {}
        process = subprocess.Popen("last",shell=True ,stdout = subprocess.PIPE)
        process.wait()
        data, err = process.communicate()
        data=data.decode("utf-8").split("\n")
        return data




api.add_resource(Datasource,"/login-metrics")




app.run(host='0.0.0.0',port=5000)

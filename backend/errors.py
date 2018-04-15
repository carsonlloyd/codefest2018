import json

def InvalidArguments(message):
    response = {"message":message,"status_code":400}
    return json.dumps(response)

def InternalServerError(message):
    response = {"message":message,"status_code":500}
    return json.dumps(response)
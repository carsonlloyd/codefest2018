from flask import Flask
from flask import abort
from flask import request
from flask import jsonify
from SheetsAdapter import SheetsAdapter
from jsonschema import validate
from jsonschema.exceptions import ValidationError
import json
from errors import InvalidArguments
from errors import InternalServerError
from HtmlGenerator import HtmlGenerator

app = Flask(__name__)

sheet = SheetsAdapter("American Water Pipe Restraint")

schema = {
    "type": "object",
    "properties": {
        "design_pressure": {"type": "string", "pattern": "^\d+(.\d+)*$"},
        "depth": {"type": "string", "pattern": "^\d+(.\d+)*$"},
        "soil_type": {"type": "string",
                      "enum": ["Clay 1", "Silt 1", "Clay 2", "Silt 2", "Coh-Gran", "Sand/Silt", "Good Sand/Gravel", ]},
        "trench_type": {"type": "string", "pattern": "^[2,3,4,5]$"},
        "safety_factor": {"type": "string", "pattern": "^\d+(.\d+)*$"}
    },
    "required": ["design_pressure", "depth", "soil_type", "trench_type", "safety_factor"]
}


@app.route('/minrestrainedlength', methods=['GET'])
def min_restrained_length():
    # validate({"name": "Eggs", "price": 34.99}, schema)
    query = request.args.to_dict()
    try:
        validate(query, schema)
        sheet.setCell("Restraint Calculator", "E29", query["design_pressure"])
        sheet.setCell("Restraint Calculator", "E31", query["depth"])
        sheet.setCell("Restraint Calculator", "E33", query["soil_type"])
        sheet.setCell("Restraint Calculator", "E35", query["trench_type"])
        sheet.setCell("Restraint Calculator", "E37", query["safety_factor"])

        results = {"No Polyethylene Encasement": {"Horizontal": sheet.getRange("Restraint Calculator", "D46:H49"),
                                                  "Vertical Down": sheet.getRange("Restraint Calculator", "D52:H55"),
                                                  "Vertical Up": sheet.getRange("Restraint Calculator", "D58:H61"),
                                                  "Dead End": sheet.getRange("Restraint Calculator", "D64:H64")},
                   "Polyethylene Encasement": {"Horizontal": sheet.getRange("Restraint Calculator", "L46:P49"),
                                               "Vertical Down": sheet.getRange("Restraint Calculator", "L52:P55"),
                                               "Vertical Up": sheet.getRange("Restraint Calculator", "L58:P61"),
                                               "Dead End": sheet.getRange("Restraint Calculator", "L64:P64")}
                   }
        if (str(request.accept_mimetypes) == "application/json"):
            return jsonify(results)
        else:
            return HtmlGenerator.render(results)
    except ValidationError as e:
        return InvalidArguments(e.message)
    except Exception as e:
        return InternalServerError(str(e))


if __name__ == '__main__':
    app.run("0.0.0.0", 5000)

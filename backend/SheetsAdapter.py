import os
import gspread
from oauth2client.service_account import ServiceAccountCredentials
from httplib2 import ServerNotFoundError
import re
import numpy as np
from gspread.exceptions import SpreadsheetNotFound


class SheetsAdapter:
    def __init__(self, name):
        scope = ['https://spreadsheets.google.com/feeds',
                 'https://www.googleapis.com/auth/drive']

        basepath = os.path.dirname(os.path.realpath(__file__))

        try:
            credentials = ServiceAccountCredentials.from_json_keyfile_name(basepath + '/MyProject-b02336e157a2.json',
                                                                           scope)
        except FileNotFoundError:
            raise Exception("credentials file is missing")

        try:
            self.gc = gspread.authorize(credentials)
        except ServerNotFoundError:
            raise Exception("could not connect to google api")
        except Exception as e:
            raise e  # catch all the exceptions I don't know about yet

        try:
            self.wks = self.gc.open(name)  # TODO: multiple sheet
            self.sheets = list(map(lambda x: x.title, self.wks.worksheets()))
        except Exception as e:
            raise e

    def setCell(self, sheet_name, cell_string, data):
        try:
            sheet = self.wks.get_worksheet(self.sheets.index(sheet_name))
            sheet.update_acell(cell_string, data)
        except ValueError:
            raise Exception("Sheet does not exist")

    def getCell(self, sheet_name, cell_string):
        try:
            sheet = self.wks.get_worksheet(self.sheets.index(sheet_name))
            return sheet.acell(cell_string).value
        except ValueError:
            raise Exception("Sheet does not exist")

    def getRange(self, sheet_name, range_string):
        column_letters = re.findall(r'[A-Z]+', range_string)
        row_numbers = re.findall(r'\d+', range_string)
        assert (len(column_letters) == 2)  # just a sanity check
        assert (len(row_numbers) == 2)
        # TODO: handle two letter columns

        try:
            sheet_data = self.wks.get_worksheet(self.sheets.index(sheet_name)).range(range_string)
            sheet_data = list(map(lambda x: x.value, sheet_data))
            data_array = np.array(sheet_data).reshape(
                (ord(column_letters[1]) - ord(column_letters[0]) + 1, int(row_numbers[1]) - int(row_numbers[0]) + 1))

            return data_array.tolist()
        except ValueError:
            raise Exception("Sheet does not exist")

    def get_lock(self):
        if (self.getCell("Locks", "B1") == "0"):
            self.setCell("Locks", "B1", 1)
        else:
            raise Exception("can't obtain lock")

    def release_lock(self):
        self.setCell("Locks", "B1", 0)
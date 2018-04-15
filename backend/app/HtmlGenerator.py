class HtmlGenerator:
    base_page = '<html>' \
                '   <head>' \
                '       <style>' \
                '           body {' \
                '               font-family: -apple-system, BlinkMacSystemFont, sans-serif;' \
                '           }' \
                '           table {' \
                '               border-collapse: collapse;' \
                '           }' \
                '           tr {' \
                '               border: solid grey;' \
                '               border-width: 1px 0;' \
                '           }' \
                '           td {' \
                '               text-align: center;' \
                '           }' \
                '           .label {' \
                '               text-align: left;' \
                '           }' \
                '           th {' \
                '               padding-left: 8px;' \
                '           }' \
                '           h1 {' \
                '               text-align: center;' \
                '           }' \
                '       </style>' \
                '   </head>' \
                '   <body>' \
                '       $groups$' \
                '       <div style="width:100%;padding-top:20px;padding-bottom:10px;text-align:center;">Developed at Philly Codefest 2018</div>' \
                '   </body>' \
                '</html>'
    group = '<div style="width:80%;margin-left:auto;margin-right:auto"> ' \
            '<h1>$label$</h1>' \
            '$tables$' \
            '</div>'

    table = '   	<div>' \
            '          <div style="text-align: center;padding-bottom: 5px;padding-top: 10px;">$title$</div>' \
            '          <table style="width: 100%;">' \
            '               <tr>' \
            '                   <th></th>' \
            '                   <th>6"</th>' \
            '                   <th>8"</th> ' \
            '                   <th>10"</th>' \
            '                   <th>12"</th>' \
            '                   <th>16"</th>' \
            '               </tr>' \
            '               $row$' \
            '           </table>' \
            '           </div>'
    row = '	  <tr>' \
          '     <td class="label">$label$</td>' \
          '<td>$0$</td>' \
          '<td>$1$</td> ' \
          '<td>$2$</td>' \
          '<td>$3$</td>' \
          '<td>$4$</td>' \
          '</tr>'

    labels = ["90˚ Bend", "45˚ Bend", "22.5˚ Bend", "11.25˚ Bend"]

    @classmethod
    def build_row(cls, label, data):
        return cls.row.replace("$label$", label) \
            .replace("$0$", data[0]) \
            .replace("$1$", data[1]) \
            .replace("$2$", data[2]) \
            .replace("$3$", data[3]) \
            .replace("$4$", data[4])

    @classmethod
    def build_table(cls, label, data):
        row = ""
        for i, data_row in enumerate(data):
            row += cls.build_row(cls.labels[i], data_row)
        return cls.table.replace("$title$", label).replace("$row$", row)

    @classmethod
    def build_group(cls, label, data):
        group = ""
        for key, val in data.items():
            group += cls.build_table(key, val)
        return cls.group.replace("$label$", label).replace("$tables$", group)

    @classmethod
    def render(cls, data):
        tables = ""
        for key, val in data.items():
            tables += cls.build_group(key, val)

        return cls.base_page.replace("$groups$", tables)

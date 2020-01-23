namespace: Exchange_rates.operations
operation:
  name: write_csv_file
  inputs:
    - file_path
    - delimiter: ','
    - fields
    - file_input
  python_action:
    script: |-
      import csv
      import ast

      fields = ast.literal_eval(fields)
      file_input = ast.literal_eval(file_input)
      delimiter=str(delimiter)
      message = ''

      try:
          with open(file_path, 'w') as csvFile:
              writer = csv.DictWriter(csvFile, fieldnames=fields, delimiter=delimiter)
              writer.writeheader()
              writer.writerows(file_input)
          message = "writing completed"
          csvFile.close()
      except Exception as e:
          message = e
  outputs:
    - message
  results:
    - SUCCESS

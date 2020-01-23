namespace: Exchange_rates.operations
operation:
  name: read_csv_file
  inputs:
    - file_path
    - delimiter: ','
  python_action:
    script: |-
      import csv

      delimiter=str(delimiter)
      file_contents = []
      message = ''

      try:
          csv_file = open(file_path, mode='r')
          csv_reader = csv.DictReader(csv_file, delimiter=delimiter)
          line_count = 0
          for row in csv_reader:
              file_contents.append(row)
              line_count += 1
          csv_file.close()
          file_contents = str(file_contents)
          message = 'Processed %d lines.' % line_count
      except Exception as e:
          file_contents = str(file_contents)
          message = e
  outputs:
    - file_contents
    - message
  results:
    - SUCCESS

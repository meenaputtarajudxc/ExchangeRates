namespace: Exchange_rates.operations
operation:
  name: validate_exchange_rates
  inputs:
    - bloomberg_rates_file_path
    - netsuite_rates_file_path
  python_action:
    script: "# Compare the Bloomberg exchange rates with the ones present in NetSuite\nimport csv\n\ndef read_csv(file_path, delimiter):\n\n    file_contents = []\n    message = ''\n    \n    try:\n        csv_file = open(file_path, mode='r')\n        csv_reader = csv.DictReader(csv_file, delimiter=delimiter)\n        line_count = 0\n        for row in csv_reader:\n            file_contents.append(row)\n            line_count += 1\n        csv_file.close()\n        message = 'Processed %d lines.' % line_count\n    except Exception as e:\n        message = e\n    \n    return file_contents\n\nbloomberg_rates = read_csv(bloomberg_rates_file_path, ',')\nnetsuite_rates = read_csv(netsuite_rates_file_path, ',')\nfields = ['Base Currency', 'Source Currency', 'Bloomberg Rate', 'NetSuite Rate']\ninvalid_rates = []\nmessage = ''\n\ntry:\n    invalid_line_count = 0\n    for row in netsuite_rates:\n        if row['Method'] == 'Manual':\n            for bb_row in bloomberg_rates:\n                if row['Base Currency'] == bb_row['Base Currency'] and row['Source Currency'] == bb_row['Currency']:\n                    if row['Exchange Rate'] != bb_row['Exchange Rate']:\n                        invalid_row = {\n                            'Base Currency': row['Base Currency'],\n                            'Source Currency': row['Source Currency'],\n                            'Bloomberg Rate': bb_row['Exchange Rate'],\n                            'NetSuite Rate': row['Exchange Rate']\n                        }\n                        invalid_rates.append(invalid_row)\n                        invalid_line_count += 1\n    result = True\n    fields = str(fields)\n    invalid_rates = str(invalid_rates)\n    message = 'Found %d invalid exchange rates from %d uploaded.' % (invalid_line_count, len(bloomberg_rates))\nexcept Exception as e:\n    result = False\n    invalid_rates = str(invalid_rates)\n    message = e"
  outputs:
    - invalid_rates
    - message
  results:
    - SUCCESS: '${result}'
    - FAILURE

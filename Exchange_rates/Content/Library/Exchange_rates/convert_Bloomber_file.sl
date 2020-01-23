########################################################################################################################
#!!
#! @output effective_date: The effective date when the exchane rates are in use
#!!#
########################################################################################################################
namespace: Exchange_rates
flow:
  name: convert_Bloomber_file
  workflow:
    - read_csv_banks_file:
        do:
          Exchange_rates.operations.read_csv_file:
            - file_path: "C:\\temp\\banks.csv"
        publish:
          - banks_to_process: '${file_contents}'
        navigate:
          - SUCCESS: read_csv_currencies_file
    - read_csv_Bloomberg_file:
        do:
          Exchange_rates.operations.read_csv_file:
            - file_path: "C:\\temp\\3BFx_1500_CST1400.req.OUT"
            - delimiter: '|'
        publish:
          - file_contents
          - message
        navigate:
          - SUCCESS: convert_to_NetSuite_format
    - convert_to_NetSuite_format:
        do:
          Exchange_rates.operations.convert_to_NetSuite_format:
            - input_list: '${file_contents}'
            - banks_to_process: '${banks_to_process}'
            - currencies: '${currencies}'
        publish:
          - output_list
          - message
          - warning_message
          - fields
          - effective_date
        navigate:
          - SUCCESS: write_csv_file
    - write_csv_file:
        do:
          Exchange_rates.operations.write_csv_file:
            - file_path: "C:\\temp\\NetSuite_format.csv"
            - fields: '${fields}'
            - file_input: '${output_list}'
        publish: []
        navigate:
          - SUCCESS: SUCCESS
    - read_csv_currencies_file:
        do:
          Exchange_rates.operations.read_csv_file:
            - file_path: "C:\\temp\\currencies.csv"
        publish:
          - currencies: '${file_contents}'
        navigate:
          - SUCCESS: read_csv_Bloomberg_file
  outputs:
    - effective_date: '${effective_date}'
    - message: '${message}'
  results:
    - SUCCESS
extensions:
  graph:
    steps:
      read_csv_banks_file:
        x: 100
        'y': 150
      read_csv_Bloomberg_file:
        x: 250
        'y': 305
      convert_to_NetSuite_format:
        x: 522
        'y': 305
      write_csv_file:
        x: 784
        'y': 301
        navigate:
          ce69d21f-5c0c-8072-d222-f0c072254aed:
            targetId: b5ed53ad-96f4-b579-970f-90f95075c490
            port: SUCCESS
      read_csv_currencies_file:
        x: 258
        'y': 27
    results:
      SUCCESS:
        b5ed53ad-96f4-b579-970f-90f95075c490:
          x: 974
          'y': 308

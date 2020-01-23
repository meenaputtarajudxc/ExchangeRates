namespace: Exchange_rates
flow:
  name: Validate_exchange_rates
  inputs:
    - mf_username: "${get_sp('mf_username')}"
    - mf_password:
        default: "${get_sp('mf_password')}"
        sensitive: true
    - effective_date: 12/19/2019
    - environment: staging
  workflow:
    - clean_downloads_folder:
        do:
          Exchange_rates.operations.clean_downloads_folder:
            - downloads_folder: "${get_sp('downloads_folder')}"
            - file_starts_with: CurrencyExchangeRates
        publish:
          - message
        navigate:
          - SUCCESS: download_exchange_rates
          - FAILURE: on_failure
    - validate_exchange_rates:
        do:
          Exchange_rates.operations.validate_exchange_rates:
            - bloomberg_rates_file_path: "C:\\temp\\NetSuite_format.csv"
            - netsuite_rates_file_path: "C:\\temp\\uploaded_exchange_rates.csv"
        publish:
          - invalid_rates
          - validation_message: '${message}'
        navigate:
          - SUCCESS: archive_exchange_rates
          - FAILURE: on_failure
    - sanitize_csv_file:
        do:
          Exchange_rates.operations.sanitize_csv_file:
            - file_path: "C:\\temp\\uploaded_exchange_rates.csv"
            - line_regex: '.*,.*,.*,.*,.*,.*,.*'
        publish:
          - message
        navigate:
          - SUCCESS: validate_exchange_rates
          - FAILURE: on_failure
    - copy_file_starts_with:
        do:
          Exchange_rates.operations.copy_file_starts_with:
            - source_folder: "${get_sp('downloads_folder')}"
            - file_name_starts_with: CurrencyExchangeRates
            - destination_file: "C:\\temp\\uploaded_exchange_rates.csv"
        publish:
          - message
        navigate:
          - SUCCESS: sanitize_csv_file
          - FAILURE: on_failure
    - download_exchange_rates:
        do:
          Exchange_rates.subflows.download_exchange_rates:
            - mf_username: '${mf_username}'
            - mf_password:
                value: '${mf_password}'
                sensitive: true
            - environment: '${environment}'
            - effective_date: '${effective_date}'
        publish:
          - error_message
        navigate:
          - FAILURE: on_failure
          - SUCCESS: copy_file_starts_with
    - archive_exchange_rates:
        do:
          Exchange_rates.subflows.archive_exchange_rates: []
        navigate:
          - FAILURE: on_failure
          - SUCCESS: SUCCESS
  outputs:
    - invalid_rates: '${invalid_rates}'
    - validation_message: '${validation_message}'
    - error_message: '${error_message}'
  results:
    - FAILURE
    - SUCCESS
extensions:
  graph:
    steps:
      clean_downloads_folder:
        x: 100
        'y': 150
      download_exchange_rates:
        x: 400
        'y': 150
      copy_file_starts_with:
        x: 700
        'y': 150
      sanitize_csv_file:
        x: 1000
        'y': 150
      validate_exchange_rates:
        x: 1300
        'y': 150
      archive_exchange_rates:
        x: 1600
        'y': 150
        navigate:
          392901b5-7520-fbf8-e462-0d22151a2533:
            targetId: ff2b8410-3a8d-4804-9942-a0c7e61f09ae
            port: SUCCESS
    results:
      SUCCESS:
        ff2b8410-3a8d-4804-9942-a0c7e61f09ae:
          x: 1900
          'y': 150

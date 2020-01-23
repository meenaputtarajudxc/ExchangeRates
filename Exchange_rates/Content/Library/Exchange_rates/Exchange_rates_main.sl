namespace: Exchange_rates
flow:
  name: Exchange_rates_main
  inputs:
    - mf_username: "${get_sp('mf_username')}"
    - mf_password:
        default: "${get_sp('mf_password')}"
        sensitive: true
    - environment: "${get_sp('environment')}"
  workflow:
    - ReqBuilder_download_file_rec:
        do:
          Exchange_rates.ReqBuilder_download_file_rec: []
        publish:
          - error_message
        navigate:
          - SUCCESS: convert_Bloomber_file
          - WARNING: convert_Bloomber_file
          - FAILURE: on_failure
    - convert_Bloomber_file:
        do:
          Exchange_rates.convert_Bloomber_file: []
        publish:
          - effective_date
          - convert_message: '${message}'
        navigate:
          - SUCCESS: NetSuite_upload_exchange_rates_UFT_rec
    - Validate_exchange_rates:
        do:
          Exchange_rates.Validate_exchange_rates:
            - mf_username: '${mf_username}'
            - mf_password:
                value: '${mf_password}'
                sensitive: true
            - effective_date: '${effective_date}'
            - environment: '${environment}'
        publish:
          - invalid_rates
          - validation_message
          - error_message
        navigate:
          - FAILURE: on_failure
          - SUCCESS: send_execution_report
    - send_execution_report:
        do:
          Exchange_rates.subflows.send_email_report:
            - subject: Exchange Rates execution report
            - body: "${str('<h2>Exchange Rates Execution Summary</h2>\\n' +\n'<p>Converting Bloomberg file result: ' + str(convert_message) + '</p>\\n' +\n'<p>Upload to NetSuite message: ' + str(job_message) + '</p>\\n' +\n'<p>Validation message: ' + str(validation_message) + '</p>\\n' +\n'<p>Invalid rates: ' + str(invalid_rates) + '</p>\\n' +\n'<p>&nbsp;</p>\\n' +\n'<p>Have a great day!<br />Micro Focus RPA Robot</p>')}"
        navigate:
          - FAILURE: on_failure
          - SUCCESS: SUCCESS
    - NetSuite_upload_exchange_rates_UFT_rec:
        do:
          Exchange_rates.NetSuite_upload_exchange_rates_UFT_rec:
            - mf_username: '${mf_username}'
            - mf_password:
                value: '${mf_password}'
                sensitive: true
            - environment: '${environment}'
        publish:
          - job_name
          - job_status
          - job_message
          - return_result
          - error_message
        navigate:
          - SUCCESS: Validate_exchange_rates
          - WARNING: Validate_exchange_rates
          - FAILURE: on_failure
    - on_failure:
        - send_email_report:
            do:
              Exchange_rates.subflows.send_email_report:
                - subject: Exchange Rates execution failure
                - body: "${'The Exchange Rates exection failed with the following message: ' + str(error_message)}"
  outputs:
    - job_status: '${job_status}'
    - job_name: '${job_name}'
    - job_message: '${job_message}'
    - error_message: '${error_message}'
  results:
    - FAILURE
    - SUCCESS
extensions:
  graph:
    steps:
      ReqBuilder_download_file_rec:
        x: 100
        'y': 150
      convert_Bloomber_file:
        x: 400
        'y': 150
      NetSuite_upload_exchange_rates_UFT_rec:
        x: 700
        'y': 150
      Validate_exchange_rates:
        x: 1000
        'y': 150
      send_execution_report:
        x: 1300
        'y': 150
        navigate:
          2af71af5-dff5-1be1-9d43-89fb85d96899:
            targetId: ac93ac5e-fa8a-7d06-2e97-3808c43758bb
            port: SUCCESS
    results:
      SUCCESS:
        ac93ac5e-fa8a-7d06-2e97-3808c43758bb:
          x: 1600
          'y': 150

namespace: Exchange_rates
operation:
  name: NetSuite_upload_exchange_rates_UFT_rec
  inputs:
  - mf_username
  - mf_password:
      sensitive: true
  - environment: staging
  outputs:
  - job_name:
      robot: true
      value: ${job_name}
  - job_status:
      robot: true
      value: ${job_status}
  - job_message:
      robot: true
      value: ${job_message}
  - return_result: ${return_result}
  - error_message: ${error_message}
  sequential_action:
    gav: com.microfocus.seq:Exchange_rates.NetSuite_upload_exchange_rates_UFT_rec:1.0.0
    external: true
  results:
  - SUCCESS
  - WARNING
  - FAILURE

namespace: Revaluation
operation:
  name: NetSuite_Revaluation_UFT_rec
  inputs:
  - mf_username
  - mf_password:
      sensitive: true
  - posting_month
  - accounting_book
  - memo
  outputs:
  - total_subsidiaries:
      robot: true
      value: ${total_subsidiaries}
  - failed_subsidiaries:
      robot: true
      value: ${failed_subsidiaries}
  - return_result: ${return_result}
  - error_message: ${error_message}
  sequential_action:
    gav: com.microfocus.seq:Revaluation.NetSuite_Revaluation_UFT_rec:1.0.0
    external: true
  results:
  - SUCCESS
  - WARNING
  - FAILURE

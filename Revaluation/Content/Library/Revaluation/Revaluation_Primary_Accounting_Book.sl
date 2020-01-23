########################################################################################################################
#!!
#! @output total_subsidiaries: Number of total subsidiaries processed
#! @output failed_subsidiaries: A coma separated list of subsidiaries for which the processing failed
#! @output process_time: The time spent on processing the revaluation process, in seconds
#!!#
########################################################################################################################
namespace: Revaluation
flow:
  name: Revaluation_Primary_Accounting_Book
  inputs:
    - mf_username: "${get_sp('mf_username')}"
    - mf_password:
        default: "${get_sp('mf_password')}"
        sensitive: true
    - posting_month: Mar 2018
  workflow:
    - get_start_time:
        do:
          io.cloudslang.base.datetime.get_time:
            - date_format: 'yyyy-MM-dd HH:mm:ss'
        publish:
          - start_time: '${output}'
        navigate:
          - SUCCESS: NetSuite_Revaluation_Primary_Accounting_Book
          - FAILURE: on_failure
    - NetSuite_Revaluation_Primary_Accounting_Book:
        do:
          Revaluation.NetSuite_Revaluation_UFT_rec:
            - mf_username: '${mf_username}'
            - mf_password:
                value: '${mf_password}'
                sensitive: true
            - posting_month: '${posting_month}'
            - accounting_book: Primary Accounting Book
            - memo: "${(posting_month +' Reval Primary Books')[:32]}"
        publish:
          - total_subsidiaries
          - failed_subsidiaries
          - error_message
        navigate:
          - SUCCESS: get_end_time
          - WARNING: get_end_time
          - FAILURE: on_failure
    - get_end_time:
        do:
          io.cloudslang.base.datetime.get_time:
            - date_format: 'yyyy-MM-dd HH:mm:ss'
        publish:
          - end_time: '${output}'
        navigate:
          - SUCCESS: get_time_difference
          - FAILURE: on_failure
    - get_time_difference:
        do:
          Revaluation.operations.get_time_difference:
            - start_datetime: '${start_time}'
            - end_datetime: '${end_time}'
        publish:
          - time_difference
        navigate:
          - SUCCESS: SUCCESS
  outputs:
    - total_subsidiaries: '${total_subsidiaries}'
    - failed_subsidiaries: '${failed_subsidiaries}'
    - process_time: '${time_difference}'
  results:
    - FAILURE
    - SUCCESS
extensions:
  graph:
    steps:
      get_start_time:
        x: 100
        'y': 150
      NetSuite_Revaluation_Primary_Accounting_Book:
        x: 400
        'y': 150
      get_end_time:
        x: 700
        'y': 150
      get_time_difference:
        x: 1000
        'y': 150
        navigate:
          f5eed1e8-dbab-0998-1a6d-86694215ef79:
            targetId: 871fd753-cef8-cb62-eb5b-f9a6731e9320
            port: SUCCESS
    results:
      SUCCESS:
        871fd753-cef8-cb62-eb5b-f9a6731e9320:
          x: 1300
          'y': 150

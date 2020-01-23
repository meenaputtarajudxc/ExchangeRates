########################################################################################################################
#!!
#! @input mf_username: Micro Focus username to access NetSuite
#! @input mf_password: Micro Focus password to access NetSuite
#! @input posting_month: Posting month for the revaluation using the format <3 letter month abbreviation> YYYY (eg. Nov 2019)
#!!#
########################################################################################################################
namespace: Revaluation
flow:
  name: Revaluation_main
  inputs:
    - mf_username: "${get_sp('mf_username')}"
    - mf_password:
        default: "${get_sp('mf_password')}"
        sensitive: true
    - posting_month: Mar 2018
  workflow:
    - Revaluation_Primary_Accounting_Book:
        do:
          Revaluation.Revaluation_Primary_Accounting_Book: []
        navigate:
          - FAILURE: on_failure
          - SUCCESS: Revaluation_Local_Accounting_Standards
    - Revaluation_Local_Accounting_Standards:
        do:
          Revaluation.Revaluation_Local_Accounting_Standards:
            - mf_username: '${mf_username}'
            - mf_password:
                value: '${mf_password}'
                sensitive: true
            - posting_month: '${posting_month}'
        publish:
          - total_subsidiaries
          - failed_subsidiaries
          - process_time
        navigate:
          - FAILURE: on_failure
          - SUCCESS: Revaluation_US_GAAP_Book
    - Revaluation_US_GAAP_Book:
        do:
          Revaluation.Revaluation_US_GAAP_Book: []
        navigate:
          - FAILURE: on_failure
          - SUCCESS: SUCCESS
  results:
    - FAILURE
    - SUCCESS
extensions:
  graph:
    steps:
      Revaluation_Primary_Accounting_Book:
        x: 100
        'y': 150
      Revaluation_Local_Accounting_Standards:
        x: 400
        'y': 150
      Revaluation_US_GAAP_Book:
        x: 700
        'y': 150
        navigate:
          853932b8-87c6-0bfe-7d93-a9a7903883ee:
            targetId: 911d459d-0d0b-5b44-1a55-867fffe60065
            port: SUCCESS
    results:
      SUCCESS:
        911d459d-0d0b-5b44-1a55-867fffe60065:
          x: 1000
          'y': 150

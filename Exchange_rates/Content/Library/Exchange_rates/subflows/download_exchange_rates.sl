namespace: Exchange_rates.subflows
flow:
  name: download_exchange_rates
  inputs:
    - mf_username: "${get_sp('mf_username')}"
    - mf_password:
        default: "${get_sp('mf_password')}"
        sensitive: true
    - environment: staging
    - effective_date: 1/13/2020
  workflow:
    - is_true:
        do:
          io.cloudslang.base.utils.is_true:
            - bool_value: "${str(environment == 'production')}"
        navigate:
          - 'TRUE': select_prod_NS_tenant_rec
          - 'FALSE': select_staging_NS_tenant_rec
    - select_staging_NS_tenant_rec:
        do:
          Exchange_rates.select_staging_NS_tenant_rec:
            - mf_username: '${mf_username}'
            - mf_password:
                value: '${mf_password}'
                sensitive: true
        publish:
          - error_message
        navigate:
          - SUCCESS: NetSuite_download_exchange_rates_rec
          - WARNING: NetSuite_download_exchange_rates_rec
          - FAILURE: on_failure
    - select_prod_NS_tenant_rec:
        do:
          Exchange_rates.select_prod_NS_tenant_rec:
            - mf_username: '${mf_username}'
            - mf_password:
                value: '${mf_password}'
                sensitive: true
        navigate:
          - SUCCESS: NetSuite_download_exchange_rates_rec
          - WARNING: NetSuite_download_exchange_rates_rec
          - FAILURE: on_failure
    - NetSuite_download_exchange_rates_rec:
        do:
          Exchange_rates.NetSuite_download_exchange_rates_rec:
            - mf_username: '${mf_username}'
            - mf_password:
                value: '${mf_password}'
                sensitive: true
            - effective_date: '${effective_date}'
        publish:
          - error_message
        navigate:
          - SUCCESS: SUCCESS
          - WARNING: SUCCESS
          - FAILURE: on_failure
  outputs:
    - error_message: '${error_message}'
  results:
    - FAILURE
    - SUCCESS
extensions:
  graph:
    steps:
      is_true:
        x: 100
        'y': 150
      select_prod_NS_tenant_rec:
        x: 387
        'y': 53
      select_staging_NS_tenant_rec:
        x: 387
        'y': 319
      NetSuite_download_exchange_rates_rec:
        x: 692
        'y': 185
        navigate:
          120c1b27-f0c1-56d0-1df7-2bb26084e9fe:
            targetId: acdd8e05-5663-6afc-39e4-f14305984e9b
            port: SUCCESS
          2adb9239-d019-172a-5639-554adf29902f:
            targetId: acdd8e05-5663-6afc-39e4-f14305984e9b
            port: WARNING
    results:
      SUCCESS:
        acdd8e05-5663-6afc-39e4-f14305984e9b:
          x: 1003
          'y': 188

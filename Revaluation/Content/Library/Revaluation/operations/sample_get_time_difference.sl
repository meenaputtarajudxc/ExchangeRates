namespace: Revaluation.operations
flow:
  name: sample_get_time_difference
  workflow:
    - get_time:
        do:
          io.cloudslang.base.datetime.get_time:
            - date_format: 'yyyy-MM-dd HH:mm:ss'
        publish:
          - start_time: '${output}'
          - exception
        navigate:
          - SUCCESS: sleep
          - FAILURE: on_failure
    - sleep:
        do:
          io.cloudslang.base.utils.sleep:
            - seconds: '5'
        navigate:
          - SUCCESS: get_time_1
          - FAILURE: on_failure
    - get_time_1:
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
  results:
    - FAILURE
    - SUCCESS
extensions:
  graph:
    steps:
      get_time:
        x: 100
        'y': 150
      sleep:
        x: 400
        'y': 150
      get_time_1:
        x: 700
        'y': 150
      get_time_difference:
        x: 1000
        'y': 150
        navigate:
          ba94d884-0fc9-fac9-d9d4-6a4ba6995c33:
            targetId: 31928329-456e-a2c8-c77e-cf972f7de5e0
            port: SUCCESS
    results:
      SUCCESS:
        31928329-456e-a2c8-c77e-cf972f7de5e0:
          x: 1300
          'y': 150

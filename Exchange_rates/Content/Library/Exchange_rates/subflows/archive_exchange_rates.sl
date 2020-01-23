namespace: Exchange_rates.subflows
flow:
  name: archive_exchange_rates
  inputs:
    - archive_prefix: exchange_rates
    - folder_path: "${get_sp('exchange_rates_folder')}"
    - archive_folder: "${get_sp('archive_folder')}"
  workflow:
    - get_time:
        do:
          io.cloudslang.base.datetime.get_time:
            - date_format: 'yyyy-MM-dd-HH:mm:ss'
        publish:
          - archive_date: '${output}'
        navigate:
          - SUCCESS: zip_er_folder
          - FAILURE: on_failure
    - move:
        do:
          io.cloudslang.base.filesystem.move:
            - source: "${folder_path + archive_name + '.zip'}"
            - destination: '${archive_folder}'
        publish:
          - archive_path: "${destination + '\\\\' + archive_name + '.zip'}"
        navigate:
          - SUCCESS: SUCCESS
          - FAILURE: on_failure
    - zip_er_folder:
        do:
          Exchange_rates.operations.zip_er_folder:
            - archive_name: "${'_'.join([archive_prefix, archive_date])}"
            - folder_path: '${folder_path}'
        publish:
          - message
          - archive_name
        navigate:
          - SUCCESS: move
          - FAILURE: on_failure
  results:
    - FAILURE
    - SUCCESS
extensions:
  graph:
    steps:
      get_time:
        x: 100
        'y': 150
      zip_er_folder:
        x: 400
        'y': 150
      move:
        x: 700
        'y': 150
        navigate:
          6059d765-5af9-fb87-c4e1-7bacaaeb9fa7:
            targetId: de5ad12d-1a9e-d618-fadc-30f3fdd053a8
            port: SUCCESS
    results:
      SUCCESS:
        de5ad12d-1a9e-d618-fadc-30f3fdd053a8:
          x: 1000
          'y': 150

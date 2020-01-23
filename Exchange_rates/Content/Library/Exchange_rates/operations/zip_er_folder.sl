namespace: Exchange_rates.operations
operation:
  name: zip_er_folder
  inputs:
    - archive_name
    - folder_path
  python_action:
    script: |-
      import sys, os, shutil
      try:
        shutil.make_archive(archive_name, "zip", folder_path)
        filename = archive_name + '.zip'
        print filename
        print folder_path
        shutil.move(filename, folder_path)
        result = True
      except Exception as e:
        message = e
        result = False
  outputs:
    - message: '${str(message)}'
  results:
    - SUCCESS: '${result}'
    - FAILURE

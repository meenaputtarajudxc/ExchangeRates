namespace: Exchange_rates.operations
operation:
  name: clean_downloads_folder
  inputs:
    - downloads_folder
    - file_starts_with
  python_action:
    script: |-
      import fnmatch
      import os

      deleted_files = []
      message = 'No files need to be deleted'

      try:
          for filename in os.listdir(downloads_folder):
              if fnmatch.fnmatch(filename, file_starts_with + '*.csv'):
                  file_path = os.path.join(downloads_folder, filename)
                  os.remove(file_path)
                  print('Deleted file %s' % file_path)
                  deleted_files.append(file_path)
          res = True
          if len(deleted_files) > 0:
              message = 'The following file(s) were deleted: %s' % str(deleted_files)
      except Exception as e:
          res = False
          message = "There was an eror: %s" % str(e)
  outputs:
    - message
  results:
    - SUCCESS: '${res}'
    - FAILURE

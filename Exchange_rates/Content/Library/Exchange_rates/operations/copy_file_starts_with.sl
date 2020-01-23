namespace: Exchange_rates.operations
operation:
  name: copy_file_starts_with
  inputs:
    - source_folder
    - file_name_starts_with
    - destination_file
  python_action:
    script: |-
      import fnmatch, os, shutil
      from stat import ST_CTIME

      matching_files = []
      message = ''

      try:
          for filename in os.listdir(source_folder):
              if fnmatch.fnmatch(filename, file_name_starts_with + '*'):
                  file_path = os.path.join(source_folder, filename)
                  matching_files.append((os.stat(file_path)[ST_CTIME], file_path))
          if len(matching_files) > 0:
              latest_file = sorted(matching_files, reverse=True)[0][1]
              shutil.copy(latest_file, destination_file)
              message = ("copying %s to %s was successfull" % (latest_file, destination_file))
              result = True
          else:
              result = False
              message = 'No matching files to copy'
      except Exception as e:
          result = False
          message = "There was an eror: %s" % str(e)
  outputs:
    - message
  results:
    - SUCCESS: '${result}'
    - FAILURE

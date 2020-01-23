########################################################################################################################
#!!
#! @input line_regex: The line regex to match
#!
#! @result SUCCESS: CSV file was sanitized successfully
#!!#
########################################################################################################################
namespace: Exchange_rates.operations
operation:
  name: sanitize_csv_file
  inputs:
    - file_path
    - line_regex
  python_action:
    script: "import re\nimport sys\nfile_content = \"\"\nmessage = \"\"\n\ntry:\n  f = open(file_path, 'r')\n  file_content = f.read()\n  f.close()\n  result = re.findall('.*' + line_regex + '.*', file_content)\n  filter_result = '\\n'.join(result)\n  f = open(file_path, 'w')\n  f.write(filter_result)\n  f.close()\n  message = 'file was sanitized successfully'\n  result = True\nexcept IOError as e:\n  message =  \"ERROR: no such file or permission denied: \" + str(e)\n  result = False\nexcept Exception as e:\n  message = e\n  result = False"
  outputs:
    - message
  results:
    - SUCCESS: '${result}'
    - FAILURE

########################################################################################################################
#!!
#! @input start_datetime: The start date and time in the ISO format ('%Y-%m-%d %H:%M:%S')
#! @input end_datetime: The end date and time in the ISO format ('%Y-%m-%d %H:%M:%S')
#!
#! @output time_difference: Total number of seconds between the start and end date and time
#!!#
########################################################################################################################
namespace: Revaluation.operations
operation:
  name: get_time_difference
  inputs:
    - start_datetime
    - end_datetime
  python_action:
    script: "import datetime\nfrom datetime import timedelta\n\ndatetimeFormat = '%Y-%m-%d %H:%M:%S'\ndiff = datetime.datetime.strptime(end_datetime, datetimeFormat)\\\n    - datetime.datetime.strptime(start_datetime, datetimeFormat)\n\ntime_difference = str(diff.total_seconds())"
  outputs:
    - time_difference
  results:
    - SUCCESS

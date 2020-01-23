########################################################################################################################
#!!
#! @system_property downloads_folder: The RPA Robot downloads folder (eg. 'C:\temp\robot_downloads')
#! @system_property mf_username: Micro Focus username to access NetSuite
#! @system_property mf_password: Micro Focus passord to access NetSuite
#! @system_property email_from: Send email report from
#! @system_property email_to: Send email report to
#! @system_property environment: The execution environment. Can be 'staging' or 'production'
#! @system_property exchange_rates_folder: The working folder for all the Exchange Rates files
#!!#
########################################################################################################################
namespace: ''
properties:
  - downloads_folder:
      value: "C:\\temp\\robot_downloads"
      sensitive: false
  - mf_username:
      value: ''
      sensitive: false
  - mf_password:
      value: ''
      sensitive: true
  - email_from:
      value: florin.muresan@microfocusoo.onmicrosoft.com
      sensitive: false
  - email_to:
      value: florin.muresan@microfocus.com
      sensitive: false
  - environment:
      value: staging
      sensitive: false
  - exchange_rates_folder:
      value: "C:\\temp"
      sensitive: false
  - archive_folder: "C:\\exchange_rates_archive"

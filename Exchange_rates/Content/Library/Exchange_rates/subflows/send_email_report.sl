namespace: Exchange_rates.subflows
flow:
  name: send_email_report
  inputs:
    - subject: test office 365 email
    - body: This is the email body ...
    - archive_path: "C:\\temp-2020.01.12.zip"
    - proxy_host:
        default: web-proxy.eu.softwaregrp.net
        required: false
    - proxy_port:
        default: '8080'
        required: false
  workflow:
    - Get_Authorization_Token:
        do_external:
          18ff19e5-8484-4803-857e-4a2293b91eef:
            - loginAuthority: "${get_sp('microsoft.login_authority')}"
            - clientId: "${get_sp('microsoft.client_id')}"
            - clientSecret:
                value: "${get_sp('microsoft.client_secret')}"
                sensitive: true
            - proxyHost: '${proxy_host}'
            - proxyPort: '${proxy_port}'
        publish:
          - authToken
        navigate:
          - success: Create_Message
          - failure: on_failure
    - Create_Message:
        do_external:
          7227bc21-fbe1-4f30-a239-21743f0dd5a2:
            - authToken: '${authToken}'
            - userPrincipalName: "${get_sp('email_from')}"
            - sender: "${get_sp('email_from')}"
            - from: "${get_sp('email_from')}"
            - toRecipients: "${get_sp('email_to')}"
            - subject: '${subject}'
            - body: '${body}'
            - importance: normal
            - proxyHost: '${proxy_host}'
            - proxyPort: '${proxy_port}'
        publish:
          - messageId
        navigate:
          - success: Add_Attachment
          - failure: on_failure
    - Send_Message:
        do_external:
          ff75e889-13ba-47f6-a72b-5e601c71a180:
            - authToken: '${authToken}'
            - userPrincipalName: "${get_sp('email_from')}"
            - messageId: '${messageId}'
            - proxyHost: '${proxy_host}'
            - proxyPort: '${proxy_port}'
        publish:
          - document
          - returnResult
        navigate:
          - success: SUCCESS
          - failure: on_failure
    - Add_Attachment:
        do_external:
          7fd3aee9-2a5f-469f-b176-5f1bb722ab1a:
            - authToken: '${authToken}'
            - userPrincipalName: "${get_sp('email_from')}"
            - messageId: '${messageId}'
            - filePath: '${archive_path}'
            - contentName: execution archive
            - proxyHost: '${proxy_host}'
            - proxyPort: '${proxy_port}'
        publish:
          - returnResult
          - attachmentId
        navigate:
          - success: Send_Message
          - failure: on_failure
  results:
    - FAILURE
    - SUCCESS
extensions:
  graph:
    steps:
      Get_Authorization_Token:
        x: 100
        'y': 150
      Create_Message:
        x: 400
        'y': 150
      Add_Attachment:
        x: 700
        'y': 150
      Send_Message:
        x: 999
        'y': 150
        navigate:
          e064606f-27ae-864c-0686-d80c6a010903:
            targetId: e1817007-4b6a-a7f0-7750-5d167eea625b
            port: success
    results:
      SUCCESS:
        e1817007-4b6a-a7f0-7750-5d167eea625b:
          x: 1300
          'y': 150

namespace: Exchange_rates
operation:
  name: ReqBuilder_download_file_rec
  sequential_action:
    gav: 'com.microfocus.seq:Exchange_rates.ReqBuilder_download_file_rec:1.0.0'
    skills:
      - Java
      - SAP
      - SAP NWBC Desktop
      - SAPUI5
      - SAPWDJ
      - SAPWebExt
      - Terminal Emulators
      - UI Automation
      - Web
    settings:
      sap:
        server: ''
        ignore_existing_sessions: false
        active: false
        auto_log_on: false
        user: ''
        client: ''
        remember_password: false
        close_on_exit: false
        language: ''
        password: ''
      windows:
        active: true
        apps:
          app_1:
            args: ''
            directory: "C:\\blp\\bbdl\\rb7.0.1\\"
            path: "C:\\blp\\bbdl\\rb7.0.1\\Request Builder.exe"
      terminal_settings:
        active: false
      web:
        active: false
        address: ''
        close_on_exit: false
    steps:
      - step:
          id: '11'
          action: Wait
          default_args: '"1"'
          args: '"10"'
      - step:
          id: '1'
          object_path: 'JavaWindow("Data License Request Builder").JavaTab("JTabbedPane")'
          action: Select
          default_args: '"Request Builder: FTP"'
      - step:
          id: '2'
          object_path: 'JavaWindow("Data License Request Builder").JavaEdit("File Filter:")'
          action: Set
          default_args: '"3BFx_1500"'
      - step:
          id: '10'
          action: Wait
          default_args: '"1"'
          args: '"5"'
      - step:
          id: '3'
          object_path: 'JavaWindow("Data License Request Builder").JavaButton("Refresh")'
          action: Click
      - step:
          id: '4'
          object_path: 'JavaWindow("Data License Request Builder").JavaTable("DLJTable")'
          action: SelectRow
          default_args: '"#4"'
      - step:
          id: '5'
          object_path: 'JavaWindow("Data License Request Builder").JavaTable("DLJTable")'
          action: Click
          default_args: '125,68,"RIGHT"'
      - step:
          id: '6'
          object_path: 'JavaWindow("Data License Request Builder").JavaMenu("Download")'
          action: Select
      - step:
          id: '7'
          object_path: 'JavaDialog("Data License FTP Client").JavaButton("Yes")'
          action: Click
      - step:
          id: '8'
          object_path: 'JavaDialog("Data License FTP Client").JavaButton("OK")'
          action: Click
      - step:
          id: '9'
          object_path: 'JavaWindow("Data License Request Builder")'
          action: Close
  outputs:
    - return_result: '${return_result}'
    - error_message: '${error_message}'
  results:
    - SUCCESS
    - WARNING
    - FAILURE
object_repository:
  objects:
    - object:
        smart_identification: ''
        name: Data License Request Builder
        child_objects:
          - object:
              smart_identification: ''
              name: DLJTable
              child_objects: []
              properties:
                - property:
                    value:
                      value: JavaTable
                      regular_expression: false
                    name: to_class
                    hidden: false
                    read_only: false
                    type: STRING
              comments: ''
              custom_replay: ''
              class: JavaTable
              visual_relations: ''
              last_update_time: 'Wednesday, November 6, 2019 5:12:20 PM'
              basic_identification:
                property_ref:
                  - to_class
                ordinal_identifier: ''
          - object:
              smart_identification: ''
              name: JTabbedPane
              child_objects: []
              properties:
                - property:
                    value:
                      value: JavaTab
                      regular_expression: false
                    name: to_class
                    hidden: false
                    read_only: false
                    type: STRING
              comments: ''
              custom_replay: ''
              class: JavaTab
              visual_relations: ''
              last_update_time: 'Wednesday, November 6, 2019 5:12:20 PM'
              basic_identification:
                property_ref:
                  - to_class
                ordinal_identifier: ''
          - object:
              smart_identification: ''
              name: Download
              child_objects: []
              properties:
                - property:
                    value:
                      value: JavaMenu
                      regular_expression: false
                    name: to_class
                    hidden: false
                    read_only: false
                    type: STRING
                - property:
                    value:
                      value: Download
                      regular_expression: false
                    name: label
                    hidden: false
                    read_only: false
                    type: STRING
              comments: ''
              custom_replay: ''
              class: JavaMenu
              visual_relations: ''
              last_update_time: 'Wednesday, November 6, 2019 5:12:20 PM'
              basic_identification:
                property_ref:
                  - to_class
                  - label
                ordinal_identifier: ''
          - object:
              smart_identification: ''
              name: 'File Filter:'
              child_objects: []
              properties:
                - property:
                    value:
                      value: javax.swing.JTextField
                      regular_expression: false
                    name: toolkit class
                    hidden: false
                    read_only: false
                    type: STRING
                - property:
                    value:
                      value: JavaEdit
                      regular_expression: false
                    name: to_class
                    hidden: false
                    read_only: false
                    type: STRING
                - property:
                    value:
                      value: 'File Filter:'
                      regular_expression: false
                    name: attached text
                    hidden: false
                    read_only: false
                    type: STRING
              comments: ''
              custom_replay: ''
              class: JavaEdit
              visual_relations: ''
              last_update_time: 'Wednesday, November 6, 2019 5:12:20 PM'
              basic_identification:
                property_ref:
                  - toolkit class
                  - to_class
                  - attached text
                ordinal_identifier:
                  value: 1
                  type: index
          - object:
              smart_identification: ''
              name: Refresh
              child_objects: []
              properties:
                - property:
                    value:
                      value: javax.swing.JButton
                      regular_expression: false
                    name: toolkit class
                    hidden: false
                    read_only: false
                    type: STRING
                - property:
                    value:
                      value: JavaButton
                      regular_expression: false
                    name: to_class
                    hidden: false
                    read_only: false
                    type: STRING
                - property:
                    value:
                      value: Refresh
                      regular_expression: false
                    name: label
                    hidden: false
                    read_only: false
                    type: STRING
                - property:
                    value:
                      value: Refresh
                      regular_expression: false
                    name: attached text
                    hidden: false
                    read_only: false
                    type: STRING
              comments: ''
              custom_replay: ''
              class: JavaButton
              visual_relations: ''
              last_update_time: 'Wednesday, November 6, 2019 5:12:20 PM'
              basic_identification:
                property_ref:
                  - toolkit class
                  - to_class
                  - label
                  - attached text
                ordinal_identifier:
                  value: 1
                  type: index
        properties:
          - property:
              value:
                value: JavaWindow
                regular_expression: false
              name: to_class
              hidden: false
              read_only: false
              type: STRING
          - property:
              value:
                value: Data License Request Builder 7.0.1 - Bloomberg exchange rates
                regular_expression: false
              name: title
              hidden: false
              read_only: false
              type: STRING
        comments: ''
        custom_replay: ''
        class: JavaWindow
        visual_relations: ''
        last_update_time: 'Wednesday, November 6, 2019 5:12:20 PM'
        basic_identification:
          property_ref:
            - to_class
            - title
          ordinal_identifier: ''
    - object:
        smart_identification: ''
        name: Data License FTP Client
        child_objects:
          - object:
              smart_identification: ''
              name: 'Yes'
              child_objects: []
              properties:
                - property:
                    value:
                      value: JavaButton
                      regular_expression: false
                    name: to_class
                    hidden: false
                    read_only: false
                    type: STRING
                - property:
                    value:
                      value: 'Yes'
                      regular_expression: false
                    name: label
                    hidden: false
                    read_only: false
                    type: STRING
              comments: ''
              custom_replay: ''
              class: JavaButton
              visual_relations: ''
              last_update_time: 'Wednesday, November 6, 2019 5:12:20 PM'
              basic_identification:
                property_ref:
                  - to_class
                  - label
                ordinal_identifier: ''
          - object:
              smart_identification: ''
              name: OK
              child_objects: []
              properties:
                - property:
                    value:
                      value: JavaButton
                      regular_expression: false
                    name: to_class
                    hidden: false
                    read_only: false
                    type: STRING
                - property:
                    value:
                      value: OK
                      regular_expression: false
                    name: label
                    hidden: false
                    read_only: false
                    type: STRING
              comments: ''
              custom_replay: ''
              class: JavaButton
              visual_relations: ''
              last_update_time: 'Wednesday, November 6, 2019 5:12:20 PM'
              basic_identification:
                property_ref:
                  - to_class
                  - label
                ordinal_identifier: ''
        properties:
          - property:
              value:
                value: JavaDialog
                regular_expression: false
              name: to_class
              hidden: false
              read_only: false
              type: STRING
          - property:
              value:
                value: Data License FTP Client
                regular_expression: false
              name: title
              hidden: false
              read_only: false
              type: STRING
        comments: ''
        custom_replay: ''
        class: JavaDialog
        visual_relations: ''
        last_update_time: 'Wednesday, November 6, 2019 5:12:20 PM'
        basic_identification:
          property_ref:
            - to_class
            - title
          ordinal_identifier: ''
  check_points_and_outputs: []
  parameters: []

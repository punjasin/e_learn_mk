*** Settings ***
Library         String
Library         Collections
Library         DatabaseLibrary

Variables       ../../resources/settings/db.yaml

*** Keywords ***
Connect to oracle database
    [Arguments]     ${connect_db}
    DatabaseLibrary.connect to database using custom params     ${db_api_module['oracle']}      ${connect_db}

Connect to postgres database
    [Arguments]     ${db_detail}
    DatabaseLibrary.connect to database     ${db_api_module['postgres']}     ${db_detail['database']}    ${db_detail['user']}    ${db_detail['password']}    ${db_detail['host']}    ${db_detail['port']}

Disconnect from database
    DatabaseLibrary.disconnect from database
    #Sleep to make sure database is completely disconnected before making next transaction
    Sleep       ${db_time['short_timeout']}
*** Settings ***
Library         RequestsLibrary
Library         JSONLibrary
Library         OperatingSystem
Library         Collections
Library         DateTime
Library         String

Resource        ../../keywords/api/basket_api.resource
Resource        ../../keywords/api/cached_api.resource
Resource        ../../keywords/api/deliveryslot_api.resource
Resource        ../../keywords/api/email_api.resource
Resource        ../../keywords/api/email_notification.resource
Resource        ../../keywords/api/favourite_api.resource
Resource        ../../keywords/api/gmail_api.resource
Resource        ../../keywords/api/login_api.resource
Resource        ../../keywords/api/mirakl_api.resource
Resource        ../../keywords/api/otp_api.resource
Resource        ../../keywords/api/product_api.resource
Resource        ../../keywords/api/search_api_feature.resource
Resource        ../../keywords/api/search_typesense_api.resource
Resource        ../../keywords/api/shopify_api.resource
Resource        ../../keywords/api/medusa_api.resource
Resource        ../../keywords/api/rm3_api.resource

Variables       ../../resources/settings/api.yaml
Variables       ../../resources/data/search_api.yaml
Variables       ../../resources/data/product.yaml

*** Keywords ***
Update json variable
    [Arguments]   ${jsonfile}   ${variable_path}       ${value} 
    ${file_data}=   Load Json from file    ${CURDIR}/../../resources/data/json_template/${jsonfile} 
    ${json_obj}=    Update Value To Json    ${file_data}        ${variable_path}        ${value}
    ${new_obj}=     Convert JSON To String  ${json_obj}
    Create File     ${CURDIR}/../../resources/data/json_template/${jsonfile}     ${new_obj}    UTF-8
    Wait Until Keyword Succeeds   3x  200ms     Check value display on json file       ${jsonfile}   ${variable_path}       ${value} 
    [Return]        ${jsonfile}

Call qraphql maknet app
    [Arguments]     ${jsonfile}     ${ROOT_URL}=${ROOT_URL['MANNGO QA']}    ${IDToken}=${empty}
    RequestsLibrary.Create session   Post Session       ${ROOT_URL}
    ${headers}       Create Dictionary      Content-Type=application/json       x-app-version=99.9.9    x-device-platform=ios   authorization=${IDToken}      
    ${file_data}=    OperatingSystem.Get binary file        ${CURDIR}/../../resources/data/json_template/${jsonfile}
    ${response}=     RequestsLibrary.Post on session        Post Session          /graphql        data=${file_data}       headers=${headers}
    [Return]        ${response}

Check value display on json file
    [Arguments]   ${jsonfile}   ${variable_path}       ${value} 
    ${file_data}=   Load Json from file    ${CURDIR}/../../resources/data/json_template/${jsonfile} 
    ${json_value}=	Get Value From Json	   ${file_data}	    ${variable_path}
    Should Contain     ${json_value}       ${value}

Call graphql shopify API
    [Arguments]     ${jsonfile}     ${ROOT_URL}=${ROOT_URL['Shopify']}
    RequestsLibrary.Create session   Post Session       ${ROOT_URL}
    ${headers}       Create Dictionary    X-Shopify-Access-Token=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   Content-Type=application/json
    ${file_data}=    OperatingSystem.Get binary file        ${CURDIR}/../../resources/data/json_template${jsonfile}
    ${response}=     RequestsLibrary.Post on session        Post Session        /api/2021-07/graphql.json        data=${file_data}       headers=${headers}      expected_status=200
    [Return]        ${response}

Get value from json file
    [Arguments]   ${jsonfile}   ${variable_path}
    ${file_data}=   Load Json from file    ${CURDIR}/../../resources/data/json_template/${jsonfile} 
    ${json_value}=  Get Value From Json    ${file_data}        ${variable_path}
    [Return]    ${json_value}

Get value from json string
    [Arguments]   ${input_string}   ${variable_path}
    ${input_json}=    Convert String To json  ${input_string}
    ${json_value}=    Get Value From Json     ${input_json}      ${variable_path}
    [Return]    ${json_value}
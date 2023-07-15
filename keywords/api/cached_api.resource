*** Settings ***
Resource        ../../common/api/api_common.resource

*** Keywords ***
Delete cached by key
    [Arguments]     ${key}
    RequestsLibrary.Create session   Delete Session       ${ROOT_URL.Mango_app_qa}    
    ${response}=     RequestsLibrary.Delete on session        Delete Session          /cache/${key}
    Status Should Be    200     ${response}


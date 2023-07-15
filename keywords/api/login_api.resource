*** Settings ***
Resource        ../../common/api/api_common.resource

*** Keywords ***
Call cognito API
    [Arguments]     ${jsonfile}     ${ROOT_URL}=${ROOT_URL['Cognito']}
    RequestsLibrary.Create session   Post Session       ${ROOT_URL}
    ${headers}       Create Dictionary    x-amz-target=AWSCognitoIdentityProviderService.InitiateAuth   Content-Type=application/x-amz-json-1.1
    ${file_data}=    OperatingSystem.Get binary file        ${CURDIR}/../../resources/data/json_template/${jsonfile}
    ${response}=     RequestsLibrary.Post on session        Post Session        /        data=${file_data}       headers=${headers}      expected_status=200
    [Return]        ${response}

Call qraphql to login user via email
    [Arguments]     ${email}     ${pwd}     ${jsonfile}=auth/queryLogin.json
    ${username}=    Fetch From Left     ${email}    @
    ${username}     Convert To String   ${username}
    ${email}        Convert To String   ${email}
    ${pwd}          Convert To String   ${pwd}
    api_common.Update json Variable   ${jsonfile}     $.AuthParameters.USERNAME       ${username}
    api_common.Update json Variable   ${jsonfile}     $.ClientMetadata.email       ${email} 
    api_common.Update json Variable   ${jsonfile}     $.AuthParameters.PASSWORD    ${pwd}
    ${response}=    login_api.Call cognito API       ${jsonfile}
    ${token}         Set Variable           ${response.json()}
    ${IDtoken_resp}=         Get Value From Json    ${token}            $.AuthenticationResult.IdToken
    ${Accesstoken_resp}=     Get Value From Json    ${token}            $.AuthenticationResult.AccessToken
    ${IDToken}=         Set Variable           ${IDtoken_resp}[0]
    ${Accesstoken}=     Set Variable           ${Accesstoken_resp}[0]
    [Return]        ${IDToken}      ${Accesstoken}
*** Settings ***
Resource        ../../common/api/api_common.resource
Resource        login_api.resource

*** Keywords ***
Get all favorite list for list id
    [Arguments]     ${token}       ${i}=${0}    ${jsonfile}=favourite/queryGetAllMyList.json
    api_common.Update json variable   ${jsonfile}       $.variables.accessToken      ${token}
    ${response}=    api_common.Call qraphql maknet app       ${jsonfile}        IDToken=${token}
    ${resp.body}     Set Variable           ${response.json()}
    ${total_list}=      Get Value From Json    ${resp.body}        $.data.favoriteListsGetAll
    ${listId}=       Set Variable           ${total_list}[0]
    ${total_length}=    Get length      ${listId}
    @{fav_list}=        Create list
    FOR     ${round}    IN RANGE    ${total_length}
        ${list-id}=      Get Value From Json    ${resp.body}        $.data.favoriteListsGetAll[${round}].id
        ${listId}=       Set Variable           ${list-id}[0]
        Append to list  ${fav_list}  ${listId}
    END
    [Return]        @{fav_list}

Delete favorite list by list id
    [Arguments]     ${token}    ${list}     ${jsonfile}=favourite/queryDelListByListId.json
    api_common.Update json variable   ${jsonfile}      $.variables.accessToken       ${token}
    api_common.Update json variable   ${jsonfile}      $.variables.favoriteListId    ${list}
    ${response}=    api_common.Call qraphql maknet app       ${jsonfile}    IDToken=${token}
    ${resp.body}     Set Variable           ${response.json()}
    ${resp.listRemove}=   Get Value From Json      ${resp.body}    $.data.favoriteListRemove
    Should Be Equal     ${resp.listRemove}[0]      ${list}


Call API Delete all favorite list on this user 
    [Arguments]     ${email}    ${pwd}
    @{userToken}=     login_api.Call qraphql to login user via email    ${email}    ${pwd}
    @{listId}=  Get all favorite list for list id    ${userToken}[0]
    FOR     ${round}    IN    @{listId}
        Delete favorite list by list id      ${userToken}[0]      ${round}
    END    
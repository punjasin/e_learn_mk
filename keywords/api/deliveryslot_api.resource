*** Settings ***
Resource        ../../common/api/api_common.resource

*** Keywords ***
Call qraphql to login admin slot
    [Arguments]     ${jsonfile}=slot_delivery/queryLoginAdminSlot.json
    ${response}=    api_common.Call qraphql maknet app       ${jsonfile}
    ${token}         Set Variable           ${response.json()}
    ${token}=        Get Value From Json    ${token}            $.data.adminUserLogin.accessToken
    ${accessToken}=  Set Variable           ${token}[0]
    [Return]        ${accessToken}
    
Get all slot for slot id
    [Arguments]     ${token}       ${i}=${0}    ${jsonfile}=slot_delivery/querySlot.json
    api_common.Update json variable   ${jsonfile}      $.variables.accessToken      ${token}
    ${response}=    api_common.Call qraphql maknet app       ${jsonfile}
    ${slot}          Set Variable           ${response.json()}
    ${slot-id}=      Get Value From Json    ${slot}        $.data.slots[${i}].id
    ${slotid}=       Set Variable           ${slot-id}[0]
    [Return]        ${slotid}

Update slot to be 0
    [Arguments]     ${token}    ${slot}     ${jsonfile}=slot_delivery/queryRemoveSlot.json
    api_common.Update json variable   ${jsonfile}     $.variables.accessToken       ${token}
    api_common.Update json variable   ${jsonfile}     $.variables.id                ${slot}
    ${response}=    api_common.Call qraphql maknet app       ${jsonfile}
    ${resp.body}        Set Variable           ${response.json()}
    ${resp.capacity}=   Get Value From Json      ${resp.body}    $.data.slotUpdateById.capacity  
    Should Be Equal     ${resp.capacity}[0]      ${0}

Update slot to be 5
    [Arguments]     ${token}    ${slot}    ${jsonfile}=slot_delivery/queryAddSlot.json
    api_common.Update json variable   ${jsonfile}      $.variables.accessToken       ${token}
    api_common.Update json variable   ${jsonfile}      $.variables.id                ${slot}
    ${response}=    api_common.Call qraphql maknet app       ${jsonfile}
    ${resp.body}        Set Variable           ${response.json()}
    ${resp.capacity}=   Get Value From Json      ${resp.body}    $.data.slotUpdateById.capacity  
    Should Be Equal     ${resp.capacity}[0]      ${5}

Get all slot and Update slot to be 0
    [Arguments]         ${periodSlots}    
    ${accessToken}=     Call qraphql to login admin slot
    FOR   ${period}    IN RANGE       ${periodSlots}
        ${slotid}=      Get all slot for slot id        ${accessToken}   ${period}   
        Exit For Loop If   '${slotid}'=='[]'
        Update slot to be 0     ${accessToken}       ${slotid}
    END

Get all slot and Update slot to be 5
    [Arguments]         ${periodSlots}    
    ${accessToken}=     Call qraphql to login admin slot
    FOR   ${period}    IN RANGE      ${periodSlots} 
        ${slotid}=      Get all slot for slot id       ${accessToken}   ${period}      
        Exit For Loop If   '${slotid}'=='[]'     
        Update slot to be 5     ${accessToken}       ${slotid}
    END   

Call API Set inactive delivery slot in X day
    [Documentation]     Need to use "1day" , "all" for set up date that need to change, FYI : now we have 7 period for each 1 day 
    [Arguments]         ${days}
    Run keyword if      '${days}'=='1day'     Get all slot and Update slot to be 0        ${13}
    Run keyword if      '${days}'=='all'      Get all slot and Update slot to be 0        ${104}       

Call API Set active delivery slot in X day
    [Documentation]     Need to use "1day" , "all" for set up date that need to change, FYI : now we have 7 period for each 1 day 
    [Arguments]         ${days}
    Run keyword if      '${days}'=='1day'     Get all slot and Update slot to be 5        ${13}
    Run keyword if      '${days}'=='all'      Get all slot and Update slot to be 5        ${104}    

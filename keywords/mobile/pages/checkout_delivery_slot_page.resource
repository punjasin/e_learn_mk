*** Settings ***
Resource        ../../../resources/locators/${platform}/checkout_locator.resource
Resource        ../../../resources/locators/${platform}/common_locator.resource
Resource        ../../../common/mobile/mobile_common.resource

*** Keywords ***
Tap continue to billing address button
    IF   "${platform}" == "${platform_list['android']}"
        DobbyAppCommon.Wait until element is visible except stale       ${checkout_delivery_slot.txt_step_2_of_3}
        FOR     ${i}    IN RANGE    0   3
            ${is_found}=    Run keyword and return status   DobbyAppCommon.Wait until page contain element except stale    ${checkout_delivery_slot.btn_continue_payment}  timeout=5s
            IF  ${is_found}
                DobbyAppCommon.Tap element when ready     ${checkout_delivery_slot.btn_continue_payment}
            END
            Exit for loop if    ${is_found}
            DobbyAppCommon.Swipe down
        END
        DobbyAppCommon.Wait until element is visible except stale       ${checkout_delivery_slot.txt_step_3_of_3}
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        DobbyAppCommon.Wait until element is visible except stale       ${checkout_delivery_slot.txt_step_2_of_3}
        FOR     ${i}    IN RANGE    0   4
            ${is_found}=    Run keyword and return status   DobbyAppCommon.Wait until element is visible except stale    ${checkout_delivery_slot.btn_continue_billing}      timeout=10s
            IF  ${is_found}
                DobbyAppCommon.Tap element when ready         ${checkout_delivery_slot.btn_continue_billing} 
            END
            ${is_next}=     Run keyword and return status   DobbyAppCommon.Wait until element is visible except stale       ${checkout_delivery_slot.txt_step_3_of_3}
            Exit for loop if    ${is_next}
            DobbyAppCommon.Swipe down
        END
        mobile_common.Wait until loading complete  
        DobbyAppCommon.Wait until element is visible except stale       ${checkout_delivery_slot.txt_step_3_of_3}
    END

Continue to billing address should be disabled
    IF   "${platform}" == "${platform_list['android']}"
        mobile_common.Wait until loading complete
        DobbyAppCommon.Wait until element is visible except stale       ${checkout_delivery_slot.txt_step_2_of_3}
        FOR     ${i}    IN RANGE    0   3
            ${is_found}=    Run keyword and return status   DobbyAppCommon.Wait until page contain element except stale    ${checkout_delivery_slot.btn_continue_payment}  timeout=5s
            Exit for loop if    ${is_found}
            DobbyAppCommon.Swipe down
        END
        Element should be disabled          ${checkout_delivery_slot.btn_continue_payment}
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        DobbyAppCommon.Wait until element is visible except stale       ${checkout_delivery_slot.txt_step_2_of_3}
        FOR     ${i}    IN RANGE    0   4
            ${is_found}=    Run keyword and return status   DobbyAppCommon.Wait until element is visible except stale    ${checkout_delivery_slot.btn_continue_billing}       timeout=10s
            Exit for loop if    ${is_found}
            DobbyAppCommon.Swipe down
        END
        Element should be disabled          ${checkout_delivery_slot.btn_continue_billing} 
    END

Delivery slot page should be displayed
    IF   "${platform}" == "${platform_list['android']}"
        mobile_common.Wait until loading complete
        DobbyAppCommon.Wait until element is visible except stale       ${checkout_delivery_slot.txt_step_2_of_3}
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        DobbyAppCommon.Wait until element is visible except stale      ${checkout_delivery_slot.txt_step_2_of_3}
    END

Get date first slot
    IF   "${platform}" == "${platform_list['android']}"
        ${first_slot_date}=    mobile_common.Get element attribute when ready  ${checkout_delivery_slot.first_radiobutton}       text
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        ${first_slot_date}=    mobile_common.Get element attribute when ready  ${checkout_delivery_slot.shipping_date}       value
    END
    [Return]    ${first_slot_date}

Verify current date slot not available
    [Arguments]     ${date_unavailable}
    ${current_first_slot}=     Get date first slot
    Should not be equal     ${date_unavailable}     ${current_first_slot}
    
Verify alert deliveryslot not available display
    IF   "${platform}" == "${platform_list['android']}"
        DobbyAppCommon.Wait until element is visible except stale   ${checkout_delivery_slot.no_slot_graphic}
        DobbyAppCommon.Wait until element is visible except stale   ${checkout_delivery_slot.delivery_round_is_fully_booked}
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        DobbyAppCommon.Wait until element is visible except stale   ${checkout_delivery_slot.delivery_round_is_fully_booked}
    END

# Android

Select deliveryslot
    [Documentation]  deliveryslot = 1 -> skip
    [Arguments]     ${deliveryslot}
    Return From Keyword If  ${deliveryslot}==1   
    DobbyAppCommon.Wait until element is visible except stale       ${checkout_delivery_slot.radiobutton}
    ${count}=  Get Matching Xpath Count   ${checkout_delivery_slot.spinner}
    #delivery slot    
    ${slot_path} =	Set Variable If		
    ...	${count}==0	${checkout_delivery_slot.radiobutton_zerozero}
    ...	${count}>0	${checkout_delivery_slot.spinner_radiobutton_zerozero}

    ${slot1_date} =     DobbyAppCommon.Get text from element when ready    xpath=${slot_path}
    ${day_only}=       Fetch From Left     ${slot1_date}      ${SPACE}   #seperator = space
    ${slotday} =      Evaluate     ${day_only}+${deliveryslot}-1

    ${slotday}     ${month}     End of month date evaluation    ${slotday}

    DobbyAppCommon.Tap element when ready      ${checkout_delivery_slot.radiobutton_slotday}
    Sleep   2s
    #delivery time
    ${radiobutton_slotday_zerozero_locator}    String.Replace string    ${checkout_delivery_slot.radiobutton_slotday_zerozero}    {{slotday}}    ${slotday}
    ${spinner_zerozero_locator}    String.Replace string    ${checkout_delivery_slot.spinner_zerozero}    {{slotday}}    ${slotday}
    ${time_path} =	Set Variable If		
    ...	${count}==0	${radiobutton_slotday_zerozero_locator}	
    ...	${count}>0	${spinner_zerozero_locator}
    DobbyAppCommon.Wait until element is visible except stale       xpath=${time_path}

Verify alert non support area display
    DobbyAppCommon.Wait until page contain element except stale    ${checkout_delivery_slot.service_area}

Verify alert non support area not display
    Page Should Not Contain Text    ${checkout_delivery_slot.service_area}

Get delivery date
    ${deivery_date}    DobbyAppCommon.Get text from element when ready    ${checkout_delivery_slot.select_delivery_slot}
    [Return]    ${deivery_date}

Click change delivery address
    DobbyAppCommon.Tap element when ready     ${checkout_delivery_slot.use_new_address}

# iOS

Verify deliveryslot display
    DobbyAppCommon.Wait until element is visible except stale   ${checkout_delivery_slot.starts_with_day} 
    DobbyAppCommon.Wait until element is visible except stale   ${checkout_delivery_slot.zerozero}

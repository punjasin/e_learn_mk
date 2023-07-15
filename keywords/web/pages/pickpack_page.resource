*** Settings ***
Resource            ../../../resources/locators/web/pickpack_locator.resource
Resource            ../../api/shopify_api.resource
Resource            ../../../common/web/web_common.resource

*** Keywords ***
Input email
    DobbyWebCommon.Input text to element when ready     ${pickpack.input_email}     ${pickpack['email']}

Input password
    DobbyWebCommon.Input text to element when ready     ${pickpack.input_password}  ${pickpack['password']}

Click login
    DobbyWebCommon.Click element when ready  ${pickpack.btn_submit}

Click home button
    DobbyWebCommon.Click element when ready  ${pickpack.btn_home}

###########################
#####       Home      #####
###########################

Search by order number
    [Arguments]     ${order_number}
    DobbyWebCommon.Wait until element is visible except stale   ${pickpack.lbl_order_number}
    DobbyWebCommon.Input text to element when ready     ${pickpack.input_order_number}              ${pickpack['prefix_pickpack_makro']}${order_number}

Click search button
    DobbyWebCommon.Click element when ready     ${pickpack.btn_search}

Click pick order
    [Arguments]     ${order_number}
    DobbyWebCommon.Wait until element is visible except stale   ${pickpack.lbl_order_list}
    ${order_number_str}=        Convert to string     ${order_number}
    ${pick_order_locator}=        String.Replace string      ${pickpack.btn_pick_order}     {{order_number}}          ${pickpack['prefix_pickpack_makro']}${order_number_str}
    DobbyWebCommon.Click element when ready     ${pick_order_locator}

Click pick all
    DobbyWebCommon.Click element when ready     ${pickpack.btn_pick_all}

Click next button
    ${check_status}=         Run keyword and return status         DobbyWebCommon.Wait until element is visible except stale       ${pickpack.lbl_warning}        timeout=${short_timeout}
    IF   "${check_status}" == "True"       
        DobbyWebCommon.Click element when ready       ${pickpack.btn_ok_on_warning}
    END
    DobbyWebCommon.Click element when ready     ${pickpack.btn_next}

Verify order status
    [Arguments]         ${status}
    ${shipping_status_locator}=        String.Replace string      ${pickpack.txt_shipping_status}     {{status}}          ${status}
    DobbyWebCommon.Wait until element is visible except stale   ${shipping_status_locator}     timeout=${long_timeout}

Confirmation pick all
    [Documentation]     Need to sleep or it will failed
    Sleep   4s
    ${check_popup}      Run keyword and return status       DobbyWebCommon.Wait until element is visible except stale          ${pickpack.lbl_popup_confirm_pick_all}       timeout=${short_timeout}
    IF     "${check_popup}" == "True"
        DobbyWebCommon.Click element when ready       ${pickpack.btn_popup_confirm_pick_all}
    END

Confirmation pack all item
    [Documentation]     Need to sleep or it will failed
    Sleep   4s
    ${check_popup}      Run keyword and return status       DobbyWebCommon.Wait until element is visible except stale        ${pickpack.lbl_popup_confirm_pack_all}       timeout=${short_timeout}
    IF     "${check_popup}" == "True"
        DobbyWebCommon.Click element when ready       ${pickpack.btn_popup_confirm_pack_all}
    END

Assign zone
    [Arguments]     ${zone}
    DobbyWebCommon.Wait until element is visible except stale     ${pickpack.lbl_assign_zone}       timeout=${short_timeout}
    DobbyWebCommon.Click element when ready                       ${pickpack.input_assign_zone}
    DobbyWebCommon.Input text to element when ready               ${pickpack.input_zone}                   ${zone}
    DobbyWebCommon.Click element when ready                       ${pickpack.btn_assign_zone}

    ${assigned_zone_locator}=        String.Replace string      ${pickpack.txt_assigned_zone}     {{zone}}          ${zone}

    DobbyWebCommon.Wait until element is visible except stale       ${assigned_zone_locator}       timeout=${short_timeout}
    DobbyWebCommon.Click element when ready                       ${pickpack.btn_finished_pick}

Pick order continue
    DobbyWebCommon.Click element when ready                      ${pickpack.btn_pack_order}

Click pack all into current package
    DobbyWebCommon.Click element when ready                       ${pickpack.btn_pack_all_into_package}

Finish pack button
    [Documentation]     Need to sleep or it will failed
    Sleep   4s
    DobbyWebCommon.Click element when ready                       ${pickpack.btn_finished_pack}

Click ship order
    DobbyWebCommon.Click element when ready                       ${pickpack.btn_ship_order}

Select ship packages
    DobbyWebCommon.Wait until element is visible except stale       ${pickpack.lbl_ship_package}        timeout=${short_timeout}
    SeleniumLibrary.Select From List By Value           ${pickpack.select_carrier}       ${pickpack['ship_package_value']}
    DobbyWebCommon.Click element when ready                       ${pickpack.btn_ship}

Click mark as delivered
    DobbyWebCommon.Click element when ready                       ${pickpack.btn_mark_as_delivered} 

Click confirm mark as delivered
    DobbyWebCommon.Wait until element is visible except stale       ${pickpack.lbl_popup_mark_as_delivered}      timeout=${long_timeout}
    DobbyWebCommon.Click element when ready                       ${pickpack.btn_confirm_popup_mark_as_delivered}

Get pick pack order number
    [Arguments]     ${email}
    ${order_number}  shopify_api.Call shopify API and get lastest order     ${email}
    ${pickpack_order_number}        Set variable        82000${order_number}
    [Return]        ${pickpack_order_number}
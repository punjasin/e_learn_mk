*** Settings ***
Resource        ../../../resources/locators/${platform}/checkout_locator.resource
Resource        ../../../resources/locators/${platform}/common_locator.resource
Resource        ../../../common/mobile/mobile_common.resource

*** Keywords ***
Select existing shipping address and continue to shipping date
    [Documentation]     address slot 1 = first address
    [Arguments]    ${addressslot}
    IF   "${platform}" == "${platform_list['android']}"
        ${slot}=    Evaluate    ${addressslot}-1
        ${radiobutton_slot_locator}    String.Replace string    ${checkout_shipping_address.radiobutton_slot}    {{slot}}    ${slot}
        DobbyAppCommon.Tap element when ready   ${radiobutton_slot_locator}
        Click to update location pin if exist
        DobbyAppCommon.Tap element when ready     ${checkout_shipping_address.btn_continue_shipping_date}
        DobbyAppCommon.Wait until element is visible except stale       ${checkout_shipping_address.step2of3}    #wait until next page loaded
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        Select address from list           ${addressslot}
        checkout_shipping_address_page.Tap continue to shipping date button
        # Tap on shipping address dropdown list         #not ready
        DobbyAppCommon.Tap element when ready     ${checkout_shipping_address.address_saved}
    END

Select address from dropdown list
    [Arguments]     ${address_name}
    IF   "${platform}" == "${platform_list['android']}"
        ${address_name_locator}    String.Replace string    ${checkout_shipping_address.checkedtextview_address_name}    {{address_name}}    ${address_name}
        DobbyAppCommon.Tap element when ready     ${address_name_locator}    
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        IF  '${platformVersion}' == '15.0'
            ${address_name_locator}    String.Replace string    ${checkout_shipping_address.address_name}    {{address_name}}    ${address_name} 
            DobbyAppCommon.Tap element when ready      ${address_name_locator}
        ELSE IF     '${platformVersion}' == '14.5'
            mobile_common.Input value to pickerwheel when ready    ${address_name}
        ELSE
            Should be true  ${FALSE}    msg='Cannot resolve ios version,please recheck'
        END
    END

Select using new shipping address
    IF   "${platform}" == "${platform_list['android']}"
        DobbyAppCommon.Tap element when ready     ${checkout_shipping_address.btn_add_address_button}
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        DobbyAppCommon.Tap element when ready    ${checkout_shipping_address.add_new_address}
        mobile_common.Wait until loading complete
    END

Should be able to enter only ${expected_no_chars} characters of ${input_text} into ${field_name} filed
    IF   "${platform}" == "${platform_list['android']}"
        ${field_resource_id}=   checkout_shipping_address_page.Get locator from field name     ${field_name}
        ${expected_string}=     Get substring   ${input_text}  start=0     end=${expected_no_chars}

        IF  '${field_resource_id}' != '${NONE}'
            ${edittext_field_resource_id_locator}    String.Replace string    ${checkout_shipping_address.edittext_field_resource_id}    {{field_resource_id}}    ${field_resource_id}
            ${actual_msg}=  DobbyAppCommon.Get text from element when ready   ${edittext_field_resource_id_locator}
        ELSE
            log     ${field_name} doesn't match with any fields, please recheck field name
        END
        Should be equal     ${actual_msg}   ${expected_string}
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        ${field_resource_id}=   checkout_common.Get locator from field name     ${field_name}
        IF  '${field_resource_id}' != '${NONE}'
            IF  '${field_name}' == 'province' or '${field_name}' == 'district' or '${field_name}' == 'address'
                ${field_resource_id_typeother_locator}    String.Replace string    ${checkout_shipping_address.field_resource_id_typeother}    {{field_resource_id}}    ${field_resource_id}
                DobbyAppCommon.Get text from element when ready    ${field_resource_id_typeother_locator}
            ELSE
                ${field_resource_id_locator}    String.Replace string    ${checkout_shipping_address.field_resource_id}    {{field_resource_id}}    ${field_resource_id}
                DobbyAppCommon.Get text from element when ready    ${field_resource_id_locator}
            END
        ELSE
            Should be true  '${field_resource_id}' != '${NONE}'     msg="${field_name} doesn't match with any fields, please, recheck"
        END
    END

Tap continue to shipping date button
    IF   "${platform}" == "${platform_list['android']}"
        FOR     ${i}    IN RANGE    0   3
            Click accept pindrop popup if exist
            Click to update location pin if exist
            ${is_found}=    Run keyword and return status   DobbyAppCommon.Wait until page contain element except stale    ${checkout_shipping_address.btn_continue_shipping_date}  timeout=10s
            IF  ${is_found}
                DobbyAppCommon.Tap element when ready     ${checkout_shipping_address.btn_continue_shipping_date}
            END
            ${next_page}=  Run keyword and return status  DobbyAppCommon.Wait until page contain element except stale  ${checkout_shipping_address.step2of3}  timeout=10s
            Exit for loop if    ${next_page}
            DobbyAppCommon.Swipe down
        END
        DobbyAppCommon.Wait until element is visible except stale       ${checkout_shipping_address.step2of3}
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        FOR     ${i}    IN RANGE    0   4
            Click accept pindrop popup if exist
            Click to update location pin if exist
            ${is_found}=    Run keyword and return status   DobbyAppCommon.Wait until page contain element except stale    ${checkout_shipping_address.btn_continue_shipping_date}  timeout=10s
            IF  ${is_found}
                DobbyAppCommon.Tap element when ready   ${checkout_shipping_address.btn_continue_shipping_date}
            END
            ${is_next}=     Run keyword and return status   DobbyAppCommon.Wait until element is visible except stale       ${checkout_shipping_address.txt_step2of3}
            Exit for loop if    ${is_next}
            DobbyAppCommon.Swipe down
        END
        Should be true  ${is_next}  msg='Failed to click on continue to shipping date button after 3 retry' 
        mobile_common.Wait until loading complete
    END

Click to update location pin if exist
    ${update_pin_popup_found}=    Run keyword and return status   Verify popup ask to update location
    IF  ${update_pin_popup_found}
        Click to update location pin
        Verify popup update location pin display
        Click confirm update location pin
        Click confirm update location with address
    END

Click accept pindrop popup if exist
    IF   "${platform}" == "${platform_list['android']}"
        ${is_found}=    Run keyword and return status   DobbyAppCommon.Wait until element is visible except stale  ${checkout_shipping_address.btn_accept_pindrop}  timeout=20s
        IF  ${is_found}
            DobbyAppCommon.Tap element when ready     ${checkout_shipping_address.btn_accept_pindrop}
        END
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        ${is_found}=    Run keyword and return status   Verify pindrop popup display
        IF  ${is_found}
            DobbyAppCommon.Tap element when ready   ${checkout_shipping_address.btn_accept_pindrop}
        END
    END

Verify popup ask to update location
    DobbyAppCommon.Wait until element is visible except stale  ${checkout_shipping_address.txt_select_pin_title}      ${short_timeout}

Click to update location pin
    DobbyAppCommon.Tap element when ready     ${checkout_shipping_address.btn_edit_pin}

Verify popup update location pin display
    DobbyAppCommon.Wait until page contain element except stale   ${checkout_shipping_address.dialog_update_pin}

Click confirm update location pin
    IF   "${platform}" == "${platform_list['android']}"
        DobbyAppCommon.Tap element when ready     ${checkout_shipping_address.btn_confirm_update_pin}
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        DobbyAppCommon.Tap element when ready       ${checkout_shipping_address.confirm_location}
        AppiumLibrary.Wait until page does not contain element     ${checkout_shipping_address.confirm_location}
    END

Click confirm update location with address
    IF   "${platform}" == "${platform_list['android']}"
        DobbyAppCommon.Tap element when ready     ${checkout_shipping_address.btn_confirm_update_address}
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        DobbyAppCommon.Tap element when ready       ${checkout_shipping_address.save_and_continue}
    END

# Android

Input delivery instructions
    [Arguments]     ${instructions}
    DobbyAppCommon.Wait until element is visible except stale       ${checkout_shipping_address.existing_shipping_address}
    DobbyAppCommon.Input text to element when ready     ${checkout_shipping_address.edittext}      ${instructions}

Click add new shipping address button   
    [Documentation]  DELETE 'Select using new shipping address' after deploying PinDrop
    DobbyAppCommon.Wait until element is visible except stale       ${checkout_shipping_address.btn_add_address_button}
    DobbyAppCommon.Tap element when ready     ${checkout_shipping_address.btn_add_address_button}
    DobbyAppCommon.Wait until element is visible except stale       ${checkout_shipping_address.address_details}

Input shipping address company name
    [Arguments]     ${shipping_company}
    DobbyAppCommon.Input text to element when ready      ${checkout_shipping_address.checkout_shipping_address_company}     ${shipping_company}

Input shipping address first name
    [Arguments]     ${shipping_firstname}
    DobbyAppCommon.Input text to element when ready      ${checkout_shipping_address.checkout_shipping_address_first_name}      ${shipping_firstname}

Input shipping address last name
    [Arguments]     ${shipping_lastname}
    DobbyAppCommon.Input text to element when ready      ${checkout_shipping_address.checkout_shipping_address_last_name}       ${shipping_lastname}

Input shipping address phone number
    [Arguments]     ${shipping_phone}
    DobbyAppCommon.Input text to element when ready  ${checkout_shipping_address.checkout_shipping_address_phone}      ${shipping_phone}

Input shipping address address line 1
    [Arguments]     ${shipping_addr1}
    DobbyAppCommon.Input text to element when ready      ${checkout_shipping_address.checkout_shipping_address_address1}      ${shipping_addr1}

Input shipping address address line 2
    [Arguments]     ${shipping_addr2}
    DobbyAppCommon.Input text to element when ready      ${checkout_shipping_address.checkout_shipping_address_address2}       ${shipping_addr2}

Input shipping address zip code
    [Arguments]     ${shipping_zipcode}
    DobbyAppCommon.Input text to element when ready    ${checkout_shipping_address.checkout_shipping_address_zip}       ${shipping_zipcode}
    
Select shipping address province
    [Arguments]     ${shipping_province}
    DobbyAppCommon.Tap element when ready     ${checkout_shipping_address.select_province}         

Select shipping address district
    DobbyAppCommon.Tap element when ready        ${checkout_shipping_address.select_city}      
    
Select radio option
    [Arguments]     ${text}
    ${txt_checkedtextview_locator}    String.Replace string    ${checkout_shipping_address.txt_checkedtextview}    {{text}}    ${text}
    DobbyAppCommon.Wait until element is visible except stale   ${txt_checkedtextview_locator}
    DobbyAppCommon.Tap element when ready        ${txt_checkedtextview_locator}

Input new shipping address delivery instructions
    [Arguments]     ${shipping_new_instruction}
    DobbyAppCommon.Input text to element when ready  ${checkout_shipping_address.edittext_checkout_delivery_instructions}       ${shipping_new_instruction}

Saved address list should be displayed
    DobbyAppCommon.Wait until element is visible except stale   ${checkout_shipping_address.listview_android_custom}

Shipping address page should be displayed
    DobbyAppCommon.Wait until element is visible except stale       ${checkout_shipping_address.step1of3}

Get locator from field name
    [Arguments]     ${field_name}
    ${field_name_re}=       Replace string  ${field_name}   ${SPACE}    ${EMPTY}
    ${field_name_lower}=    Convert to lower case   ${field_name_re}

    IF  '${field_name_lower}' == 'companyname'
        ${field_resource_id}=   Set variable    checkout_shipping_address_company
    ELSE IF     '${field_name_lower}' == 'firstname'
        ${field_resource_id}=   Set variable    checkout_shipping_address_first_name
    ELSE IF     '${field_name_lower}' == 'lastname'
        ${field_resource_id}=   Set variable    checkout_shipping_address_last_name
    ELSE IF     '${field_name_lower}' == 'phonenumber'
        ${field_resource_id}=   Set variable    checkout_shipping_address_phone
    ELSE IF     '${field_name_lower}' == 'address'
        ${field_resource_id}=   Set variable    checkout_shipping_address_address1
    ELSE IF     '${field_name_lower}' == 'address2'
        ${field_resource_id}=   Set variable    checkout_shipping_address_address2
    ELSE IF     '${field_name_lower}' == 'postalcode'
        ${field_resource_id}=   Set variable    checkout_shipping_address_zip
    ELSE IF     '${field_name_lower}' == 'province'
        ${field_resource_id}=   Set variable    checkout_shipping_address_province
    ELSE IF     '${field_name_lower}' == 'district'
        ${field_resource_id}=   Set variable    checkout_shipping_address_city
    ELSE IF     '${field_name_lower}' == 'deliveryinstruction'
        ${field_resource_id}=   Set variable    checkout_delivery_instructions
    ELSE
        ${field_resource_id}=   Set variable    ${NONE}
    END

    Should be true  '${field_resource_id}' != '${NONE}'
    ...     msg="field name [${field_name}] doesn't match with any field. please, recheck. "

    [Return]    ${field_resource_id}

Tap on ${field_name} field
    ${field_resource_id}=   checkout_shipping_address_page.Get locator from field name     ${field_name}
    ${edittext_field_resource_id_locator}    String.Replace string    ${checkout_shipping_address.edittext_field_resource_id}    {{field_resource_id}}    ${field_resource_id}
    IF   '${field_resource_id}' == 'checkout_shipping_address_phone' or '${field_resource_id}' == 'checkout_shipping_address_zip'
        DobbyAppCommon.Tap element when ready   ${edittext_field_resource_id_locator}
        Press keycode       61
        FOR     ${i}    IN RANGE    1   15
            ${is_shown}=    Is Keyboard Shown
            Exit for loop if    '${is_shown}' == 'False'
            AppiumLibrary.Hide keyboard
        END
    ELSE IF  '${field_resource_id}' != '${NONE}'
        DobbyAppCommon.Tap element when ready   ${edittext_field_resource_id_locator}
        DobbyAppCommon.Hide keyboard until success
    ELSE
        Should be true  '${field_resource_id}' != '${NONE}'     msg="${field_name} doesn't match with any fields, please, recheck"
    END

No warning message on ${field_name} field
    [Documentation]  if there is an error message, the next element will be the error message element.
    ...     so to make sure there is no error msg, we have to do the negative.
    ...     the next element should not be error message, hence it should be the next field (position()=1)
    ...     next to company name is first name
    ...     next to address2 is postal code
    ...     next to delivery instruction is next button

    ${field_name_re}=       Replace string  ${field_name}   ${SPACE}    ${EMPTY}
    ${field_name_lower}=    Convert to lower case   ${field_name_re}

    IF  '${field_name_lower}' == 'companyname'
        DobbyAppCommon.Wait until element is visible except stale       ${checkout_shipping_address.checkout_checkout_shipping_first_name}
    ELSE IF     '${field_name_lower}' == 'address2'
        DobbyAppCommon.Wait until element is visible except stale       ${checkout_shipping_address.checkout_checkout_shipping_address_zip}
    ELSE IF     '${field_name_lower}' == 'deliveryinstruction'
        AppiumLibrary.Page should not contain element     ${checkout_shipping_address.deliveryinstruction}
    ELSE IF     '${field_name_lower}' == 'phonenumber'
        AppiumLibrary.Page should not contain element     ${checkout_shipping_address.phone_validation_message}
    END

Enter ${text} into ${field_name} field
    ${field_resource_id}=   checkout_shipping_address_page.Get locator from field name     ${field_name}
    IF  '${field_resource_id}' != '${NONE}'
        ${edittext_field_resource_id_locator}    String.Replace string    ${checkout_shipping_address.edittext_field_resource_id}    {{field_resource_id}}    ${field_resource_id}
        DobbyAppCommon.Input text to element when ready     ${edittext_field_resource_id_locator}  ${text}
    ELSE
        Should be true  '${field_resource_id}' != '${NONE}'     msg="${field_name} doesn't match with any fields, please, recheck"
    END

# Select ${option} as ${field_name} from dropdown list         #not ready to implement due to makroclick migration
#     ${field_resource_id}=   checkout_shipping_address_page.Get locator from field name     ${field_name}
#     IF  '${field_resource_id}' != '${NONE}'
#         ${view_field_resource_id_locator}    String.Replace string    ${checkout_shipping_address.view_field_resource_id}    {{field_resource_id}}    ${field_resource_id}
#         ${checkedtextview_option_locator}    String.Replace string    ${checkout_shipping_address.checkedtextview_option}    {{option}}    ${option} 
#         DobbyAppCommon.Tap element when ready     ${view_field_resource_id_locator}
#         DobbyAppCommon.Tap element when ready     ${checkedtextview_option_locator}
#     ELSE
#         Should be true  '${field_resource_id}' != '${NONE}'     msg="${field_name} doesn't match with any fields, please, recheck"
#     END

Input letter by letter ${text} into ${field_name} field
    ${field_resource_id}=   checkout_shipping_address_page.Get locator from field name     ${field_name}
    IF  '${field_resource_id}' != '${NONE}'
        ${edittext_field_resource_id_locator}    String.Replace string    ${checkout_shipping_address.edittext_field_resource_id}    {{field_resource_id}}    ${field_resource_id}
        AppiumUtils.Input Letter By Letter      ${edittext_field_resource_id_locator}    ${text}
    ELSE
        Should be true  '${field_resource_id}' != '${NONE}'     msg="${field_name} doesn't match with any fields, please, recheck"
    END

Toast message should display update address successful
    mobile_common.Toast message should display and close   ${checkout_shipping_address.txt_address_has_been_updated}

Click button to exit check out process
    mobile_common.Click x button to close webview

Click save and continue at new address form
    DobbyAppCommon.Tap element when ready       ${checkout_shipping_address.btn_enabled_continue}

Verify save and continue button at new address disabled
    DobbyAppCommon.Wait until element is visible except stale       ${checkout_shipping_address.btn_disabled_continue}

Verify the autopopulated address field ${field_name} value is same as ${expected_string}
    ${field_resource_id}=   checkout_shipping_address_page.Get locator from field name     ${field_name}
    ${view_field_resource_id_locator}    String.Replace string    ${checkout_shipping_address.view_field_resource_id}    {{field_resource_id}}    ${field_resource_id}
    ${element}=     Set Variable    ${view_field_resource_id_locator}
    DobbyAppCommon.Wait until element is visible except stale   ${element}
    IF  '${field_resource_id}' != '${NONE}'
        ${actual_msg}=  DobbyAppCommon.Get text from element when ready   ${view_field_resource_id_locator}
    ELSE
        log     ${field_name} doesn't match with any fields, please recheck field name
    END
    Should be equal     ${actual_msg}   ${expected_string}

Clicking on edit button of existing shipping addresss
    [Arguments]    ${addressslot}   
    ${slot}=    Evaluate    ${addressslot}-1
    ${btn_slot_locator}    String.Replace string    ${checkout_shipping_address.btn_slot}    {{slot}}    ${slot}
    DobbyAppCommon.Tap element when ready  ${btn_slot_locator}

Verify pindrop popup msg should display pin your loaction text 
    ${pin_your_location}    DobbyAppCommon.Get text from element when ready       ${checkout_shipping_address.pin_your_location_on_map}
    Should be equal     ${pin_your_location}     ${pindropText['pinyourlocation']}  

Verify pindrop popup should display popupmsg text  
     ${popup_msg}    DobbyAppCommon.Get text from element when ready       ${checkout_shipping_address.pin_drop_onboarding_dialog}
    Should be equal     ${popup_msg}    ${pindropText['popupmsg']}   

Verify pindrop popup should display popup handle button text  
     ${popup_msg}    DobbyAppCommon.Get text from element when ready       ${checkout_shipping_address.btn_noted}
    Should be equal     ${popup_msg}   ${pindropText['popuphandlebutton']}  
         
Verify default shipping address
    [Arguments]    ${text}
    ${radiobutton_address_0_locator}    String.Replace string    ${checkout_shipping_address.radiobutton_address_0}    {{text}}    ${text}
    DobbyAppCommon.Wait until element is visible except stale       ${radiobutton_address_0_locator}

Click on fix pin
    DobbyAppCommon.Tap element when ready     ${checkout_shipping_address.dialog_edit_pin}

Verify map get expand
    AppiumLibrary.Wait until page does not contain element    ${checkout_shipping_address.checkout_delivery_instructions}

Get delivery address
    [Arguments]    ${delivery_slot}
    ${delivery_slot_locator}    String.Replace string    ${checkout_shipping_address.delivery_slot}    {{delivery_slot}}    ${delivery_slot}
    ${text}    DobbyAppCommon.Get text from element when ready    ${delivery_slot_locator}
    @{s_text}    Split String    ${text}
    [Return]    ${s_text}[0]

Click edit address by address name
    [Arguments]     ${address}
    ${btn_address_locator}    String.Replace string    ${checkout_shipping_address.btn_address}    {{address}}    ${address}
    DobbyAppCommon.Tap element when ready       ${btn_address_locator}

Verify zipcode is selected by default at step 1  
    [Arguments]     ${zipcode}
    ${zipcode_locator}    String.Replace string    ${checkout_shipping_address.zipcode}    {{zipcode}}    ${zipcode}
    DobbyAppCommon.Wait until element is visible except stale   ${zipcode_locator}

Click edit address button when zipcode is selected
    DobbyAppCommon.Tap element when ready     ${checkout_shipping_address.btn_edit_address_button}

Verify save and continue button enabled
    DobbyAppCommon.Wait until element is visible except stale   ${checkout_shipping_address.btn_continue}
    Element Should Be Enabled       ${checkout_shipping_address.btn_continue}

Click on back button at checkout step 
    DobbyAppCommon.Tap element when ready     ${checkout_shipping_address.webview_keyboard_avoiding_area}

Click proceed to the delivery page button 
    DobbyAppCommon.Tap element when ready     ${checkout_shipping_address.btn_continue_shipping_date}

Click on go back button
    DobbyAppCommon.Tap element when ready     ${checkout_shipping_address.btn_back}

Click on continue and basket review button    
    DobbyAppCommon.Tap element when ready     ${checkout_shipping_address.warning_change_location}

Select shipping address
    [Documentation]     address slot 1 = first address
    [Arguments]    ${addressslot}
    ${slot}=    Evaluate    ${addressslot}-1
    ${radiobutton_slot_locator}    String.Replace string    ${checkout_shipping_address.RadioButton_slot}    {{slot}}    ${slot}
    DobbyAppCommon.Tap element when ready   ${radiobutton_slot_locator}

# iOS

Select ${province} as province from dropdown list
    checkout_common.Tap on province field
    IF  '${platformVersion}' == '15.0'
        ${province_locator}    String.Replace string    ${checkout_shipping_address.province}    {{province}}    ${province}
        DobbyAppCommon.Tap element when ready    ${province_locator}
    ELSE IF     '${platformVersion}' == '14.5'
        mobile_common.Input value to pickerwheel when ready    ${province}
    ELSE
        Should be true  ${FALSE}    msg='Cannot resolve ios version,please recheck'
    END

Select ${district} as district from dropdown list
    checkout_common.Tap on district field
    IF  '${platformVersion}' == '15.0'
        ${district_locator}    String.Replace string    ${checkout_shipping_address.district}    {{district}}    ${district}
        DobbyAppCommon.Tap element when ready    ${district_locator}
    ELSE IF     '${platformVersion}' == '14.5'
        mobile_common.Input value to pickerwheel when ready    ${district}
    ELSE
        Should be true  ${FALSE}    msg='Cannot resolve ios version,please recheck'
    END

Verify pindrop popup display
    DobbyAppCommon.Wait until element is visible except stale   ${checkout_shipping_address.pin_your_location}     timeout=10s

Verify confirm update location button should be disabled
    DobbyAppCommon.Wait until element is visible except stale       ${checkout_shipping_address.disable_save_and_continue}

# Shipping address page should be displayed          #not ready to implement due to makroclick migration
#     DobbyAppCommon.Wait until element is visible except stale       ${checkout_shipping_address.txt_step1of3}

Select address from list
    [Arguments]     ${address_no}
    ${district_locator}    String.Replace string    ${checkout_shipping_address.address_for_delivery}    {{address_no}}    ${address_no}
    DobbyAppCommon.Tap element when ready   ${checkout_shipping_address.address_for_delivery}

Click back button on create address modal
    DobbyAppCommon.Tap element when ready   ${checkout_shipping_address.btn_close}

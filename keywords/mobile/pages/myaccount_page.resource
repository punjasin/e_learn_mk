*** Settings ***
Resource        ../../../resources/locators/${platform}/myaccount_locator.resource
Resource        ../../../resources/locators/${platform}/common_locator.resource
Resource        ../../../common/mobile/mobile_common.resource

*** Keywords ***
Tap my account
    DobbyAppCommon.Tap element when ready           ${myaccount.txt_account}
    mobile_common.Wait until loading complete

Verify my account data
    [Arguments]     ${firstname}    ${lastname}     ${email}
    DobbyAppCommon.Wait until element is visible except stale     ${myaccount.txt_account_details}
    myaccount_page.Verify full name display correct      ${firstname}    ${lastname} 
    myaccount_page.Verify email     ${email}
    
Verify full name display correct
    [Arguments]     ${firstname}    ${lastname}
    ${firstname_locator}    String.Replace string    ${myaccount.txt_name_surname}    {{firstname}}    ${firstname}
    ${txt_name_surname_locator}    String.Replace string    ${firstname_locator}    {{lastname}}    ${lastname}
    DobbyAppCommon.Wait until element is visible except stale       ${txt_name_surname_locator}

Verify email
    [Arguments]     ${email}
    ${txt_email_locator}    String.Replace string    ${myaccount.txt_email}    {{email}}    ${email}
    DobbyAppCommon.Wait until element is visible except stale       ${txt_email_locator}
    
Edit firstname
    [Arguments]     ${firstname}
    IF   "${platform}" == "${platform_list['android']}"
        Clear Text       ${myaccount.input_name_txt}
        DobbyAppCommon.Input text to element when ready       ${myaccount.input_name}       ${firstname}
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        ${suffix_name}=             Generate random string  4   [LOWER]
        DobbyAppCommon.Tap element when ready   ${myaccount.input_name_txt}
        DobbyAppCommon.Clear text when ready    ${myaccount.input_name_txt}
        DobbyAppCommon.Input text to element when ready  ${myaccount.input_name_txt}  ${suffix_name}
    END
    
Edit lastname
    [Arguments]     ${lastname}
    IF   "${platform}" == "${platform_list['android']}"
        Clear Text       ${myaccount.input_surname_txt}
        DobbyAppCommon.Input text to element when ready       ${myaccount.input_surname}       ${lastname}
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        ${suffix_name}=             Generate random string  4   [LOWER]
        DobbyAppCommon.Tap element when ready   ${myaccount.input_surname_txt}
        DobbyAppCommon.Clear text when ready    ${myaccount.input_surname_txt}
        DobbyAppCommon.Input text to element when ready  ${myaccount.input_surname_txt}  ${suffix_name}
    END

Verify email display in disable mode
    [Arguments]     ${email}
    IF   "${platform}" == "${platform_list['android']}"
        ${input_email_txt_email_locator}    String.Replace string    ${myaccount.input_email_txt_email}    {{email}}    ${email}
        Element Attribute Should Match	${input_email_txt_email_locator}    enabled     False
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        ${input_email_locator}    String.Replace string    ${myaccount.input_email}    {{email}}    ${email}
        DobbyAppCommon.Wait until element is visible except stale	${input_email_locator}
    END

Tap save button
    DobbyAppCommon.Tap element when ready  ${myaccount.txt_save}
    
Click back button
    DobbyAppCommon.Tap element when ready  ${myaccount.txt_cancel}
    
Click confirm to back
    IF   "${platform}" == "${platform_list['android']}"
        DobbyAppCommon.Tap element when ready     ${myaccount.yes_and_confirm}
        DobbyAppCommon.Wait until element is visible except stale   ${myaccount.txt_account} 
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        DobbyAppCommon.Tap element when ready               ${myaccount.yes_and_confirm}
        DobbyAppCommon.Wait until element is visible except stale       ${myaccount.txt_account_txt}
    END

Verify edit account data success message
    IF   "${platform}" == "${platform_list['android']}"
        mobile_common.Wait until loading complete
        DobbyAppCommon.Wait until element is visible except stale   ${myaccount.txt_save_success}    
        AppiumLibrary.Wait until page does not contain element   ${myaccount.txt_save_success}
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        mobile_common.Toast message should display and close   ${myaccount.toast_success}
    END

Go back from my accout to more menu
    mobile_common.Tap more menu
    
# myaccount v2

Edit firstname and lastname
    [Arguments]     ${name}
    IF   "${platform}" == "${platform_list['android']}"
        DobbyAppCommon.Tap element when ready  ${myaccount.input_name_surname_txt}
        DobbyAppCommon.Clear text when ready    ${myaccount.input_name_surname_txt}
        DobbyAppCommon.Input text to element when ready  ${myaccount.input_name_surname}      ${name}
        DobbyAppCommon.Hide keyboard until success
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        ${first_name}=             Generate random string  4   [LOWER]
        ${last_name}=             Generate random string  4   [LOWER]
        DobbyAppCommon.Tap element when ready   ${myaccount.input_name_surname}
        DobbyAppCommon.Clear text when ready    ${myaccount.input_name_surname}
        DobbyAppCommon.Input text to element when ready  ${myaccount.input_name_surname}      ${first_name}${SPACE}${last_name}
    END

Edit email
    [Arguments]     ${email}
    IF   "${platform}" == "${platform_list['android']}"
        DobbyAppCommon.Tap element when ready   ${myaccount.input_email_txt}
        DobbyAppCommon.Clear text when ready    ${myaccount.input_email_txt}
        DobbyAppCommon.Input text to element when ready  ${myaccount.input_email}      ${email}
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        DobbyAppCommon.Tap element when ready   ${myaccount.input_container_email}
        DobbyAppCommon.Clear text when ready    ${myaccount.input_container_email}
        DobbyAppCommon.Input text to element when ready  ${myaccount.input_container_email}      ${email}
        mobile_common.Tap done on keyboard
    END

Verify please input firstname and lastname error message
    IF   "${platform}" == "${platform_list['android']}"
        DobbyAppCommon.Wait until element is visible except stale   ${myaccount.please_specify_name_surname}
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        DobbyAppCommon.Wait until element is visible except stale   ${myaccount.input_name_surname_txt}
    END

Verify please input email error message
    DobbyAppCommon.Wait until element is visible except stale   ${myaccount.please_specify_email}
    
Verify please input correct email error message
    DobbyAppCommon.Wait until element is visible except stale   ${myaccount.please_specify_valid_email}
    
Verify cannot click update button
    IF   "${platform}" == "${platform_list['android']}"
        DobbyAppCommon.Wait until element is visible except stale  ${myaccount.txt_false_update}
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        DobbyAppCommon.Wait until element is visible except stale  ${myaccount.disable_update}
    END

Click update button
    IF   "${platform}" == "${platform_list['android']}"
        DobbyAppCommon.Tap element when ready   ${myaccount.txt_true_update}
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        DobbyAppCommon.Tap element when ready   ${myaccount.enable_update}
    END

Verify my account data login v2
    [Arguments]     ${name}     ${email}
    IF   "${platform}" == "${platform_list['android']}"
        ${details_name_locator}    String.Replace string    ${myaccount.details_name}    {{name}}    ${name}
        ${details_email_locator}    String.Replace string    ${myaccount.details_email}    {{email}}    ${email}
        DobbyAppCommon.Wait until element is visible except stale       ${details_name_locator}
        DobbyAppCommon.Wait until element is visible except stale       ${details_email_locator}
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        ${name_locator}    String.Replace string    ${myaccount.description_fullname}   {{fullname}}    ${name}
        ${description_fullname_locator}    String.Replace string    ${name_locator}    {{email}}    ${email}
        DobbyAppCommon.Wait until element is visible except stale   ${description_fullname_locator}
    END

Tap to edit my account details
    DobbyAppCommon.Tap element when ready   ${myaccount.txt_account_details}

# Android

Verify my account phone number display info
    [Arguments]     ${phone}
    ${phone_format}    mobile_common.Convert mobile number to mobile format    ${phone}
    ${txt_phone_locator}    String.Replace string    ${myaccount.txt_phone}    {{phone}}    ${phone_format}
    DobbyAppCommon.Wait until element is visible except stale       ${txt_phone_locator}

Verify my account phone number display empty
    DobbyAppCommon.Wait until element is visible except stale       ${myaccount.txt_dash}

Click to edit account phone
    DobbyAppCommon.Tap element when ready       ${myaccount.txt_account_details_phone}
    DobbyAppCommon.Wait until element is visible except stale    ${myaccount.txt_change_phone_number}

Click cancel to back
    DobbyAppCommon.Tap element when ready     ${myaccount.no_and_go_back}

Reverse account data to original
    mobile_common.Tap more menu
    myaccount_page.Tap my account
    myaccount_page.Tap to edit my account details
    myaccount_page.Edit first name  ${user['userforLogin_data']['firstname']}
    myaccount_page.Edit last name   ${user['userforLogin_data']['lastname']}
    myaccount_page.Tap save button
    myaccount_page.Verify edit account data success message

Input otp
    [Arguments]     ${otp}
    DobbyAppCommon.Input text to element when ready     ${myaccount.txt_otp}     ${otp}

Tap verify otp
    DobbyAppCommon.Tap element when ready       ${myaccount.verify_email_btn}

# # myaccount v2

Verify edit account data success message login v2
    mobile_common.Wait until loading complete
    DobbyAppCommon.Wait until element is visible except stale   ${myaccount.toast_success}
    AppiumLibrary.Wait until page does not contain element   ${myaccount.toast_success}

# iOS

Get firstname
    ${fname}=   DobbyAppCommon.Get text from element when ready  ${myaccount.input_name_txt}
    Set test variable       ${fname}
    [Return]        ${fname}

Get lastname
    ${lname}=   DobbyAppCommon.Get text from element when ready  ${myaccount.input_surname_txt}
    Set test variable       ${lname}
    [Return]        ${lname}

Email should be
    [Arguments]     ${expected}
    ${expected_locator}    String.Replace string    ${myaccount.expected}    {{expected}}    ${expected}
    DobbyAppCommon.Wait until element is visible except stale   ${expected_locator}

Click finish on keyboard
    DobbyAppCommon.Tap element when ready               ${myaccount.success_2}

Tap my address menu
    DobbyAppCommon.Tap element when ready      ${myaccount.my_address}
    mobile_common.Wait until loading complete

# # myaccount V2

Get firstname and lastname
    ${fullname}=   DobbyAppCommon.Get text from element when ready     ${myaccount.input_name_surname}
    Set test variable       ${fullname}
    [Return]        ${fullname}

Swipe to change default address by address name
    [Arguments]     ${address_name}
    ${address_locator}      String.Replace string   ${myaccount.txt_address_name}   {{address_name}}  ${address_name}
    DobbyAppCommon.Find element    ${address_locator}   scroll_panel=${default_scroll_view}    moveto=Top    percent=${swipeLongScroll}      timeout=${shortTimeout}
    mobile_common.Swipe right to left      ${address_locator}
    myaccount_page.Tap default address button   ${address_name}

Tap default address button
    [Arguments]     ${address_name}
    IF   "${platform}" == "${platform_list['android']}"
        DobbyAppCommon.Tap element when ready      ${myaccount.btn_default_address}
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        ${btn_default_locator}    String.Replace string   ${myaccount.btn_default_address}   {{address_name}}  ${address_name}
        DobbyAppCommon.Tap element when ready      ${btn_default_locator}
    END

Verify default address name display correct
    [Arguments]     ${address_name}
    ${address_locator}      String.Replace string   ${myaccount.txt_default_address_name}    {{address_name}}  ${address_name}
    DobbyAppCommon.Find element    ${address_locator}   scroll_panel=${default_scroll_view}    moveto=Bottom    percent=${swipeLongScroll}      timeout=${shortTimeout}
    DobbyAppCommon.Wait until element is visible except stale   ${address_locator}

Get total points
    ${point}   DobbyAppCommon.Get text from element when ready     ${myaccount.txt_total_point}
    IF    "${platform}" == "${platform_list['ios']}"
        ${point}       String.Remove string        ${point}      ${space}${mobile['loyalty']['label']['my_profile_loyalty_label']}
        ${point}       Evaluate            '${point}'.strip()
    END
    [Return]        ${point}

Get default address name
    ${default_address}   DobbyAppCommon.Get text from element when ready     ${myaccount.txt_default_address}
    [Return]             ${default_address}
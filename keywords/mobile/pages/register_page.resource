*** Settings ***
Resource        ../../../resources/locators/${platform}/register_locator.resource
Resource        ../../../resources/locators/${platform}/common_locator.resource
Resource        ../../../common/mobile/mobile_common.resource

*** Keywords ***
Current page should be register page
    DobbyAppCommon.Wait until element is visible except stale   ${register.create_new_account}
    
Click create account
    IF   "${platform}" == "${platform_list['android']}"
        DobbyAppCommon.Wait until element is visible except stale        ${register.txt_create_new_account}    
        Tap     ${register.txt_create_new_account}
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        DobbyAppCommon.Tap element when ready       ${register.txt_create_new_account}
        DobbyAppCommon.Wait until element is visible except stale       ${register.create_new_account}
    END

Select individual type account
    DobbyAppCommon.Tap element when ready   ${register.individual_type}

Select business type account
    DobbyAppCommon.Tap element when ready   ${register.business_type}

Input first name
    [Arguments]     ${first_name}
    DobbyAppCommon.Input text to element when ready     ${register.register_firstname}       ${first_name}
    
Input last name
    [Arguments]     ${last_name}
    DobbyAppCommon.Input text to element when ready     ${register.register_lastname}       ${last_name}
    
Input email
    [Arguments]     ${email}
    DobbyAppCommon.Input text to element when ready     ${register.register_email}       ${email}

Click to view t&c 
    DobbyAppCommon.Tap element when ready   ${register.popup_title_terms_and_conditions}
    
Click back
    IF   "${platform}" == "${platform_list['android']}"
        mobile_common.Click x button to close webview
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        DobbyAppCommon.Wait until element is visible except stale        ${register.popup_title_terms_and_conditions_txt}
        DobbyAppCommon.Tap element when ready      ${register.webview_close_icon}
        DobbyAppCommon.Wait until element is visible except stale       ${register.create_new_account}
    END

Input password
    [Arguments]     ${password}
    DobbyAppCommon.Input text to element when ready     ${register.register_password}       ${password}
    
Clear password field
    Clear Text      ${register.register_password}
    
Click to checked t&c
    IF   "${platform}" == "${platform_list['android']}"
        Wait Until Keyword Succeeds	 1x  5 sec  DobbyAppCommon.Tap element when ready    ${register.register_checkbox}
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        DobbyAppCommon.Tap element when ready       ${register.txt_accept}
    END

Click create button
    DobbyAppCommon.Tap element when ready       ${register.create}
    
Verify user cannot create account when checkbox is uncheck
    Element Attribute Should Match	    ${register.create}	enabled     False
    
Verify minimum 8 character password warning
    DobbyAppCommon.Wait until element is visible except stale        ${register.password_length_error}
    
Verify password warning disappear
    IF   "${platform}" == "${platform_list['android']}"
        AppiumLibrary.Wait until page does not contain element        ${register.password_length_error}
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        AppiumLibrary.Page should not contain element        ${register.password_length_error}
    END

Input mobile number
    [Arguments]     ${mobile_number}
    DobbyAppCommon.Input text to element when ready     ${register.register_mobile}       ${mobile_number}

Select business type
    [Arguments]    ${business_type_list}
    DobbyAppCommon.Tap element when ready    ${register.select_business_type}
    ${business_type_L1_locator}     String.Replace string    ${register.register_business_type}    {{business_type}}        ${business_type_list[0]}
    DobbyAppCommon.Tap element when ready    ${business_type_L1_locator}
    ${business_type_L2_locator}     String.Replace string    ${register.register_business_type}    {{business_type}}        ${business_type_list[1]}
    DobbyAppCommon.Tap element when ready    ${business_type_L2_locator}
    ${business_type_L3_locator}     String.Replace string    ${register.register_business_type}    {{business_type}}        ${business_type_list[2]}
    DobbyAppCommon.Tap element when ready    ${business_type_L3_locator}

Tap accept terms and conditions
    DobbyAppCommon.Tap element when ready       ${register.checkbox_unfilled_icon}

Input otp
    [Arguments]     ${otp}
    DobbyAppCommon.Input text to element when ready     ${register.txt_otp}     ${otp}

Tap to input OTP or PIN number
    [Documentation]     tap to input otp or pin
    [Arguments]     ${number}
    ${length}=      Get length      ${number}
    DobbyAppCommon.Tap element when ready
    FOR     ${i}    IN RANGE    0   ${length}   1
        ${locator}=     String.Replace string      ${otp_pin.btn_num_pin}      ***string***        ${number[${i}]}
        DobbyAppCommon.Tap element when ready      ${locator}
    END
    mobile_common.Wait until loading complete

Tap register button
    DobbyAppCommon.Tap element when ready       ${register.register_btn}

Tap verify otp
    DobbyAppCommon.Tap element when ready       ${register.verify_otp_btn}

Tap close register page
    DobbyAppCommon.Tap element when ready       ${register.close_icon}

# Android
Verify terms and conditions redirection
    DobbyAppCommon.Wait until element is visible except stale        ${register.popup_title_terms_and_conditions_txt}


# iOS
Input tax number
    [Arguments]     ${taxid}
    DobbyAppCommon.Input text to element when ready  ${register.txt_taxid}     ${taxid}
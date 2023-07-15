*** Settings ***
Resource        ../../../resources/locators/${platform}/login_locator.resource
Resource        ../../../resources/locators/${platform}/common_locator.resource
Resource        ../../../common/mobile/mobile_common.resource

*** Keywords ***
Tap login
    IF   "${platform}" == "${platform_list['android']}"
        DobbyAppCommon.Wait until element is visible except stale   ${login.btn_login}
        DobbyAppCommon.Tap element when ready    ${login.btn_login}
        mobile_common.Wait until loading complete
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        DobbyAppCommon.Tap element when ready  ${login.btn_login}
        mobile_common.Wait until loading complete
    END

Input email login        
    [Arguments]     ${emaillogin}
    IF   "${platform}" == "${platform_list['android']}"
        DobbyAppCommon.Wait until element is visible except stale       ${login.input_customer_email}
        DobbyAppCommon.Input text to element when ready      ${login.input_customer_email}          ${emaillogin}
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        DobbyAppCommon.Wait until element is visible except stale    ${login.txt_login}
        FOR     ${i}    IN RANGE    0   20
            DobbyAppCommon.Tap element when ready           ${login.input_customer_email}
            ${is_shown}=                AppiumLibrary.Is Keyboard Shown
            Exit for loop if    ${is_shown}
        END
        Should be true  ${is_shown}     msg='Keyboard is not shown after tab on element 20 times'
        DobbyAppCommon.Input text to element when ready         ${login.input_customer_email}    ${emaillogin}
    END

Input password login        
    [Arguments]     ${passwordlogin}
    IF   "${platform}" == "${platform_list['android']}"
        DobbyAppCommon.Wait until element is visible except stale       ${login.input_customer_password}
        DobbyAppCommon.Input text to element when ready      ${login.input_customer_password}       ${passwordlogin}
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        ${password}=    Convert To String   ${passwordlogin} 
        ${length_pwd}=      Get Length       ${password} 
        FOR   ${i}    IN RANGE   0   4
            DobbyAppCommon.Input text to element when ready      ${login.txt_forget_password}    ${passwordlogin}
            ${att}=  mobile_common.Get element attribute when ready  ${login.txt_forget_password}  value
            ${actual_pwd}=    Get Length   ${att}
            ${result}=    Run keyword and return status   Should Be Equal   ${length_pwd}   ${actual_pwd}
            Exit for loop if    ${result}
        END    
    END

Confirm login
    IF   "${platform}" == "${platform_list['android']}"
        Click element     ${login.btn_login}
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        DobbyAppCommon.Tap element when ready  ${login.btn_login}
    END

User location should be order history page
    DobbyAppCommon.Wait until element is visible except stale   ${login.txt_order}
    
# Login V2

Verify current page is login page
    IF   "${platform}" == "${platform_list['android']}"
        DobbyAppCommon.Wait until element is visible except stale       ${login.txt_login}
        DobbyAppCommon.Wait until element is visible except stale       ${login.txt_select_login}
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        DobbyAppCommon.Wait until element is visible except stale       ${login.btn_login}
        DobbyAppCommon.Wait until element is visible except stale       ${login.method_to_login}
    END

Tap login by phone
    DobbyAppCommon.Tap element when ready       ${login.phone_number}

Tap login by email
    DobbyAppCommon.Tap element when ready       ${login.email}
    
Click register new account
    DobbyAppCommon.Tap element when ready       ${login.create_account}
    
Click close login page
    DobbyAppCommon.Tap element when ready       ${login.icon_button}
    
Tap confirm login
    DobbyAppCommon.Tap element when ready       ${login.login_with_email_login_button_enabled}

# Create new account page
Verify current page is register page
    IF   "${platform}" == "${platform_list['android']}"
        DobbyAppCommon.Wait until element is visible except stale       ${login.txt_create_account}
        DobbyAppCommon.Wait until element is visible except stale       ${login.please_fill_out}
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        DobbyAppCommon.Wait until element is visible except stale       ${login.create_account}
        DobbyAppCommon.Wait until element is visible except stale       ${login.please_fill_out}
    END

Input name and surname
    [Arguments]     ${text}
    DobbyAppCommon.Input text to element when ready     ${login.input_name_surname}   ${text}
    
Click read terms and condition
    DobbyAppCommon.Tap element when ready       ${login.policy}
    
Click create account
    DobbyAppCommon.Tap element when ready       ${login.enabled_create_account}
    
Verify cannot click create account
    DobbyAppCommon.Wait until element is visible except stale       ${login.disable_create_account}
    
Verify input correct phone number error message
    DobbyAppCommon.Wait until element is visible except stale       ${login.txt_please_valid_phone_number}
    
Verify input name and surname error message
    DobbyAppCommon.Wait until element is visible except stale       ${login.txt_please_specify}
    
# OTP page
Verify current page is otp page
    DobbyAppCommon.Wait until element is visible except stale       ${login.txt_authenticate}
    DobbyAppCommon.Wait until element is visible except stale       ${login.txt_fill_otp}

Input otp
    [Arguments]     ${text}
    DobbyAppCommon.Input text to element when ready  ${login.edittext}  ${text}
    
Click verify otp
    DobbyAppCommon.Tap element when ready       ${login.txt_verify_password}
    
# Login by email
Input email
    [Arguments]     ${text}
    DobbyAppCommon.Input text to element when ready     ${login.input_login_with_email}     ${text}
    
Input password
    [Arguments]     ${text}
    DobbyAppCommon.Input text to element when ready     ${login.input_password}     ${text}
    
Click forgot password
    DobbyAppCommon.Tap element when ready       ${login.txt_forget_password}
    
Input email in forgot password page
    [Arguments]     ${text}
    DobbyAppCommon.Input text to element when ready     ${login.confirm_email_input}      ${text}
    
Click confirm forgot password email
    DobbyAppCommon.Tap element when ready       ${login.confirm_button_enabled}
    
Input new password in forgot password page
    DobbyAppCommon.Input text to element when ready     ${login.confirm_new_password_input_newPassword}
    
Input comfirm new password in forgot password page
    DobbyAppCommon.Input text to element when ready     ${login.confirm_new_password_input_confirmNewPassword}
    
# Login by phone number
Input mobile number on login by phone number page
    [Arguments]     ${mobile_no}
    DobbyAppCommon.Input text to element when ready  ${login.input_telephone_number}  ${mobile_no}
    
Click send OTP
    DobbyAppCommon.Tap element when ready  ${login.txt_sent_otp}

Tap login with phone
    DobbyAppCommon.Tap element when ready    ${login.btn_login_by_phone}
    
# Android

Verify invalid email or password warning
    DobbyAppCommon.Wait until element is visible except stale   ${login.txt_fix_info}
    DobbyAppCommon.Wait until element is visible except stale   ${login.txt_invalid_info}

Tap x to exit login
    mobile_common.Tap go back icon

Verify unlogin page in my order
    DobbyAppCommon.Wait until element is visible except stale   ${login.txt_please_login}

Tap eye icon and verify visible password
    [Arguments]     ${passwordlogin}
    DobbyAppCommon.Tap element when ready     ${login.input_password_eye_icon_active}
    Element Should Contain Text     ${login.login_with_email_input_password}      ${passwordlogin}
    
Click forgot password link
    DobbyAppCommon.Tap element when ready     ${login.forgot_your_password}

# # Login V2

Verify current page is otp page when login by email
    DobbyAppCommon.Wait until element is visible except stale       ${login.txt_login}
    DobbyAppCommon.Wait until element is visible except stale       ${login.input_login_with_email}

Toast message display incorrect email or password login v2
    mobile_common.Toast message should display and close       ${login.toast_warning}

Toast message display incorrect otp login v2
    mobile_common.Toast message should display and close       ${login.toast_warning}

Verify update mobile number after login
    DobbyAppCommon.Wait until element is visible except stale       ${login.update_info_account}
    DobbyAppCommon.Wait until element is visible except stale       ${login.add_phone_number_to_account}

Input mobile number after login
    [Arguments]     ${text}
    DobbyAppCommon.Input text to element when ready     ${login.please_specify_phone_number}     ${text}

Input mobile number on create new account page
    [Arguments]     ${text}
    DobbyAppCommon.Input text to element when ready     ${login.input_phone_number}   ${text}

Click process with this number
    DobbyAppCommon.Tap element when ready       ${login.continue_with_phone_number}

Verify current page is login via phone number page
    DobbyAppCommon.Wait until element is visible except stale       ${login.txt_phone_number}

Update phone number via homepage
    [Arguments]     ${mobile_no}
    DobbyAppCommon.Wait until element is visible except stale       ${login.description_phone}
    DobbyAppCommon.Clear text when ready    ${login.input_container}
    DobbyAppCommon.Input text to element when ready  ${login.input_container}  ${mobile_no}

Click continue with this phone
    DobbyAppCommon.Tap element when ready  ${login.txt_phoneNumber}

Verify update phone number error message
    DobbyAppCommon.Wait until element is visible except stale       ${login.enter_valid_phone}

Click get new otp
    DobbyAppCommon.Tap element when ready       ${login.txt_sent_otp_again}

Toast message display incorrect otp
    DobbyAppCommon.Wait until element is visible except stale       ${login.invalid_otp}

# iOS

Forgot password
    FOR     ${i}    IN RANGE    0   4
        DobbyAppCommon.Tap element when ready  ${login.forgot_your_password}
        ${is_clicked}=  Run keyword and return status   AppiumLibrary.Wait Until Element Is Visible   ${login.reset_your_password}
        Exit for loop if    ${is_clicked}
    END
    Should be true  ${is_clicked}   msg='Failed to click forgot password button after 3 retry'

Cancel forgot password
    DobbyAppCommon.Tap element when ready  ${login.vertical_scroll}

Create a new account via login page
    DobbyAppCommon.Tap element when ready  ${login.txt_create_account}

Cancel login
    DobbyAppCommon.Tap element when ready  ${login.webview_close_icon}

Verify invalid email or password
    DobbyAppCommon.Wait until element is visible except stale   ${login.toast_warning}

Verify login page at my order menu
    DobbyAppCommon.Wait until element is visible except stale   ${login.txt_please_login}

Verify input password is in dot form
    [Arguments]     ${password}
    ${length_pwd}      Get length       ${password}
    ${input_txt}=  mobile_common.Get element attribute when ready  ${login.login_with_email_input_password}  value
    ${length_input}     Get length      ${input_txt}
    ${pwd_length}       Convert to integer      ${length_pwd}
    ${input_length}     Convert to integer      ${length_input}
    Should be equal as integers     ${pwd_length}       ${input_length}

Verify input password is matched
    [Arguments]     ${password}
    ${input_pwd}        mobile_common.Get element attribute when ready     ${login.txt_password}      value
    Should be equal     ${password}     ${input_pwd}

Tap eye icon
    ${element}      Get webelement              ${login.password}
    Click element       ${element}

Verify eye icon open
    DobbyAppCommon.Wait until element is visible except stale       ${login.icon_eye_visible}

Verify eye icon close
    DobbyAppCommon.Wait until element is visible except stale       ${login.icon_eye_hide}

# # Login V2

Current page should be create new password page
    DobbyAppCommon.Wait until element is visible except stale       ${login.create_new_password}

Click confirm change password
    DobbyAppCommon.Tap element when ready       ${login.update_new_password_button_enabled}

Input mobile number
    [Arguments]     ${text}
    DobbyAppCommon.Input text to element when ready     ${login.input_phone_number}   ${text}
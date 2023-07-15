*** Settings ***
Resource        ../pages/myaccount_page.resource
Resource        ../pages/more_page.resource
Resource        login_feature.resource

*** Keywords ***
Verify correct email in my account
    [Arguments]    ${email}
    mobile_common.Tap more menu
    myaccount_page.Tap my account
    myaccount_page.Verify email           ${email} 
    myaccount_page.Go back from my accout to more menu

Verify account details
    [Arguments]    ${firstname}     ${lastname}     ${email}
    more_page.Verify user is logged in
    myaccount_page.Tap my account
    myaccount_page.Verify my account data login v2   ${firstname}${SPACE}${lastname}   ${email}
    myaccount_page.Go back from my accout to more menu    

Navigate to get point in my account
    [Arguments]     ${email}       ${password}
    login_feature.User login from my order      ${email}       ${password}
    mobile_common.Tap more menu
    myaccount_page.Tap my account
    ${current_point}    myaccount_page.Get total points
    [Return]        ${current_point}

Get and input otp from mail
    [Arguments]        ${update_email}    ${mail_password}    ${sender_address}
    Acquire Lock    otp_api.Get otp from gmail
    ${otp_number}=  otp_api.Get otp from gmail    ${update_email}    ${mail_password}    ${sender_address}
    myaccount_page.Input otp    ${otp_number}
    myaccount_page.Tap verify otp
    Release Lock    otp_api.Get otp from gmail

Verify my account data and phone are correct
    [Arguments]    ${first_name}    ${last_name}    ${email}    ${mobile}
    mobile_common.Tap more menu
    myaccount_page.Tap my account
    myaccount_page.Verify my account data    ${first_name}    ${last_name}    ${email}
    myaccount_page.Verify my account phone number display info    ${mobile}

Update email in my account
    [Arguments]    ${update_email}
    mobile_common.Tap more menu
    myaccount_page.Tap my account
    myaccount_page.Tap to edit my account details
    myaccount_page.Edit email    ${update_email}
    myaccount_page.Tap save button
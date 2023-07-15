*** Settings ***
Resource        ../pages/login_page.resource
Resource        ../pages/register_page.resource
Resource        ../pages/checkout_shipping_address_page.resource
Resource        ../pages/favourite_page.resource
Resource        ../pages/more_page.resource

*** Keywords ***
User login from my order
    [Arguments]    ${email_or_mobile}     ${password_or_otp}       ${method}=email
    mobile_common.Tap my orders menu
    login_page.Tap login
    login_feature.Login via email or mobile method    ${method}    ${email_or_mobile}    ${password_or_otp}
    login_page.User location should be order history page

User login from my favourite list
    [Arguments]    ${email_or_mobile}     ${password_or_otp}      ${method}=email
    mobile_common.Tap favourite list menu
    login_page.Tap login
    login_feature.Login via email or mobile method    ${method}   ${email_or_mobile}     ${password_or_otp}
    favourite_page.User location should be favourite list page

Login after click checkout button
    [Arguments]    ${email_or_mobile}     ${password_or_otp}     ${method}=email
    basket_page.Tap checkout button
    login_page.Tap login
    login_feature.Login via email or mobile method    ${method}   ${email_or_mobile}     ${password_or_otp}

Login via email or mobile method
    [Arguments]     ${method}   ${email_or_mobile}    ${password}=xxx
    [Documentation]     Have default password=xxx because method mobile not need password value
    IF  '${method}'=='email'
        login_feature.Login via email method    ${email_or_mobile}  ${password}
    ELSE IF  '${method}'=='mobile'
        login_feature.Login via mobile method   ${email_or_mobile}
    END

Login via email method
    [Arguments]     ${email}    ${password}
    login_page.Tap login by email
    login_page.Input email      ${email}
    login_page.Input password   ${password}
    login_page.Tap confirm login
    mobile_common.Wait until loading complete

Login via mobile method
    [Arguments]     ${mobile}
    # Please edit this method step if makro have method for us to get otp
    login_page.Tap login by phone
    login_page.Input mobile number on login by phone number page  ${mobile}
    login_page.Tap login with phone

User login via email and password
    [Arguments]    ${email}     ${password}
    login_page.Tap login
    login_feature.Login via email method    ${email}  ${password}

Created new account after click checkout button
    [Arguments]    ${firstname}=${user['userforNew_address']['shipping_firstname']}     ${lastname}=${user['userforNew_address']['shipping_lastname']}     ${email}=${user['userforNew_address']['email']}     ${password}=${user['userforLogin_data']['password']}     
    IF   "${platform}" == "${platform_list['android']}"
        basket_page.Tap checkout button
        login_feature.Created new account   ${firstname}     ${lastname}     ${email}    ${password}    
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        basket_page.Tap checkout button
        login_feature.Created new account   ${firstname}     ${lastname}     ${email}    ${password}   
        mobile_common.Wait until loading complete
        checkout_shipping_address_page.Click accept pindrop popup if exist
    END

Created new account at my favourite list menu
    [Arguments]    ${firstname}     ${lastname}     ${email}    ${password}    
    mobile_common.Tap favourite list menu
    login_feature.Created new account   ${firstname}     ${lastname}     ${email}    ${password}   

Created new account
    [Arguments]    ${firstname}     ${lastname}     ${email}    ${password}    
    IF   "${platform}" == "${platform_list['android']}"   
        register_page.Click create account
        register_page.Input first name        ${firstname}
        register_page.Input last name         ${lastname}
        register_page.Input email             ${email}
        register_page.Click to view t&c
        register_page.Click back
        register_page.Input password         ${password}
        register_page.Click to checked t&c
        register_page.Click create button
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        register_page.Click create account
        mobile_common.Wait until loading complete
        register_page.Input first name        ${firstname}
        register_page.Input last name         ${lastname}
        register_page.Input email             ${email}
        register_page.Click to view t&c
        mobile_common.Wait until loading complete
        register_page.Click back
        register_page.Input password         ${password}
        register_page.Click to checked t&c
        register_page.Click create button
    END

Create new account from onboarding page
    [Arguments]    ${firstname}     ${lastname}     ${email}    ${password}
    IF   "${platform}" == "${platform_list['android']}"   
        register_page.Input first name        ${firstname}
        register_page.Input last name         ${lastname}
        register_page.Input email             ${email}
        register_page.Click to view t&c
        register_page.Click back
        register_page.Input password         ${password}
        register_page.Click to checked t&c
        register_page.Click create button    
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        mobile_common.Wait until loading complete
        register_page.Input first name        ${firstname}
        register_page.Input last name         ${lastname}
        register_page.Input email             ${email}
        register_page.Click to view t&c
        mobile_common.Wait until loading complete
        register_page.Click back
        register_page.Input password         ${password}
        register_page.Click to checked t&c
        register_page.Click create button 
    END

Logout via more menu
    mobile_common.Tap more menu
    more_page.Click logout button
    more_page.Click logout button on popup

Toast message should not display create account successful
    AppiumLibrary.Page should not contain element   ${login.txt_account_created_successfully}

Get and input otp
    [Arguments]    ${otp_number}=000000
    # sleep    15s    #wait otp sent
    # Acquire Lock    otp_api.Get otp from sms
    # ${otp_number}    otp_api.Verify OTP delivery within 1 minute    ${old_otp_number}    #bug login otp jira ticket MAN-17606
    register_page.Input otp    ${otp_number}
    register_page.Tap verify otp
    # Release Lock    otp_api.Get otp from sms

Login with phone and input otp
    [Arguments]    ${mobile}
    # ${old_otp_number}  otp_api.Get otp from sms  ${otp_url}    #bug login otp jira ticket MAN-17606
    login_feature.Login via mobile method    ${mobile}
    login_feature.Get and input otp
    
# Android
Login if popup appear
    [Arguments]    ${email}     ${password}
    ${count}=  Get Matching Xpath Count   xpath=//form[@id="customer_login"]/div/Input 
    Run Keyword If   ${count}>0     login_page.Input email login         ${email}
    Run Keyword If   ${count}>0     login_page.Input password login       ${password}
    Run Keyword If   ${count}>0     login_page.Confirm login

Created new account at my order menu
    [Arguments]    ${firstname}     ${lastname}     ${email}    ${password}    
    mobile_common.Tap my orders menu
    login_feature.Created new account   ${firstname}     ${lastname}     ${email}    ${password}  

Created new account login v2
    [Arguments]    ${name}     ${mobile}    ${otp}
    register_page.Click create account
    login_page.Input name and surname  ${name}
    login_page.input mobile number on create new account page  ${mobile}
    login_page.Click create account
    mobile_common.Wait until loading complete
    login_page.Input otp  ${otp}
    login_page.Click verify otp

User login with invalid email or password from my order and verify warning
    [Arguments]    ${email}     ${password}
    mobile_common.Tap my orders menu
    login_page.Tap login
    # V1 step         #not ready to implement due to makroclick migration
    # login_page.Input email login         ${email}
    # login_page.Input password login       ${password}
    # login_page.Confirm login
    # login_page.Verify invalid email or password warning
    # V2 step
    login_page.Tap login by email
    login_page.Input email  ${email}
    login_page.Input password  ${password}
    login_page.Tap confirm login
    mobile_common.Wait until loading complete
    login_page.Toast message display incorrect email or password login v2

User login from my order and unhidden password via eye icon
    [Arguments]    ${email}     ${password}
    mobile_common.Tap my orders menu
    login_page.Tap login
    login_page.Input email login         ${email}
    login_page.Input password login       ${password}
    login_page.Tap eye icon and verify visible password       ${password}
    login_page.Confirm login

Login with inspect password
    [Arguments]    ${email}    ${password}
    login_page.Tap login
    # V1 step          #not ready to implement due to makroclick migration
    # login_page.Input email login         ${email}
    # login_page.Input password login      ${password}
    # login_page.Tap eye icon for verify password    ${password}
    # V2 step
    login_page.Tap login by email
    login_page.Input email  ${email}
    login_page.Input password  ${password}
    login_page.Tap eye icon and verify visible password    ${password}
    login_page.Tap confirm login
    mobile_common.Wait until loading complete

Toast message should display create account successful
    mobile_common.Toast message should display and close   ${login.txt_account_created_successfully}

# iOS
Login to mango
    [Arguments]     ${email_or_mobile}     ${password_or_otp}     ${method}=email
    login_page.Tap login
    # V2 step
    IF  '${method}'=='email'
        login_page.Tap login by email
        login_page.Input email  ${email_or_mobile}
        login_page.Input password  ${password_or_otp}
        login_page.Tap confirm login
        mobile_common.Wait until loading complete
    ELSE IF  '${method}'=='mobile'
        login_page.Tap login by phone
        login_page.Input mobile number on login by phone number page  ${email_or_mobile}
        login_page.Click send OTP
        login_page.Input otp  ${password_or_otp}
        login_page.Click verify otp
    END
    # V1         #not ready to implement due to makroclick migration
    # login_page.Input email login            ${username}
    # login_page.Input password login         ${password}
    # login_page.Confirm login

Created new account at my orders menu
    [Arguments]    ${firstname}     ${lastname}     ${email}    ${password}    
    mobile_common.Tap my orders menu
    login_feature.Created new account   ${firstname}     ${lastname}     ${email}    ${password}

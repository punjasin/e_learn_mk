*** Settings ***
Force Tags       login_V2    register    regression
Resource        ../../common/mobile/mobile_common.resource
Resource        ../../common/api/api_common.resource

Variables       ../../resources/settings/db.yaml
Variables       ../../resources/settings/aws.yaml
Variables       ../../resources/data/otp.yaml

Suite Setup         mobile_common.Mango Suite Setup
Test Setup          mobile_common.Mango Test Setup
Test Teardown       Run Keywords    mobile_common.Mango Test Teardown    AND    register_feature.Delete registered user     ${mobile_data['number1']}

*** Test Cases ***
Register via phone number and login to update email _ MAKNET-2609 _ MAKNET-7478
    [Tags]  MAKNET-2609  MAKNET-7478  priority_high  myaccount  sanity  smoke  android  ios  priority_critical  must_pass
    [Documentation]    Verify register new individual via phone number and edit email after register
    ...                MAKNET-2609    Login via phone number
    ...                MAKNET-7478    User without email, Able to add email at my account page
    Comment   Step: Register via phone number in MAKNET-2609
    mobile_common.Tap favourite list menu
    favourite_page.Tap register button
    register_feature.Delete registered user     ${mobile_data['number1']}
    register_feature.Register new individual    ${user['register_info']['first_name']}    ${user['register_info']['last_name']}     ${mobile_data['number1']}
    myaccount_feature.Verify my account data and phone are correct    ${user['register_info']['first_name']}    ${user['register_info']['last_name']}    ${user['register_info']['none_email']}     ${mobile_data['number1']}
    login_feature.Logout via more menu
    Comment   Step: Login to update email in MAKNET-7478
    favourite_feature.Process to login
    login_feature.Login with phone and input otp    ${mobile_data['number1']}
    myaccount_feature.Update email in my account    ${user_os['userforregister_userdate_email']['update_email']}
    myaccount_feature.Get and input otp from mail    ${user_os['userforregister_userdate_email']['update_email']}    ${user_os['userforregister_userdate_email']['mail_password']}    ${imap_outlook['sender_address']}
    myaccount_page.Verify my account data    ${user['register_info']['first_name']}    ${user['register_info']['last_name']}    ${user_os['userforregister_userdate_email']['update_email']}
    login_feature.Logout via more menu

User be able to access registration page via bottom navigation bar _ MAKNET-2790
    [Tags]  MAKNET-2790  priority_high  smoke  android  ios
    [Documentation]    Verify able to access registration page via bottom navigation bar
    [Teardown]         mobile_common.Mango Test Teardown
    favourite_feature.Navigate and verify favourite list page not login
    favourite_page.Tap register button
    register_page.Tap close register page
    favourite_page.Verify favourite list page not login
    order_history_feature.Navigate and verify my orders list page not login
    order_history_page.Tap register button
    register_page.Tap close register page
    order_history_page.Verify my orders list page not login
    
Customer can register new account as Business User via MakroPro application _ MAKNET-1997
    [Tags]  MAKNET-1997  priority_critical  must_pass   sanity  smoke  android  ios
    [Documentation]    Verify register new business user via phone number
    mobile_common.Tap favourite list menu
    favourite_page.Tap register button
    register_feature.Delete registered user     ${mobile_data['number1']}
    register_feature.Register new business    ${user['register_info']['first_name']}    ${user['register_info']['last_name']}     ${mobile_data['number1']}    ${mobile_additional['register']['business_type_list']}
    mobile_common.Tap shopping menu
    tnc_feature.Update terms and conditions popup if exist
    privacy_consent_feature.Confirm update privacy setting if exist
    mobile_common.Tap favourite list menu
    favourite_page.Verify favourite page new account does not have favourite list
    mobile_common.Tap my orders menu
    order_history_page.Verify orderhistory page not have order
    myaccount_feature.Verify my account data and phone are correct    ${user['register_info']['first_name']}    ${user['register_info']['last_name']}    ${user['register_info']['none_email']}     ${mobile_data['number1']}

Register new account as individual user _ MAKNET-4971
    [Tags]  MAKNET-4971  priority_critical   must_pass  sanity  smoke  android  ios
    [Documentation]    Verify register new individual user via phone number
    mobile_common.Tap favourite list menu
    favourite_page.Tap register button
    register_feature.Delete registered user     ${mobile_data['number1']}
    register_feature.Register new individual    ${user['register_info']['first_name']}    ${user['register_info']['last_name']}     ${mobile_data['number1']}
    mobile_common.Tap shopping menu
    tnc_feature.Update terms and conditions popup if exist
    privacy_consent_feature.Confirm update privacy setting if exist
    mobile_common.Tap favourite list menu
    favourite_page.Verify favourite page new account does not have favourite list
    mobile_common.Tap my orders menu
    order_history_page.Verify orderhistory page not have order
    myaccount_feature.Verify my account data and phone are correct    ${user['register_info']['first_name']}    ${user['register_info']['last_name']}    ${user['register_info']['none_email']}     ${mobile_data['number1']}
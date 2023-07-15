*** Settings ***
Force Tags      my_account    regression
Resource        ../../common/mobile/mobile_common.resource
Resource        ../../common/api/api_common.resource

Suite Setup         mobile_common.Mango Suite Setup
Test Setup          mobile_common.Mango Test Setup
Test Teardown       mobile_common.Mango Test Teardown

*** Test Cases ***
[Add shipping address page] User can check box on "Set as default address" _ MAKNET-5810
    [Tags]  MAKNET-5810  priority_high  sanity  smoke  android  ios  myaccount
    [Documentation]     Verify user can change default address in my account by swipe
    login_feature.User login from my order      ${user['userforLogin_data']['email']}       ${user['userforLogin_data']['password']}
    mobile_common.Tap more menu
    myaccount_page.Tap my account
    myaccount_page.Tap my address menu
    ${default_address}    myaccount_page.Get default address name
    myaccount_page.Swipe to change default address by address name  ${default_address}
    myaccount_page.Verify default address name display correct      ${default_address}
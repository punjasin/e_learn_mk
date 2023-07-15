*** Settings ***
Force Tags       login    regression
Resource        ../../common/mobile/mobile_common.resource
Resource        ../../common/api/api_common.resource

Suite Setup         mobile_common.Mango Suite Setup
Test Setup          mobile_common.Mango Test Setup
Test Teardown       mobile_common.Mango Test Teardown

*** Test Cases ***
User be able to login with existing email when navigate to login page via my orders page _ MAKNET-7219
    [Tags]  MAKNET-7219  priority_critical  must_pass  sanity  smoke  android  ios  login
    [Documentation]     Verify user login successfully via my order menu by check that user can access my account view account detail
    login_feature.User login from my order      ${user['userforLogin_data']['email']}       ${user['userforLogin_data']['password']}
    myaccount_feature.Verify correct email in my account                     ${user['userforLogin_data']['email']}
    AppiumLibrary.Background app                seconds=${short_timeout}
    myaccount_feature.Verify account details    ${user['userforLogin_data']['firstname']}   ${user['userforLogin_data']['lastname']}   ${user['userforLogin_data']['email']}

Logout via more menu _ MAKNET-2610
    [Tags]  MAKNET-2610  priority_high  sanity  smoke  android  ios  login
    [Documentation]     Verify user logout successfully via more menu by check that logout button not displayed for unlogin user
    login_feature.User login from my order      ${user['userforLogin_data']['email']}       ${user['userforLogin_data']['password']}
    login_feature.Logout via more menu
    Wait until keyword succeeds    2x    5s    more_page.Verify logout button not appear for unlogin user
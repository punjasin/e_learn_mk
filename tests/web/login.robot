*** Settings ***
Resource            ../../keywords/web/pages/forgot_makroproweb_page.resource

Resource            ../../common/web/web_common.resource

Test Setup          web_common.Makro pro web setup
Test Teardown       web_common.Close browser

*** Test Cases ***
Verify when clicking forgot password, should redirected to the reset password page _ MAKNET-3711
    [Tags]    MAKNET-3711     web
    [Documentation]     Verify user redirect to forgot page by check from reset password title and email instruction
    login_makroproweb_feature.Navigate to forgot password page
    forgot_makroproweb_page.Verify reset password title with instruction display
*** Settings ***
Resource            ../../../resources/locators/web/login_makroproweb_locator.resource
Resource            ../../../common/web/web_common.resource

*** Keywords ***
Click email tab
    DobbyWebCommon.Click element when ready     ${login_makroproweb.btn_email_tab}

Click forgot password
    DobbyWebCommon.Click element when ready     ${login_makroproweb.txt_forgot_password}

Click login button
    DobbyWebCommon.Click element when ready     ${login_makroproweb.btn_login}
Input email
    [Arguments]    ${email}
    DobbyWebCommon.Input text to element when ready      ${login_makroproweb.txt_email_input}    ${email}

Input password
    [Arguments]    ${password}
    DobbyWebCommon.Input text to element when ready      ${login_makroproweb.txt_password_input}    ${password}
*** Settings ***
Resource        ../../../resources/locators/${platform}/cookie_locator.resource
Resource        ../../../resources/locators/${platform}/common_locator.resource
Resource        ../../../common/mobile/mobile_common.resource

*** Keywords ***
Click accept all button on cookie SDK popup
    DobbyAppCommon.Tap element when ready      ${cookie.btn_accept_cookies}

Click settings button on cookie SDK popup
    DobbyAppCommon.Tap element when ready      ${cookie.btn_setting_cookies}

Verify cookie SDK popup appear
    [Arguments]     ${timeout}=${short_timeout}
    DobbyAppCommon.Wait until element is visible except stale      ${cookie.title}     ${timeout}

Verify cookie SDK popup content
    IF   "${platform}" == "${platform_list['android']}"
        DobbyAppCommon.Wait until element is visible except stale      ${cookie.btn_setting_cookies}    ${timeout}
        DobbyAppCommon.Wait until element is visible except stale      ${cookie.txt_cookies_consent}     ${timeout}
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        DobbyAppCommon.Wait until element is visible except stale      ${cookie.cookies_policy}    ${timeout}
        DobbyAppCommon.Wait until element is visible except stale      ${cookie.txt_cookies_consent}     ${timeout}
    END

Click close cookie
    IF   "${platform}" == "${platform_list['android']}"
        DobbyAppCommon.Tap element when ready      ${cookie.btn_onetrust_close}
    ELSE IF     "${platform}" == "${platform_list['ios']}"
        DobbyAppCommon.Tap element when ready      ${cookie.close} 
    END

Click accept cookie
    IF   "${platform}" == "${platform_list['android']}"  
        DobbyAppCommon.Tap element when ready      ${cookie.btn_onetrust_accept}
    ELSE IF     "${platform}" == "${platform_list['ios']}"
        DobbyAppCommon.Tap element when ready      ${cookie.privacy_accept_cookies}
    END

Click close cookie if exist
    IF   "${platform}" == "${platform_list['android']}"
        ${found}        Run keyword and return status       DobbyAppCommon.Wait until element is visible except stale       ${cookie.onetrust_consent_sdk}      timeout=${short_timeout}
        Run keyword if      ${found}        cookie_page.Click close cookie
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        ${found}        Run keyword and return status       DobbyAppCommon.Wait until element is visible except stale       ${cookie.privacy}      timeout=10s
        Run keyword if      ${found}        cookie_page.Click close cookie
    END

Click accept cookie if exist
    IF   "${platform}" == "${platform_list['android']}"
        ${found}        Run keyword and return status       DobbyAppCommon.Wait until element is visible except stale       ${cookie.onetrust_consent_sdk}      timeout=${short_timeout}
        Run keyword if      ${found}        cookie_page.Click accept cookie
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        ${found}        Run keyword and return status       DobbyAppCommon.Wait until element is visible except stale       ${cookie.privacy}      timeout=10s
        Run keyword if      ${found}        cookie_page.Click accept cookie
    END

Wait until cookie disappear
    IF   "${platform}" == "${platform_list['android']}"
        ${found}        Run keyword and return status       DobbyAppCommon.Wait until element is visible except stale       ${cookie.onetrust_consent_sdk}      timeout=${short_timeout}
        Run keyword if      ${found}        AppiumLibrary.Wait until page does not contain element      ${cookie.onetrust_consent_sdk}      timeout=${short_timeout}
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        ${found}        Run keyword and return status       DobbyAppCommon.Wait until element is visible except stale       ${cookie.web_alert_dialog}      timeout=10s
        Run keyword if      ${found}        AppiumLibrary.Wait until page does not contain element      ${cookie.web_alert_dialog}      timeout=10s
    END

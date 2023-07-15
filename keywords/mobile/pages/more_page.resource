*** Settings ***
Resource        ../../../resources/locators/${platform}/moremenu_locator.resource
Resource        ../../../resources/locators/${platform}/common_locator.resource
Resource        ../../../common/mobile/mobile_common.resource

*** Keywords ***
Click logout button
    mobile_common.Find element and tap             ${moremenu_page.btn_logout}
    
Verify user is logged in
    mobile_common.Tap more menu
    mobile_common.Find element                      ${moremenu_page.btn_logout}

Verify logout button not appear for unlogin user
    mobile_common.Tap more menu
    ${logout_button_found}    Run keyword and return status    AppiumLibrary.Wait until element is visible    ${moremenu_page.btn_logout}    timeout=${short_timeout}
    Should be equal   ${logout_button_found}  ${False}

Verify inform Customer service office hours
    DobbyAppCommon.Wait until element is visible except stale       ${moremenu_page.txt_customer_service}
    
Select my account menu
    DobbyAppCommon.Tap element when ready     ${moremenu_page.txt_my_account}
    
Verify can access FAQ menu
    DobbyAppCommon.Tap element when ready                           ${moremenu_page.txt_faq}
    mobile_common.Wait until loading complete
    DobbyAppCommon.Wait until element is visible except stale       ${moremenu_page.txt_faq_header}

Click start to be seller with maknet menu
    DobbyAppCommon.Tap element when ready    ${moremenu_page.txt_start_your_business}

Verify redirect to seller onboarding
    IF   "${platform}" == "${platform_list['android']}"
        mobile_common.Select once for lead to chrome app if popup select app exist
        mobile_common.Tap accept an Not sync if chrome welcome page and turn on sync page is exist
        mobile_common.Close translation bar in chrome if exist
        DobbyAppCommon.Wait until element is visible except stale       ${moremenu_page.txt_become_a_seller}  
        DobbyAppCommon.Wait until element is visible except stale       ${moremenu_page.txt_register_now}
    ELSE IF   "${platform}" == "${platform_list['ios']}"
        Run keyword and ignore error        cookie_page.Click accept cookie if exist
        DobbyAppCommon.Wait until element is visible except stale       ${moremenu_page.txt_become_a_seller}
        DobbyAppCommon.Wait until element is visible except stale       ${moremenu_page.txt_register_now}
    END

Click privacy setting menu
    DobbyAppCommon.Tap element when ready   ${moremenu_page.txt_privacy_settings}
    
Click back from privacy setting menu
    mobile_common.Tap go back icon
    DobbyAppCommon.Wait until element is visible except stale    ${moremenu_page.title}

Click KYC menu
    DobbyAppCommon.Tap element when ready  ${moremenu_page.txt_tel_your_business}
    
Verify no privacy setting menu shown
    AppiumLibrary.Page should not contain element       ${moremenu_page.txt_privacy_settings}
    
# Android

Click logout button on popup
    DobbyAppCommon.Tap element when ready     ${moremenu_page.btn_confirm_logout}

Click FAQ menu
    DobbyAppCommon.Tap element when ready  ${moremenu_page.txt_faq}

Click exit from FAQ menu    
    DobbyAppCommon.Tap element when ready  ${moremenu_page.txt_faq_viewgroup}

Verify message CS team contact is visible
    DobbyAppCommon.Wait until element is visible except stale       ${moremenu_page.talkToUs}
    DobbyAppCommon.Wait until element is visible except stale       ${moremenu_page.call_with_us}     timeout=3s
    ${element_value}=     mobile_common.Get element attribute when ready      ${moremenu_page.call_with_us}      enabled
    Should be true      '${element_value}'

# iOS

Verify CS contact method
    DobbyAppCommon.Wait until element is visible except stale       ${moremenu_page.call_with_us}     timeout=3s
    ${element_value}=     mobile_common.Get element attribute when ready      ${moremenu_page.call_with_us}      enabled
    Should be true      '${element_value}'

Verify FAQ menu
    DobbyAppCommon.Wait until element is visible except stale       ${moremenu_page.txt_faq}
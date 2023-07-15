*** Settings ***
Resource        ../../../resources/locators/${platform}/privacy_setting_locator.resource
Resource        ../../../resources/locators/${platform}/common_locator.resource
Resource        ../../../common/mobile/mobile_common.resource

*** Keywords ***
Click accept privacy popup
    IF   "${platform}" == "${platform_list['android']}"
        Verify current page is privacy setting page
        DobbyAppCommon.Tap element when ready       ${privacy.txt_screen_footer_success}
        AppiumLibrary.Wait until page does not contain element        ${privacy.txt_privacy_settings}
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        Verify current page is privacy setting page
        DobbyAppCommon.Tap element when ready   ${privacy.privacy_settings_screen_footer}
        AppiumLibrary.Wait until page does not contain element        ${privacy.txt_privacy_settings}
    END    

Click setting in privacy popup
    IF   "${platform}" == "${platform_list['android']}"
        DobbyAppCommon.Tap element when ready   ${privacy.txt_setting}
        AppiumLibrary.Wait until page does not contain element        ${privacy.txt_setting}
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        DobbyAppCommon.Tap element when ready   ${privacy.settings}
        AppiumLibrary.Wait until page does not contain element        ${privacy.txt_consent}
    END

Verify privacy consent popup display
    [Arguments]     ${timeout}=${short_timeout}
    DobbyAppCommon.Wait until element is visible except stale       ${privacy.txt_consent}        ${timeout}

Verify update privacy consent setting display
    [Arguments]     ${timeout}=${short_timeout}
    DobbyAppCommon.Wait until element is visible except stale       ${privacy.txt_update_consent_title}        ${timeout}

Tap confirm update privacy consent setting
    DobbyAppCommon.Tap element when ready       ${privacy.btn_confirm_update_consent}
    
Verify current page is privacy setting page
    DobbyAppCommon.Wait until element is visible except stale  ${privacy.txt_privacy_settings}
    
Verify title message on privacy content
    [Arguments]    ${content_name}  ${content_desc}
    ${content_name_locator}    String.Replace string    ${privacy.txt_content_desc}    {{content_name}}    ${content_name}
    ${txt_content_desc_locator}    String.Replace string    ${content_name_locator}    {{content_desc}}    ${content_desc}
    DobbyAppCommon.Wait until element is visible except stale  ${txt_content_desc_locator}
    
Get privacy status by name
    [Arguments]     ${privacy_name}
    IF   "${platform}" == "${platform_list['android']}"
        ${switcher_container_locator}    String.Replace string    ${privacy.switcher_container}    {{privacy_name}}    ${privacy_name}
        ${switcher_viewgroup_locator}    String.Replace string    ${privacy.switcher_viewgroup}    {{privacy_name}}    ${privacy_name}
        DobbyAppCommon.Wait until element is visible except stale   ${switcher_container_locator}
        ${status}       AppiumLibrary.Get element attribute     ${switcher_viewgroup_locator}        content-desc
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        ${privacy_screen_in_on_state_locator}    String.Replace string    ${privacy.privacy_screen_in_on_state}    {{privacy_name}}    ${privacy_name}
        DobbyAppCommon.Wait until element is visible except stale   ${privacy_screen_in_on_state_locator}
        ${status}       AppiumLibrary.Get element attribute     ${privacy_screen_in_on_state_locator}        name
    END
    [Return]    ${status}

Click toggle on privacy content
    [Arguments]    ${content_name}
    IF   "${platform}" == "${platform_list['android']}"
        ${switcher_locator}    String.Replace string    ${privacy.switcher}    {{content_name}}    ${content_name}
        DobbyAppCommon.Tap element when ready  ${switcher_locator}
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        ${privacy_screen_in_off_state_locator}    String.Replace string    ${privacy.privacy_screen_in_off_state}    {{content_name}}    ${content_name}
        DobbyAppCommon.Tap element when ready       ${privacy_screen_in_off_state_locator}
    END

Click toggle on read more privacy content page
    IF   "${platform}" == "${platform_list['android']}"
        DobbyAppCommon.Tap element when ready   ${privacy.privacy_item_screen_switcher}
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        DobbyAppCommon.Tap element when ready     ${privacy.switcher}
    END

Click read more on privacy content
    [Arguments]    ${content_name}
    ${read_more_locator}    String.Replace string    ${privacy.read_more}    {{content_name}}    ${content_name}
    DobbyAppCommon.Tap element when ready  ${read_more_locator}
    
Verify read more privacy content
    [Arguments]    ${content_name}      ${content_detail}      ${force_enable}=${false}
    ${content_name_locator}    String.Replace string    ${privacy.content_name}    {{content_name}}    ${content_name}
    ${content_detail_locator}    String.Replace string    ${privacy.content_detail}    {{content_detail}}    ${content_detail}
    DobbyAppCommon.Wait until element is visible except stale    ${content_name_locator}
    DobbyAppCommon.Wait until element is visible except stale    ${content_detail_locator}
    IF      '${content_name}'=='${false}'    
        ${txt_get_deal_locator}    String.Replace string    ${privacy.txt_get_deal}    {{content_name}}    ${content_name}
        DobbyAppCommon.Wait until element is visible except stale    ${txt_get_deal_locator}
    END
    
Click read privacy detail on privacy menu
    IF   "${platform}" == "${platform_list['android']}"
        mobile_common.Find element and tap     ${privacy.see_details}
        DobbyAppCommon.Wait until element is visible except stale   ${privacy.main_content}
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        mobile_common.Find element and tap     ${privacy.see_details}
        DobbyAppCommon.Wait until element is visible except stale       ${privacy.webview_content}
    END

Click confirm disable privacy in read more privacy page
    DobbyAppCommon.Wait until element is visible except stale       ${privacy.not_receive_offers_If_not_accepted}
    DobbyAppCommon.Tap element when ready   ${privacy.txt_not_accepted}
    Verify current page is privacy setting page

Click cancel disable privacy in read more privacy page
    DobbyAppCommon.Wait until element is visible except stale       ${privacy.not_receive_offers_If_not_accepted}
    DobbyAppCommon.Tap element when ready   ${privacy.txt_back}

Verify no confirm disable privacy display
    AppiumLibrary.Page should not contain element       ${privacy.not_receive_offers_If_not_accepted}
    
Click submit on read more page
    DobbyAppCommon.Tap element when ready  ${privacy.txt_success}
    
# Android

Verify content switch is enabled
    DobbyAppCommon.Wait until element is visible except stale       ${privacy.privacy_screen_in_on_state}

Verify content switch is disabled
    DobbyAppCommon.Wait until element is visible except stale       ${privacy.privacy_screen_in_off_state}

Verify read more privacy by title
    [Arguments]     ${title}
    ${txt_title_locator}    String.Replace string    ${privacy.txt_title}    {{title}}    ${title}
    DobbyAppCommon.Wait until element is visible except stale   ${txt_title_locator}

# Click confirm disable     #not ready to implement due to makroclick migration
#   DobbyAppCommon.Tap element when ready  xpath=//android.view.ViewGroup/android.widget.TextView[@text='${global['yesAndConfirm']}']

# iOS

# Click confirm disable on read more page     #not ready to implement due to makroclick migration
#     DobbyAppCommon.Tap element when ready  xpath=//XCUIElementTypeOther[@name='${global['yesAndConfirm']}']
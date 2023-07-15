*** Settings ***
Resource        ../pages/privacy_setting_page.resource

*** Keywords ***
Read and set privacy content 
    [Arguments]     ${topic}    ${enable}=${true}
    privacy_setting_page.Verify title message on privacy content     ${topic['name']}   ${topic['detail']}   
    privacy_setting_page.Click read more on privacy content  ${topic['name']}   
    privacy_setting_page.Verify read more privacy content    ${topic['name']}   ${topic['detail']}
    Run keyword if      '${enable}'=='${false}'      privacy_setting_page.Click toggle on privacy content  ${topic['name']}
    # ...     AND   privacy_setting_page.Click confirm disable         #not ready
    privacy_setting_page.Click submit on read more page

Verify privacy is enable by name
    [Arguments]     ${privacy_name}
    ${switcher_in_on_state_locator}    String.Replace string    ${privacy.switcher_in_on_state}    {{privacy_name}}    ${privacy_name}
    DobbyAppCommon.Wait until element is visible except stale   ${switcher_in_on_state_locator}
    
Verify privacy is disable by name
    [Arguments]     ${privacy_name}
    ${switcher_in_off_state_locator}    String.Replace string    ${privacy.switcher_in_off_state}    {{privacy_name}}    ${privacy_name}
    DobbyAppCommon.Wait until element is visible except stale   ${switcher_in_off_state_locator}
    
Accept all for privacy popup if exist
    ${status}=  Run keyword and return status    privacy_setting_page.Verify privacy consent popup display
    IF  ${status}
        privacy_setting_page.Click setting in privacy popup
        privacy_setting_page.Verify current page is privacy setting page
        privacy_setting_page.Click accept privacy popup
    END

Confirm update privacy setting if exist
    ${found_update_privacy}=  Run keyword and return status    privacy_setting_page.Verify update privacy consent setting display
    IF  ${found_update_privacy}
        privacy_setting_page.Tap confirm update privacy consent setting
        mobile_common.Wait until toast message disappeared
    END

# Android

Click toggle privacy and confirm turn off with argument
    [Arguments]     ${confirm}
    privacy_setting_page.Click toggle privacy in read more privacy page
    Run keyword if      '${confirm}'=='True'        privacy_setting_page.Click confirm disable privacy in read more privacy page
    Run keyword if      '${confirm}'=='False'       privacy_setting_page.Click cancel disable privacy in read more privacy page

# iOS


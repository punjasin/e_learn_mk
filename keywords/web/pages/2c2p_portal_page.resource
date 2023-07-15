*** Settings ***
Resource            ../../../resources/locators/web/2c2p_portal_locator.resource
Resource            ../../../common/web/web_common.resource

*** Keywords ***
Verify otp header
    DobbyWebCommon.Wait until element is visible except stale     ${2c2p_portal.txt_otp_header}

Input otp textbox
    [Arguments]    ${otp}
    DobbyWebCommon.Input text to element when ready               ${2c2p_portal.txt_otp}    ${otp}

Verify 2c2p image header
    DobbyWebCommon.Wait until element is visible except stale     ${2c2p_portal.image_2c2p}

Click confirm button 
    DobbyWebCommon.Click element when ready                       ${2c2p_portal.btn_confirm}

Click submit button
    DobbyWebCommon.Click element when ready                       ${2c2p_portal.btn_submit}

Click back to merchant button
    DobbyWebCommon.Click element when ready               ${2c2p_portal.btn_back_to_merchant}
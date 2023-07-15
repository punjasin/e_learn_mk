*** Settings ***
Resource        ../../../resources/locators/${platform}/tnc_locator.resource
Resource        ../../../resources/locators/${platform}/common_locator.resource
Resource        ../../../common/mobile/mobile_common.resource

*** Keywords ***
Click accept terms and conditions popup
    IF   "${platform}" == "${platform_list['android']}"
        DobbyAppCommon.Tap element when ready  ${tnc_btn.accept_terms_and_condition}
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        DobbyAppCommon.Tap element when ready  ${tnc_btn.accept_terms_and_condition_lbl}
    END

Tap confirm update terms and conditioins
    DobbyAppCommon.Tap element when ready       ${tnc_btn.accept_update_terms_and_condition}

Tap accept terms and conditions checkbox
    DobbyAppCommon.Tap element when ready       ${tnc_btn.terms_and_condition_checkbox}

Verify terms and conditions popup display
    [Arguments]     ${timeout}=${short_timeout}
    DobbyAppCommon.Wait until element is visible except stale  ${tnc_txt.terms_and_condition_title}     timeout=${timeout}
    DobbyAppCommon.Wait until element is visible except stale  ${tnc_txt.digital_services}      timeout=${timeout}        

Verify terms and conditions popup not display 
    Wait until element is not visible   ${tnc_txt.terms_and_condition_title}
    
Verify update terms and conditions popup display
    [Arguments]     ${timeout}=${short_timeout}
    DobbyAppCommon.Wait until element is visible except stale  ${tnc_txt.update_terms_and_condition_title}     timeout=${timeout}

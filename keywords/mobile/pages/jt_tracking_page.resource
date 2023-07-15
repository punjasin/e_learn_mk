*** Settings ***
Resource        ../../../resources/locators/${platform}/jt_tracking_locator.resource
Resource        ../../../resources/locators/${platform}/common_locator.resource
Resource        ../../../common/mobile/mobile_common.resource

*** Keywords ***
URL should be
    [Arguments]     ${jt_tracking_url}
    IF   "${platform}" == "${platform_list['android']}"
        ${actual}=  DobbyAppCommon.Get text from element when ready     ${jt_tracking.url_bar}
        Should be equal     https://${actual.strip()}   ${jt_tracking_url.strip()}
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        Sleep  5s  # wait for JT loading complete properly
        DobbyAppCommon.Tap element when ready  ${jt_tracking.url_bar}
        ${actual}=  DobbyAppCommon.Get text from element when ready      ${jt_tracking.txt_url}
        DobbyAppCommon.Tap element when ready    ${jt_tracking.txt_cancel}
        Should be equal     ${actual}   ${jt_tracking_url}
    END

JT tracking number should be in search box
    [Arguments]     ${tracking_number}
    IF   "${platform}" == "${platform_list['android']}"
        ${actual}=  DobbyAppCommon.Get text from element when ready     ${jt_tracking.billcode_list_input}
        Should be equal     ${actual.strip()}   ${tracking_number.strip()}
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        ${actual}=  DobbyAppCommon.Get text from element when ready      ${jt_tracking.caim_next_day}
        Should be equal     '${actual}'   '${tracking_number}'
    END

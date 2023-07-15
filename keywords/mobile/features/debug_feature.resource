*** Settings ***
Resource        ../pages/debug_page.resource

*** Keywords ***
Enable debug menu feature
    [Arguments]     ${feature}
    ${simulate_jailbreak_locator}    String.Replace string    ${debug.simulate_jailbreak}    {{feature}}    ${feature}
    IF   "${platform}" == "${platform_list['android']}"
        Open debug menu
        mobile_common.Find element     ${simulate_jailbreak_locator}
        ${is_enabled}=     Run keyword and return status       Element Attribute Should Match      ${simulate_jailbreak_locator}      checked    true
        Run keyword if  ${is_enabled}==False    DobbyAppCommon.Tap element when ready    ${simulate_jailbreak_locator}
        Element Attribute Should Match      ${simulate_jailbreak_locator}      checked    true
        Close debug menu
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        Open debug menu
        mobile_common.Find element     ${simulate_jailbreak_locator}
        ${is_enabled}=     Run keyword and return status       Element Attribute Should Match      ${simulate_jailbreak_locator}      value    1
        Run keyword if  ${is_enabled}==False    DobbyAppCommon.Tap element when ready    ${simulate_jailbreak_locator}
        Element Attribute Should Match      ${simulate_jailbreak_locator}      value    1
        Close debug menu
    END

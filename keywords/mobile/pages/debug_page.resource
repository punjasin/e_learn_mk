*** Settings ***
Resource        ../../../resources/locators/${platform}/debug_locator.resource
Resource        ../../../resources/locators/${platform}/common_locator.resource
Resource        ../../../common/mobile/mobile_common.resource

*** Keywords ***
Open debug menu
    IF   "${platform}" == "${platform_list['android']}"
        DobbyAppCommon.Long press when ready     ${debug.btn_basket}     duration=${shortTimeout}
        DobbyAppCommon.Wait until element is visible except stale       ${debug.txt_build}
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        DobbyAppCommon.Long press when ready   ${debug.btn_basket}
        DobbyAppCommon.Wait until page contain element except stale   ${debug.build}
    END

Close debug menu
    DobbyAppCommon.Tap element when ready   ${debug.iconIcon}
    AppiumLibrary.Wait until page does not contain element   ${debug.txt_build}

Open Simulate jailbreak mode via debug menu
    IF   "${platform}" == "${platform_list['android']}"
        Open debug menu
        DobbyAppCommon.Tap element when ready    ${debug.simulate_jailbreak}
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        Open debug menu
        DobbyAppCommon.Tap element when ready   ${debug.simulate_jailbreak_switch}
    END

Verify alert jailbreak page is display
    IF   "${platform}" == "${platform_list['android']}"
        DobbyAppCommon.Wait until element is visible except stale     ${debug.txt_for_safe}     timeout=1s
        DobbyAppCommon.Wait until element is visible except stale     ${debug.txt_makro_pro_will_close}     timeout=1s
        AppiumLibrary.Wait until page does not contain element    ${debug.txt_for_safe}
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        DobbyAppCommon.Wait until element is visible except stale      ${debug.for_your_safety}     timeout=1s
        AppiumLibrary.Wait until page does not contain element    ${debug.for_your_safety}   
    END

Invalidate token via debug menu
    IF   "${platform}" == "${platform_list['android']}"
        mobile_common.Find element and tap     ${debug.txt_invalidate}
        DobbyAppCommon.Tap element when ready     ${debug.btn_invalidate}
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        DobbyAppCommon.Swipe down  2
        DobbyAppCommon.Tap element when ready       ${debug.btn_invalidate}
        Run Keyword And Ignore Error    DobbyAppCommon.Tap element when ready               ${debug.warning_invalidate}
    END

# iOS

Clear basket
    mobile_common.Find element and tap     ${debug.clear_basket}
    # Run Keyword And Ignore Error    DobbyAppCommon.Tap element when ready               xpath=//XCUIElementTypeStaticText[@name="This will clear basket on the server too"]/ancestor:: XCUIElementTypeScrollView/following-sibling::XCUIElementTypeScrollView//XCUIElementTypeButton[@name="Clear"]     #recheck again
    # Run Keyword And Ignore Error    DobbyAppCommon.Tap element when ready               chain=**/XCUIElementTypeButton[`label == "OK"`]

Clear storage via debug menu
    DobbyAppCommon.Tap element when ready               ${debug.clear_storage}
    DobbyAppCommon.Tap element when ready               ${debug.clear_basket}
    Run Keyword And Ignore Error    DobbyAppCommon.Tap element when ready               ${debug.btn_ok}

Open prevent screenshots via debug menu
    debug_page.Open debug menu
    DobbyAppCommon.Tap element when ready               ${debug.prevent_screenshots}
    debug_page.Close debug menu

Open search localization via debug menu
    debug_page.Open debug menu
    DobbyAppCommon.Find element      ${debug.search_localization}   scroll_panel=${default_scroll_view}    moveto=Top    percent=${swipeLongScroll}      timeout=${shortTimeout}
    IF   "${platform}" == "${platform_list['android']}"
        ${checked}    AppiumLibrary.Get element attribute    ${debug.search_localization}    checked
        IF    '${checked}'=='false'
            DobbyAppCommon.Tap element when ready    ${debug.search_localization}
        END
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        ${value}    AppiumLibrary.Get element attribute    ${debug.search_localization}    value
        IF    '${value}'=='0'
            DobbyAppCommon.Tap element when ready    ${debug.search_localization}
        END
    END
    debug_page.Close debug menu

Open force new checkout flow via debug menu
    debug_page.Open debug menu
    mobile_common.Find element and tap               ${debug.forcenewcheckoutflow}
    debug_page.Close debug menu
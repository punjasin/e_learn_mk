*** Settings ***
Resource        ../../../resources/locators/${platform}/ordersummary_locator.resource
Resource        ../../../resources/locators/${platform}/common_locator.resource
Resource        ../../../common/mobile/mobile_common.resource

*** Keywords ***
Click to show order summary
    IF   "${platform}" == "${platform_list['android']}"
        DobbyAppCommon.Tap element when ready       ${order_summary.btn_order_summary}
        DobbyAppCommon.Wait until element is visible except stale       ${order_summary.order_summary}
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        DobbyAppCommon.Tap element when ready     ${order_summary.btn_order_summary}
        DobbyAppCommon.Wait until element is visible except stale   ${order_summary.btn_hide_order_summary}
    END

Verify product title in order summary
    [Arguments]     ${productname}
    ${txt_productname_locator}    String.Replace string    ${order_summary.txt_productname}    {{product}}    ${product}
    DobbyAppCommon.Wait until element is visible except stale       ${txt_productname_locator}       timeout=2s
    
Verify total amount in order summary 
    [Documentation]     For iOS, Pass with .00 as argument (ex. 100.00)
    [Arguments]     ${totalamount}     
    ${totalamount_locator}    String.Replace string    ${order_summary.totalamount}    {{totalamount}}    ${totalamount}
    IF   "${platform}" == "${platform_list['android']}"
        DobbyAppCommon.Wait until element is visible except stale       ${totalamount_locator}
        Tap     ${order_summary.btn_hid_order_summary}
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        DobbyAppCommon.Wait until element is visible except stale       ${totalamount_locator}
    END

Tap x to exit checkout
    IF   "${platform}" == "${platform_list['android']}"
        DobbyAppCommon.Wait until element is visible except stale       ${order_summary.btn_order_summary}
        mobile_common.Click x button to close webview
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        DobbyAppCommon.Wait until element is visible except stale       ${order_summary.complementary}
        mobile_common.Tap X button to close webview
    END

Click to hide order summary
    IF   "${platform}" == "${platform_list['android']}"
        DobbyAppCommon.Tap element when ready     ${order_summary.btn_hid_order_summary}
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        DobbyAppCommon.Tap element when ready     ${order_summary.txt_hide_order_summary}
    END

Click remove voucher in order summary
    IF   "${platform}" == "${platform_list['android']}"
        DobbyAppCommon.Tap element when ready       ${order_summary.order_summary_btn}
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        DobbyAppCommon.Tap element when ready     ${order_summary.remove_voucher}
    END

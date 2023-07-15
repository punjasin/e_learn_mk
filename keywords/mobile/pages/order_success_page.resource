*** Settings ***
Resource        ../../../resources/locators/${platform}/order_success_locator.resource
Resource        ../../../resources/locators/${platform}/common_locator.resource
Resource        ../../../common/mobile/mobile_common.resource

*** Keywords ***
Order success message should be displayed
    DobbyAppCommon.Wait until element is visible except stale   ${order_success.order_success}
    DobbyAppCommon.Wait until element is visible except stale   ${order_success.prepare_and_deliver}

Order success with unpaid message should be displayed
    DobbyAppCommon.Wait until element is visible except stale   ${order_success.order_success}
    DobbyAppCommon.Wait until element is visible except stale   ${order_success.pay_within}
    
Click completed button
    DobbyAppCommon.Tap element when ready     ${order_success.txt_done}

# Android

Tap back to merchant
    DobbyAppCommon.Tap element when ready       ${order_success.back_to_store}
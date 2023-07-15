*** Settings ***
Resource            ../../../resources/locators/web/orderhistory_detail_makroproweb_locator.resource
Resource            ../../../common/web/web_common.resource

*** Keywords ***
Verify order number with delivery date display
    [Arguments]        ${order_id}    ${delivery_slot}
    ${order_locator}        String.Replace string      ${orderhistory_detail_makroproweb.txt_order_date}    {{orderId}}    ${order_id}
    ${order_locator}        String.Replace string      ${order_locator}        {{delivery_slot}}        ${delivery_slot}
    DobbyWebCommon.Wait until element is visible except stale         ${order_locator}

Verify payment method is correct
    [Arguments]        ${expected_method}
    DobbyWebCommon.Scroll element into view when ready      ${orderhistory_detail_makroproweb.txt_payment_method}
    ${payment_element}      DobbyWebCommon.Get webelement when ready              ${orderhistory_detail_makroproweb.txt_payment_method}
    ${payment_text}         DobbyWebCommon.Get text from element when ready       ${payment_element}
    Should be equal as strings    ${payment_text}        ${expected_method}

Verify payment status is correct
    [Arguments]        ${expected_status}
    DobbyWebCommon.Scroll element into view when ready      ${orderhistory_detail_makroproweb.txt_payment_status}
    ${payment_element}      DobbyWebCommon.Get webelement when ready              ${orderhistory_detail_makroproweb.txt_payment_status}
    ${payment_text}         DobbyWebCommon.Get text from element when ready       ${payment_element}
    Should be equal as strings    ${payment_text}        ${expected_status}

Click back to history page
    DobbyWebCommon.Scroll to top of page using java script
    DobbyWebCommon.Click element when ready             ${orderhistory_detail_makroproweb.btn_back_history}

Verify product quantity is correct
    [Arguments]    ${expected_qty}
    DobbyWebCommon.Scroll element into view when ready      ${orderhistory_detail_makroproweb.txt_quantity}
    ${qty}         DobbyWebCommon.Get text from element when ready       ${orderhistory_detail_makroproweb.txt_quantity}
    Should be equal         ${qty}        ${expected_qty}

Verify product name display
    [Arguments]    ${product_name}
    ${product_name_locator}        String.Replace string     ${orderhistory_detail_makroproweb.txt_product_name}    {{product_name}}    ${product_name}
    DobbyWebCommon.Scroll element into view when ready       ${product_name_locator}
    DobbyWebCommon.Wait until element is visible except stale         ${product_name_locator}
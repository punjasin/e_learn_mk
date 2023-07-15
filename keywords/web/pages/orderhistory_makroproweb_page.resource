*** Settings ***
Resource            ../../../resources/locators/web/orderhistory_makroproweb_locator.resource
Resource            ../../../common/web/web_common.resource

*** Keywords ***
Verify order history header display
    [Documentation]    Reload page to get last status
    DobbyWebCommon.Wait until element is visible except stale      ${orderhistory_makroproweb.txt_header}        timeout=${longTimeout}

Get last order number by seller name
    [Arguments]    ${seller_name}
    ${order_status_locator}        String.Replace string      ${orderhistory_makroproweb.txt_order_number}    {{seller_name}}    ${seller_name}
    ${order_number}        DobbyWebCommon.Get text from element when ready    ${order_status_locator}
    [Return]               ${order_number}
    
Verify order status should be expected
    [Arguments]    ${seller_name}     ${order_status}
    ${order_number}        orderhistory_makroproweb_page.Get last order number by seller name    ${seller_name}
    ${order_status_locator}        String.Replace string     ${orderhistory_makroproweb.txt_order_status}        {{seller_name}}    ${seller_name}
    ${order_status_locator}        String.Replace string     ${order_status_locator}            {{order_number}}        ${order_number}
    ${order_status_locator}        String.Replace string     ${order_status_locator}            {{order_status}}        ${order_status}
    DobbyWebCommon.Wait until element is visible except stale      ${order_status_locator}

Click target order by seller
    [Arguments]    ${seller_name}
    ${order_number}        orderhistory_makroproweb_page.Get last order number by seller name    ${seller_name}
    ${order_locator}        String.Replace string     ${orderhistory_makroproweb.txt_order_seller}        {{seller_name}}    ${seller_name}
    ${order_locator}        String.Replace string     ${order_locator}            {{order_number}}        ${order_number}
    DobbyWebCommon.Click element when ready           ${order_locator}

Get total order product
    [Arguments]         ${order_number}
    ${order_locator}    String.Replace string    ${orderhistory_makroproweb.txt_all_order}    {{order_number}}     ${order_number}
    ${order_list}       DobbyWebCommon.Get webelements when ready     ${order_locator}
    ${total_order}      Get length       ${order_list}
    [Return]            ${total_order}

Verify total orders should equal to total products
    [Arguments]        ${total_product}    ${order_id}
    ${total_order}    orderhistory_makroproweb_page.Get total order product    ${order_id}
    Should be equal   ${total_order}    ${total_product}
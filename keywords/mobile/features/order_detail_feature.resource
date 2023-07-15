*** Settings ***
Resource        ../pages/order_detail_page.resource
Resource        ../pages/order_history_page.resource

*** Keywords ***
Tap at order number to verify canceled order detail is correct
    [Arguments]     ${order_number}     ${order_detail}
    order_history_page.Tap at order number     ${order_number['order_id']}
    mobile_common.Wait until loading complete
    order_detail_feature.Verify canceled order by unsuccessful payment detail is correct   ${order_number}   ${order_detail}

Verify canceled order by unsuccessful payment detail is correct
    [Arguments]     ${TC_data}      ${order_detail}

    ${order_number_str}     Convert to string        ${TC_data['order_id']}
    ${shop_name_str}        Convert to string        ${TC_data['shop_name']}
    ${order_number}    String.Replace string       ${order_detail['order_number']}    {{order_number}}    ${order_number_str}
    ${shop_name}       String.Replace string       ${order_detail['seller_name']}     {{seller_name}}    ${shop_name_str}

    order_detail_page.Verify order header displays order cancelled
    order_detail_page.Verify cancel description reason is correct   ${order_detail['cancel_reason']['${lang}']}
    order_detail_page.Verify target order number was canceled       ${order_number}
    order_detail_page.Verify product is canceled
    order_detail_page.Verify seller name                            ${shop_name}
    order_detail_page.Verify payment type is correct                ${order_detail['payment_type']['${lang}']}
    order_detail_page.Verify payment status is correct              ${order_detail['payment_status']['${lang}']}

Verify canceled order detail is correct
    [Arguments]     ${TC_data}
    order_detail_page.Verify order header displays order cancelled
    order_detail_page.Verify cancel description reason is correct   ${TC_data['cancel_reason']['${lang}']}
    order_detail_page.Verify target order number was canceled       ${TC_data['order_number']}
    order_detail_page.Verify product is canceled
    order_detail_page.Verify seller name                            ${TC_data['seller_name']}
    order_detail_page.Verify payment type is correct                ${TC_data['payment_type']['${lang}']}
    order_detail_page.Verify payment status is correct              ${TC_data['payment_status']['${lang}']}

Tap at order number to verify all canceled order detail is correct
    [Arguments]     ${order_detail}
    ${total_order}      Get length     ${order_detail} 
    FOR    ${index}     IN    1        ${total_order}
        ${order_key}    Catenate    SEPARATOR=   order_    ${index}
        IF   "${index}"!="1"
            order_detail_page.Tap back button
        END
        order_history_page.Tap at order number     ${order_detail["${order_key}"]['order_number']}
        mobile_common.Wait until loading complete
        order_detail_feature.Verify canceled order detail is correct  ${order_detail['${order_key}']}
    END
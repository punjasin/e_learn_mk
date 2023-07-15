*** Settings ***
Resource        ../../../resources/locators/${platform}/order_detail_locator.resource
Resource        ../../../resources/locators/${platform}/common_locator.resource
Resource        ../../../common/mobile/mobile_common.resource
Resource        voucher_page.resource
Resource        order_history_page.resource

*** Keywords ***
Verify cancel description reason is correct
    [Arguments]     ${expected_reason}
    mobile_common.Verify message in textview       ${expected_reason}

Verify seller name
    [Arguments]     ${seller_name}
    ${txt_seller_name_locator}    String.Replace string    ${order_detail.txt_seller_name}    {{sellerName}}    ${seller_name}
    DobbyAppCommon.Wait until element is visible except stale       ${txt_seller_name_locator}
    
Verify product name
    [Arguments]     ${product_name}
    ${txt_product_name_locator}    String.Replace string    ${order_detail.txt_product_name}    {{product_name}}    ${product_name}
    DobbyAppCommon.Wait until element is visible except stale       ${txt_product_name_locator}

Verify order header displays order cancelled
    DobbyAppCommon.Find element      ${order_detail.canceled}   scroll_panel=${default_scroll_view}    moveto=Bottom    percent=${swipeLongScroll}      timeout=${shortTimeout}
    DobbyAppCommon.Wait until element is visible except stale    ${order_detail.canceled}    ${short_timeout}
    
Verify payment type is correct
    [Arguments]     ${payment_type}
    ${txt_payment_type_locator}     String.Replace string    ${order_detail.txt_payment_type}    {{payment_type}}    ${payment_type}
    DobbyAppCommon.Find element     ${txt_payment_type_locator}   scroll_panel=${default_scroll_view}    moveto=Top    percent=${swipeLongScroll}      timeout=${shortTimeout}

Verify payment status is correct
    [Arguments]     ${payment_status}
    ${txt_payment_status_locator}   String.Replace string    ${order_detail.txt_payment_status}    {{payment_status}}    ${payment_status}
    DobbyAppCommon.Find element     ${txt_payment_status_locator}   scroll_panel=${default_scroll_view}    moveto=Top    percent=${swipeShortScroll}      timeout=${shortTimeout}

Verify target order number was canceled
    [Arguments]     ${order_number}
    ${order_number_str}   Convert to string   ${order_number}
    ${order_status_locator}    String.Replace string    ${order_detail.order_number_cancel}    {{order_number}}    ${order_number_str}
    DobbyAppCommon.Wait until element is visible except stale       ${order_status_locator}

Verify product is canceled
    DobbyAppCommon.Find element     ${order_detail.order_cancel_product}   scroll_panel=${default_scroll_view}    moveto=Top    percent=${swipeLongScroll}      timeout=${shortTimeout}

Click the first product
    IF   "${platform}" == "${platform_list['android']}"
        mobile_common.Find element                 ${order_detail.basket_list_item}
        DobbyAppCommon.Tap element when ready     ${order_detail.basket_list_item_1}
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        mobile_common.Find element                 ${order_detail.basket_list_item_gid}
        DobbyAppCommon.Tap element when ready     ${order_detail.basket_list_item_gid}
    END

Click add all items to the basket button
    IF   "${platform}" == "${platform_list['android']}"
        mobile_common.Find element                 ${order_detail.txt_add_all_to_basket}
        DobbyAppCommon.Tap element when ready     ${order_detail.txt_add_all_to_basket}
        basket_page.Close onboarding swipe to remove from basket
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        mobile_common.Find element                 ${order_detail.txt_add_all_to_basket}
        DobbyAppCommon.Tap element when ready               ${order_detail.txt_add_all_to_basket}  
    END

Get all product name from order detail
    mobile_common.Find element                 ${order_detail.txt_add_all_to_basket}
    DobbyAppCommon.Wait until element is visible except stale   ${order_detail.basket_list_item}
    @{product_name_list}  Create list
    ${count} 	AppiumLibrary.Get matching xpath count 	${order_detail.txt_basket_list_item}

    FOR     ${i}    IN RANGE    1       ${count}+1
        ${index}    Convert to string    ${i}
        ${basket_list_item_textview_index_locator}    String.Replace string    ${order_detail.basket_list_item_textview_index}    {{i}}    ${index}
        ${product_name}  DobbyAppCommon.Get text from element when ready  ${basket_list_item_textview_index_locator}
        Collections.Append to list  ${product_name_list}  ${product_name}
    END
    [Return]  @{product_name_list}

Seller name and order status should be
    [Arguments]  ${seller_name}   ${status}
    IF   "${platform}" == "${platform_list['android']}"
        ${status_cancel_order}    Run keyword and return status    Wait Until Page Contains    รายการสินค้าถูกยกเลิก         15s  
        IF    '${status_cancel_order}' == '${True}'
            ${status_locator}    String.Replace string    ${order_detail.txt_status_seller_name}    {{status}}    ${status}
            ${txt_status_seller_name_locator}    String.Replace string    ${status_locator}    {{seller_name}}    ${seller_name}
            mobile_common.Find element                                 ${txt_status_seller_name_locator}
            DobbyAppCommon.Wait until element is visible except stale   ${txt_status_seller_name_locator}
        ELSE
            ${status_locator}    String.Replace string    ${order_detail.txt_seller_name_status}    {{status}}    ${status}
            ${txt_seller_name_status_locator}    String.Replace string    ${status_locator}    {{seller_name}}    ${seller_name}
            mobile_common.Find element                                 ${txt_seller_name_status_locator}
            DobbyAppCommon.Wait until element is visible except stale   ${txt_seller_name_status_locator}
        END
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        ${status_locator}    String.Replace string    ${order_detail.txt_seller}    {{status}}    ${status}
        ${txt_seller_locator}    String.Replace string    ${status_locator}    {{seller_name}}    ${seller_name}
        mobile_common.Find element                                 ${txt_seller_locator}
        DobbyAppCommon.Wait until element is visible except stale   ${txt_seller_locator}
    END

Order is cancelled because payment expired text should be displayed
    IF   "${platform}" == "${platform_list['android']}"
        FOR     ${i}    IN RANGE    0   4
            ${a_found}=     Run keyword and return status   DobbyAppCommon.Wait until element is visible except stale   ${order_detail.txt_order_cancel}          timeout=5s
            ${b_found}=     Run keyword and return status   DobbyAppCommon.Wait until element is visible except stale   ${order_detail.txt_payment_unsuccess}        timeout=5s
            ${result}=      Evaluate    ${a_found} and ${b_found}
            Exit for loop if    ${result}
            DobbyAppCommon.Swipe up
            DobbyAppCommon.Swipe up
        END
        Should be true  ${result},  msg='unable to find cancelled status after 10 swipe'
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        FOR     ${i}    IN RANGE    0   4
            ${a_found}=     Run keyword and return status   DobbyAppCommon.Wait until element is visible except stale    ${order_detail.txt_order_cancel}          timeout=5s
            ${b_found}=     Run keyword and return status   DobbyAppCommon.Wait until element is visible except stale    ${order_detail.txt_payment_unsuccess}       timeout=5s
            ${result}=      Evaluate    ${a_found} and ${b_found}
            Exit for loop if    ${result}
            DobbyAppCommon.Swipe up
            DobbyAppCommon.Swipe up
        END
        Should be true  ${result},  msg='unable to find cancelled status after 10 swipe'    
    END

Click on tracking button
    IF   "${platform}" == "${platform_list['android']}"
        DobbyAppCommon.Tap element when ready   ${order_detail.tacking_delivery}
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        DobbyAppCommon.Tap element when ready   ${order_detail.txt_deliver}  
    END

Verify line item in order detail
    [Arguments]     ${productordered}
    IF   "${platform}" == "${platform_list['android']}"
        ${product_name_list}=   order_detail_page.Get all item name
        FOR     ${product_name_list}    IN      @{product_name_list}
            Should be equal     ${productordered}   ${product_name_list}
        END
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        ${product_name_list}=   order_detail_page.Get all item name
        FOR     ${product_name_list}    IN      @{product_name_list}
            Should be equal     ${productordered}   ${product_name_list}
        END    
    END

Tap back button
    DobbyAppCommon.Tap element when ready       ${order_detail.icon_button}

Verify order delivered display
    DobbyAppCommon.Wait until element is visible except stale   ${order_detail.txt_order_delivered}
    DobbyAppCommon.Wait until element is visible except stale   ${order_detail.txt_delivered_label}

Get seller name
    ${seller_name}    DobbyAppCommon.Get text from element when ready     ${order_detail.txt_seller_fullname}
    ${seller}         String.Split string     ${seller_name}    :
    [Return]          ${seller[1].strip()}

Get total price
    DobbyAppCommon.Find element   ${order_detail.txt_total_price}     scroll_panel=${default_scroll_view}    moveto=Top    percent=${swipeLongScroll}  timeout=${shortTimeout}
    ${total_price}    DobbyAppCommon.Get text from element when ready     ${order_detail.txt_total_price}
    [Return]          ${total_price}

# Android

Verify product name ,quantity and price
    [Arguments]     ${product}      ${quantity}     ${price}
    mobile_common.Wait until loading complete
    ${txt_product_locator}    String.Replace string    ${order_detail.txt_product}    {{product}}    ${product}
    ${product_locator}    String.Replace string    ${order_detail.txt_quantity}    {{product}}    ${product}
    ${txt_quantity_locator}    String.Replace string    ${txt_quantity_locator}    {{quantity}}    ${quantity}
    ${txt_product_total_locator}    String.Replace string    ${order_detail.txt_product_total}    {{product}}    ${product}
    DobbyAppCommon.Wait until element is visible except stale       ${txt_product_locator}
    DobbyAppCommon.Wait until element is visible except stale       ${txt_quantity_locator}
    ${total}=       DobbyAppCommon.Get text from element when ready     ${txt_product_total_locator}
    ${total_cut}=       Remove string       ${total}    ${SPACE}    ฿
    Should be equal as strings      ${price}     ${total_cut}

Page should show internal payment
    [Arguments]  ${day_week}  ${date}  ${month}  ${year_thai}  ${time}
    IF   "${platform}" == "${platform_list['android']}"
        ${day_week_locator}    String.Replace string    ${order_detail.txt_pay_within_date}    {{day_week}}    ${day_week}
        ${date_locator}    String.Replace string    ${day_week_locator}    {{date}}    ${date}
        ${month_locator}    String.Replace string    ${date_locator}    {{month}}    ${month}
        ${year_thai_locator}    String.Replace string    ${month_locator}    {{year_thai}}    ${year_thai}
        ${txt_pay_within_date_locator}    String.Replace string    ${year_thai_locator}    {{time}}    ${time}
        mobile_common.Find element       ${order_detail.txt_pay_within}
        DobbyAppCommon.Wait until element is visible except stale  ${txt_pay_within_date_locator}
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        mobile_common.Find element       ${order_detail.txt_pay_within}
        ${time_expire} =        Add Time To Date  ${order_created_time}  4 hours      result_format=%H:%M
        ${day_week_locator}    String.Replace string    ${order_detail.txt_pay_within_date}    {{day_week}}    ${day_week}
        ${date_locator}    String.Replace string    ${day_week_locator}    {{date}}    ${date}
        ${month_locator}    String.Replace string    ${date_locator}    {{month}}    ${month}
        ${year_thai_locator}    String.Replace string    ${month_locator}    {{year_thai}}    ${year_thai}
        ${txt_pay_within_date_locator}    String.Replace string    ${year_thai_locator}    {{time}}    ${time}
        ${date_status}      Run keyword and return status       DobbyAppCommon.Wait until element is visible except stale  ${txt_pay_within_date_locator}
        IF  ${date_status}==${False}
            ${day_new}              Add Time To Date  ${order_created_time}  4 hours      result_format=%d
            ${month_new}            Add Time To Date  ${order_created_time}  4 hours      result_format=%m
            ${month_no_padding}=    Replace String Using Regexp    ${month_new}    ^0    ${EMPTY}
            ${month_in_thai_new}    mobile_common.Convert month in thai     ${month_no_padding}
            ${year_new}             Add Time To Date  ${order_created_time}  4 hours      result_format=%Y
            ${year_thai_new}        Evaluate   ${year_new} + 543
            ${date_new}             Add Time To Date  ${order_created_time}  4 hours      result_format=%A
            ${date_new_thai}        DobbyCommon.Get day of week in thai  ${date_new}
            ${day_week_locator}     String.Replace string    ${order_detail.txt_pay_within_new_date}    {{date_new_thai}}    ${date_new_thai}
            ${date_locator}         String.Replace string    ${day_week_locator}    {{day_new}}    ${day_new}
            ${month_locator}        String.Replace string    ${date_locator}    {{month_in_thai_new}}    ${month_in_thai_new}
            ${year_thai_locator}    String.Replace string    ${month_locator}    {{year_thai_new}}    ${year_thai_new}
            ${txt_pay_within_new_date_locator}    String.Replace string    ${year_thai_locator}    {{time_expire}}    ${time_expire}
            DobbyAppCommon.Wait until element is visible except stale  ${txt_pay_within_new_date_locator}
        ELSE
            DobbyAppCommon.Wait until element is visible except stale  ${txt_pay_within_date_locator}   
        END
    END

Page should show order for each seller
    DobbyAppCommon.Wait until element is visible except stale  ${order_detail.txt_seller}
    ${matching}   Get matching xpath count             ${order_detail.txt_seller}
    Should be true   ${matching}>1

Order status in timeline should be
    [Arguments]     ${status}
    mobile_common.Wait until loading complete
    DobbyAppCommon.Swipe up
    FOR     ${i}    IN RANGE    0   4
        ${txt_status_timeline_locator}    String.Replace string    ${order_detail.txt_status_timeline}    {{status}}    ${status}
        ${result}=     Run keyword and return status   DobbyAppCommon.Wait until element is visible except stale   ${txt_status_timeline_locator}
        Exit for loop if    ${result}
        mobile_common.tap basket menu
        mobile_common.Tap my orders menu
    END

Order status should be
    [Arguments]   ${seller_name}  ${status}
    ${seller_name_locator}    String.Replace string    ${order_detail.txt_status_order}    {{sellerName}}    ${seller_name}
    ${txt_status_order_locator}    String.Replace string    ${seller_name_locator}    {{status}}    ${status}
    DobbyAppCommon.Wait until element is visible except stale   ${txt_status_order_locator}

Verify order status in order detail page
    [Arguments]    ${status}
    mobile_common.Wait until loading complete    ${long_timeout}
    DobbyAppCommon.Swipe up
    ${txt_status_locator}    String.Replace string    ${order_detail.txt_status}    {{status}}    ${status}
    DobbyAppCommon.Wait until element is visible except stale       ${txt_status_locator}

Verify ordered date in order detail page
    DobbyAppCommon.Swipe up
    DobbyAppCommon.Wait until element is visible except stale       ${order_detail.txt_order_date}

Verify delivery date in order detail page
    [Arguments]    ${deivery_date}
    DobbyAppCommon.Swipe up
    ${txt_deivery_date_locator}    String.Replace string    ${order_detail.txt_deivery_date}    {{deivery_date}}    ${deivery_date}
    DobbyAppCommon.Wait until element is visible except stale       ${txt_deivery_date_locator}

Verify discount price in order detail page
    [Arguments]     ${discount_price}
    DobbyAppCommon.Swipe down 
    ${text}    DobbyAppCommon.Get text from element when ready    ${order_detail.txt_total_textview}
    Should be equal     ${text}   ${discount_price}

Verify details on order detail page
    [Arguments]    ${seller_name}    ${product_name}    ${quantity}    ${amount}    ${delivery_addr}    ${billing_addr}    ${voucher_name}    ${voucher_price}    ${payment_type}    ${payment_status}
    order_detail_page.Verify seller name  ${seller_name}
    order_detail_page.Verify product name ,quantity and price  ${product_name}  ${quantity}  ${amount}
    order_detail_page.Verify delivery address line1 on order detail page  ${delivery_addr}
    voucher_page.Verify voucher code applied success    ${voucher_name}    ${voucher_price}
    order_detail_page.Verify billing address line1 on order detail page  ${billing_addr}
    order_detail_page.Verify payment type    ${payment_type}     ${payment_status}
    order_detail_page.Tap back button

Verify track delivery button
    FOR    ${i}    IN RANGE    4
        ${element_status}=      Run keyword and return status    DobbyAppCommon.Wait until element is visible except stale      ${order_detail.tacking_delivery}    ${short_timeout}
        Run keyword if  '${element_status}'=='False'     DobbyAppCommon.Swipe up
        Exit for loop iF    '${element_status}'=='True'
    END
    DobbyAppCommon.Tap element when ready    ${order_detail.tacking_delivery}
    ${context_available}    Wait until page have more than 1 context
    Should Contain    ${context_available}    WEBVIEW_chrome    ignore_case=True

Click favourite icon that unfilled on order detail page
    [Arguments]    ${product_name}
    ${favourite_heart_unfilled_icon_locator}    String.Replace string    ${order_detail.favourite_heart_unfilled_icon}    {{product_name}}    ${product_name}
    DobbyAppCommon.Tap element when ready     ${favourite_heart_unfilled_icon_locator}

Click favourite icon that filled on order detail page
    [Arguments]    ${product_name}
    ${favourite_heart_filled_icon_locator}    String.Replace string    ${order_detail.favourite_heart_filled_icon}    {{product_name}}    ${product_name}
    DobbyAppCommon.Tap element when ready     ${favourite_heart_filled_icon_locator}

Verify unable to add product to basket popup
    DobbyAppCommon.Wait until element is visible except stale   ${order_detail.txt_cannot_add_all}

Click ok on popup
    DobbyAppCommon.Tap element when ready     ${order_detail.txt_ok}

Get first and last name from order detail page
    mobile_common.Wait until loading complete    ${long_timeout}
    DobbyAppCommon.Swipe up
    ${text}    DobbyAppCommon.Get text from element when ready    ${order_detail.txt_address_textview}
    [Return]    ${text}

Click add all items to favorite list
    mobile_common.Find element                 ${order_detail.txt_add_all_to_my_list}
    DobbyAppCommon.Tap element when ready     ${order_detail.txt_add_all_to_my_list}

Verify delivery address line1 on order detail page
    [Arguments]     ${address}
    ${txt_address_locator}    String.Replace string    ${order_detail.txt_address}    {{address}}    ${address}
    FOR    ${i}    IN RANGE    4
        ${element_status}=      Run keyword and return status    DobbyAppCommon.Wait until element is visible except stale      ${txt_address_locator}    ${short_timeout}
        Run keyword if  '${element_status}'=='False'     DobbyAppCommon.Swipe up
        Exit for loop iF    '${element_status}'=='True'
    END

Verify billing address line1 on order detail page
    [Arguments]     ${address}
    ${txt_address_locator}    String.Replace string    ${order_detail.txt_address}    {{address}}    ${address}
    FOR    ${i}    IN RANGE    4
        ${element_status}=      Run keyword and return status    DobbyAppCommon.Wait until element is visible except stale      ${txt_address_locator}    ${short_timeout}
        Run keyword if  '${element_status}'=='False'     DobbyAppCommon.Swipe down
        Exit for loop iF    '${element_status}'=='True'
    END

# iOS

Order status in order detail page should be
    [Arguments]     ${status}
    mobile_common.Find element     ${order_detail.txt_order}       Bottom
    ${txt_status_locator}     String.Replace string    ${order_detail.txt_status}    {{status}}    ${status}
    DobbyAppCommon.Wait until element is visible except stale       ${txt_status_locator}

Current order status in timeline should be
    [Arguments]     ${status}
    mobile_common.Find element     ${order_detail.txt_order}       Bottom
    ${txt_status_timeline_locator}     String.Replace string    ${order_detail.txt_status_timeline}    {{status}}    ${status}
    DobbyAppCommon.Wait until element is visible except stale   ${txt_status_timeline_locator}

Order detail in timeline should be
    [Arguments]     ${seller}   ${detail}
    ${txt_seller_order_locator}     String.Replace string    ${order_detail.txt_seller_order}    {{sellerName}}    ${seller}
    FOR     ${i}    IN RANGE    1   21
        ${result}=  Run keyword and return status   mobile_common.Find element       ${txt_seller_order_locator}       Bottom
        Exit for loop if    ${result}
        mobile_common.tap basket menu
        mobile_common.Tap my orders menu
    END
    FOR     ${i}    IN RANGE    1   11
        ${seller_locator}               String.Replace string    ${order_detail.txt_seller_detail}    {{sellerName}}    ${seller}
        ${txt_seller_detail_locator}     String.Replace string    ${seller_locator}    {{detail}}    ${detail}
        ${result}=  Run keyword and return status       DobbyAppCommon.Wait until element is visible except stale       ${txt_seller_detail_locator}
        Exit for loop if    ${result}
        ${get_text}     DobbyAppCommon.Get text from element when ready     chain=**/XCUIElementTypeStaticText[`label CONTAINS "คำสั่งซื้อ #"`]
        ${ordernumber}  Get regexp matches  ${get_text}    \\d{5}
        order_detail_page.Tap back button
        order_history_page.Click on order via using order number    ${ordernumber}
    END
    DobbyAppCommon.Wait until element is visible except stale   ${txt_seller_detail_locator}

Order status should be completed
    DobbyAppCommon.Swipe up
    FOR     ${i}    IN RANGE    0   4
        ${result}=  Run keyword and return status   DobbyAppCommon.Wait until element is visible except stale   ${order_detail.txt_order_success}
        IF  '${result}' == 'False'
            DobbyAppCommon.Swipe up
        END
        Exit for loop if    ${result}
    END
    Should be true  ${result}   msg='order status is not completed'

Order status should be cancelled by
    [Arguments]     ${seller}   
    ${txt_seller_list_product_cancel_locator}               String.Replace string    ${order_detail.txt_seller_list_product_cancel}    {{sellerName}}    ${seller}
    DobbyAppCommon.Wait until element is visible except stale   ${txt_seller_list_product_cancel_locator}

Verify order should be cancelled
    [Arguments]      ${order_no}
    FOR     ${i}    IN RANGE    1   21
        ${result}=  Run keyword and return status   DobbyAppCommon.Wait until element is visible except stale       ${order_detail.txt_list_product_cancel}
        Exit for loop if    ${result}
        order_detail_page.Tap back button
        order_history_page.Tap the first order with order no   ${order_no}
    END

Order status timeline should not be displayed 
    AppiumLibrary.Wait until page does not contain element     ${order_detail.status_timeline}

Verify order number is same as recent order number
    [Arguments]    ${order_number}    ${recent_order_number}
    Should be equal    ${order_number}    ${recent_order_number}

Verify order status format
    [Arguments]    ${status}
    ${status}     String.Get regexp matches    ${status}    (${mobile['order']['label']['closed']}|${mobile['order']['label']['cancelled']}|${mobile['order']['label']['unpaid']}|${mobile['order']['label']['beingPrepared']}|${mobile['order']['label']['shipped']}|${mobile['order']['label']['delivered']})
    ${matches}    Get length    ${status}
    Should be true    ${matches} > 0    msg='order status is not correct'

Verify order total format
    [Arguments]    ${price}
    ${price}      String.Get regexp matches    ${price}    ^${mobile_additional['order']['label']['recent_price']}([0-9,.]+) ฿$
    ${matches}    Get length    ${price}
    Should be true    ${matches} > 0    msg='order price is not correct'

Verify element is display on order card
    [Arguments]    @{elements}
    FOR    ${element}    IN    @{elements}
        AppiumLibrary.Element should be visible    ${element}    timeout=${short_timeout}
    END

Get order detail to list
    [Arguments]    @{order_elements}    ${locator}
    ${orders_list}    Create list
    FOR    ${order_index}    ${order_item}    IN ENUMERATE    @{order_elements}    start=1
        ${order_index}           Convert to string    ${order_index}
        ${order_item_locator}    String.Replace string    ${locator}    {{index}}    ${order_index}
        Collections.Append to list    ${orders_list}    ${order_item_locator}
    END
    [Return]    @{orders_list}

Verify date format is correct
    [Arguments]     ${date}     ${expected_format}
    TRY
        DateTime.Convert date    ${date}    date_format=${expected_format}
        ${is_valid}    Set variable    ${True}
    EXCEPT
        ${is_valid}    Set variable    ${False}
    END
    Should be true    ${is_valid}
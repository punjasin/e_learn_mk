*** Settings ***
Resource        ../../../resources/locators/${platform}/orderhistory_locator.resource
Resource        ../../../resources/locators/${platform}/common_locator.resource
Resource        ../../../common/mobile/mobile_common.resource
Resource        promotion_page.resource

*** Keywords ***
Click the first order in order history
    DobbyAppCommon.Tap element when ready     ${orderhistory.order_section}

Get lastest order number of order history
    ${get_text}  DobbyAppCommon.Get text from element when ready  ${orderhistory.txt_order}
    ${ordernumber}  Get regexp matches  ${get_text}    \\d{7}
    ${current_order}=       Convert to integer      ${ordernumber}[0]
    [Return]       ${current_order}
    
Verify blank order history page
    IF   "${platform}" == "${platform_list['android']}"
        DobbyAppCommon.Wait until element is visible except stale   ${orderhistory.no_order_now}
        DobbyAppCommon.Wait until element is visible except stale   ${orderhistory.txt_see_orders_when_orders}
        DobbyAppCommon.Wait until element is visible except stale   ${orderhistory.txt_search_by_category}
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        DobbyAppCommon.Wait until element is visible except stale     ${orderhistory.title}
        DobbyAppCommon.Wait until element is visible except stale     ${orderhistory.no_order_now}
        DobbyAppCommon.Wait until element is visible except stale     ${orderhistory.txt_see_orders_when_orders}
        DobbyAppCommon.Wait until element is visible except stale     ${orderhistory.txt_search_by_category}
    END

Select order by order id and payment pending
    [Arguments]     ${order_id}    ${total_seller}
    ${total_seller_locator}            String.Replace string    ${orderhistory.txt_sent_by_order_id}    {{total_seller}}    ${total_seller}
    ${txt_sent_by_order_id_locator}    String.Replace string    ${total_seller_locator}    {{order_id}}    ${order_id}
    DobbyAppCommon.Tap element when ready    ${txt_sent_by_order_id_locator}
    
Order status should be cancelled by
    [Arguments]     ${order_number}  ${seller_name}
    ${order_number_locator}              String.Replace string    ${orderhistory.order_cancel_by_seller}    {{order_id}}    ${order_number}
    ${order_cancel_by_seller_locator}    String.Replace string    ${order_number_locator}    {{seller_name}}    ${seller_name}
    IF   "${platform}" == "${platform_list['android']}"
        FOR     ${i}    IN RANGE    1   21
            ${result}=  Run keyword and return status   DobbyAppCommon.Wait until element is visible except stale  ${order_cancel_by_seller_locator}    timeout=30s
            Exit for loop if    ${result}
            mobile_common.tap basket menu
            mobile_common.Tap my orders menu
        END
        Should be true  ${result}   msg='[status is not display within 10 mins'
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        ${element_to_find}=     Set variable    คำสั่งซื้อ${SPACE}\#${order_number}${SPACE}\/${SPACE}${seller_name}
        FOR     ${i}    IN RANGE    1   21
            ${result}=  Run keyword and return status   DobbyAppCommon.Wait until element is visible except stale       ${order_cancel_by_seller_locator}
            Exit for loop if    ${result}
            mobile_common.tap basket menu
            mobile_common.Tap my orders menu
        END
        Should be true  ${result}   msg='order was not marked as cancelled within 10 mins'  
    END

Click on tracking button
    [Arguments]    ${order_number}
    ${txt_tracking_delivery_locator}              String.Replace string    ${orderhistory.txt_tracking_delivery}    {{order_number}}    ${order_number}
    DobbyAppCommon.Tap element when ready       ${txt_tracking_delivery_locator}
    
Order should be marked as cancelled
    [Arguments]     ${order_number}
    ${order_canceled_locator}              String.Replace string    ${orderhistory.order_canceled}    {{order_number}}    ${order_number}
    IF   "${platform}" == "${platform_list['android']}"
        DobbyAppCommon.Wait until element is visible except stale     ${order_canceled_locator}
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        FOR     ${i}    IN RANGE    1   21
            ${result}=  Run keyword and return status   DobbyAppCommon.Wait until element is visible except stale  ${order_canceled_locator}
            Exit for loop if    ${result}
            mobile_common.tap basket menu
            mobile_common.Tap my orders menu
        END    
    END

Tap all status
    IF   "${platform}" == "${platform_list['android']}"
        DobbyAppCommon.Wait until element is visible except stale     ${orderhistory.order}
        DobbyAppCommon.Tap element when ready                         ${orderhistory.txt_total}
        mobile_common.Wait until loading complete
        DobbyAppCommon.Wait until element is visible except stale     ${orderhistory.txt_total}
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        DobbyAppCommon.Wait until element is visible except stale     ${orderhistory.txt_order_last}
        mobile_common.Swipe left to right                              ${orderhistory.txt_total_scrollview}
        DobbyAppCommon.Tap element when ready                                 ${orderhistory.txt_total}
        mobile_common.Page should not contain loading spinner
        DobbyAppCommon.Wait until element is visible except stale     ${orderhistory.txt_total_typeother}
    END

Tap unpaid status
    IF   "${platform}" == "${platform_list['android']}"
        DobbyAppCommon.Tap element when ready                         ${orderhistory.txt_must_pay}
        mobile_common.Wait until loading complete        
        DobbyAppCommon.Wait until element is visible except stale     ${orderhistory.txt_must_pay}
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        DobbyAppCommon.Wait until element is visible except stale     ${orderhistory.txt_order_last}
        mobile_common.Swipe left to right                            ${orderhistory.txt_total_scrollview}
        DobbyAppCommon.Tap element when ready                                 ${orderhistory.txt_must_pay}
        mobile_common.Page should not contain loading spinner        
        DobbyAppCommon.Wait until element is visible except stale     ${orderhistory.txt_must_pay_typeother} 
    END

Tap being prepared status
    IF   "${platform}" == "${platform_list['android']}"
        DobbyAppCommon.Wait until element is visible except stale     ${orderhistory.order}
        DobbyAppCommon.Tap element when ready                         ${orderhistory.txt_must_pay}
        mobile_common.Wait until loading complete       
        DobbyAppCommon.Wait until element is visible except stale     ${orderhistory.txt_must_pay}
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        DobbyAppCommon.Wait until element is visible except stale     ${orderhistory.txt_order_last}
        mobile_common.Swipe left to right                            ${orderhistory.txt_total_scrollview}
        DobbyAppCommon.Tap element when ready                                 ${orderhistory.txt_prepare}
        mobile_common.Page should not contain loading spinner        
        DobbyAppCommon.Wait until element is visible except stale     ${orderhistory.txt_prepare_typeother} 
    END

Tap shipped status
    IF   "${platform}" == "${platform_list['android']}"
        DobbyAppCommon.Wait until element is visible except stale     ${orderhistory.order}
        DobbyAppCommon.Tap element when ready                         ${orderhistory.txt_delivery}
        mobile_common.Wait until loading complete      
        DobbyAppCommon.Wait until element is visible except stale     ${orderhistory.txt_delivery}  
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        DobbyAppCommon.Wait until element is visible except stale     ${orderhistory.txt_order_last}
        mobile_common.Swipe right to left                            ${orderhistory.txt_total_scrollview}
        DobbyAppCommon.Tap element when ready                                 ${orderhistory.txt_delivery}
        mobile_common.Page should not contain loading spinner        
        DobbyAppCommon.Wait until element is visible except stale     ${orderhistory.txt_delivery_typeother}   
    END

Tap delivered status
    IF   "${platform}" == "${platform_list['android']}"
        DobbyAppCommon.Wait until element is visible except stale     ${orderhistory.order}
        DobbyAppCommon.Tap element when ready                         ${orderhistory.txt_delivered_success}
        mobile_common.Wait until loading complete      
        DobbyAppCommon.Wait until element is visible except stale     ${orderhistory.txt_delivered_success} 
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        DobbyAppCommon.Wait until element is visible except stale     ${orderhistory.txt_order_last}
        mobile_common.Swipe right to left                            ${orderhistory.txt_total_scrollview}
        DobbyAppCommon.Tap element when ready                                 ${orderhistory.txt_delivered_success}
        mobile_common.Page should not contain loading spinner        
        DobbyAppCommon.Wait until element is visible except stale     ${orderhistory.txt_delivered_success_typeother} 
    END

Tap cancelled status
    IF   "${platform}" == "${platform_list['android']}"
        DobbyAppCommon.Wait until element is visible except stale     ${orderhistory.order}
        DobbyAppCommon.Tap element when ready                         ${orderhistory.txt_cancel}
        mobile_common.Wait until loading complete       
        DobbyAppCommon.Wait until element is visible except stale     ${orderhistory.txt_cancel}
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        DobbyAppCommon.Wait until element is visible except stale     ${orderhistory.txt_order_last}
        mobile_common.Swipe right to left                            ${orderhistory.txt_total_scrollview}
        DobbyAppCommon.Tap element when ready                                 ${orderhistory.txt_cancel}
        mobile_common.Page should not contain loading spinner        
        DobbyAppCommon.Wait until element is visible except stale     ${orderhistory.txt_cancel_typeother}
    END

Page should contain this order 
    [Arguments]     ${orderno} 
    ${currentorderno}=     order_history_page.Get lastest order number of order history
    Should be equal        ${orderno}   ${currentorderno}
    
Page should not contain this order 
    [Arguments]     ${orderno}
    AppiumLibrary.Wait until page does not contain element        id=คำสั่งซื้อ #${orderno}

Order status in order history should be 
    [Arguments]     ${order_id}     ${seller_name}    ${order_status}
    ${order_id_locator}            String.Replace string    ${orderhistory.order_card_status}    {{order_id}}    ${order_id}
    ${seller_name_locator}            String.Replace string    ${order_id_locator}    {{seller_name}}    ${seller_name}
    ${order_card_status_locator}            String.Replace string    ${seller_name_locator}    {{order_status}}    ${order_status}
    IF   "${platform}" == "${platform_list['android']}"
        FOR     ${i}    IN RANGE    1   21
            ${result}=  Run keyword and return status   DobbyAppCommon.Wait until element is visible except stale  ${order_card_status_locator}
            Exit for loop if    ${result}
            mobile_common.tap basket menu
            mobile_common.Tap my orders menu
        END
        Should be true  ${result}   msg='[${order_status}] is not display within 10 mins'
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        FOR     ${i}    IN RANGE    1   21
            ${result}=  Run keyword and return status   DobbyAppCommon.Wait until element is visible except stale  ${order_card_status_locator}
            Exit for loop if    ${result}
            mobile_common.tap basket menu
            mobile_common.Tap my orders menu
        END
        Should be true  ${result}   msg='[${order_status}] is not display within 10 mins'
    END

Click on order via using order number
    [Documentation]     For voucher test case just to verify order detail
    [Arguments]     ${order_number}
    ${order_card_details_locator}            String.Replace string    ${orderhistory.order_card_details}    {{order_number}}    ${order_number}
    IF   "${platform}" == "${platform_list['android']}"
        FOR    ${i}    IN RANGE    1    11
            ${status}       Run keyword and return status    DobbyAppCommon.Wait until element is visible except stale    ${order_card_details_locator}    ${short_timeout}
            IF    '${status}'=='False'
                mobile_common.tap basket menu
                mobile_common.Tap my orders menu
            END    
            Exit for loop if  '${status}'=='True'    
        END
        DobbyAppCommon.Tap element when ready       ${order_card_details_locator}
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        FOR    ${i}    IN RANGE    1    11
            ${status}       Run keyword and return status    DobbyAppCommon.Wait until element is visible except stale    ${order_card_details_locator}    ${short_timeout}
            IF    '${status}'=='False'
                mobile_common.tap basket menu
                mobile_common.Tap my orders menu
            END    
            Exit for loop if  '${status}'=='True'    
        END
        DobbyAppCommon.Tap element when ready       ${order_card_details_locator}
    END

Verify my orders list page not login
    DobbyAppCommon.Wait until element is visible except stale    ${orderhistory.orderhistory_page_not_login}
    DobbyAppCommon.Wait until element is visible except stale    ${orderhistory.login_account_btn}
    DobbyAppCommon.Wait until element is visible except stale    ${orderhistory.create_account_btn}

Tap register button
    DobbyAppCommon.Tap element when ready    ${orderhistory.create_account_btn}

Verify orderhistory page not have order
    DobbyAppCommon.Wait until element is visible except stale    ${orderhistory.orderhistory_page_empty}
    DobbyAppCommon.Wait until element is visible except stale    ${orderhistory.txt_search_by_category}

# Android

Verify order should be cancelled
    FOR     ${i}    IN RANGE    1   3
        mobile_common.Tap my orders menu
        DobbyAppCommon.Wait until element is visible except stale   ${orderhistory.txt_cancel}
        Page Should Contain Element     ${orderhistory.txt_cancel}
    END

Check order unpaid bank transfer status
    [Arguments]     ${order_number}
    ${txt_pay_within_locator}            String.Replace string    ${orderhistory.txt_pay_within}    {{order_number}}    ${order_number}
    DobbyAppCommon.Wait until element is visible except stale       ${txt_pay_within_locator}
    #Global variable    ${order_created_time} from checkout_2c2p_page.Tap back to merchant     #not ready
    ${time_expire} =        Add Time To Date  ${order_created_time}  4 hours      result_format=%H:%M  
    ${time_offset} =        Add Time To Date  ${order_created_time}  3 hours 59 minutes      result_format=%H:%M 
    ${time_offset2} =       Add Time To Date  ${order_created_time}  4 hours 1 minutes      result_format=%H:%M 
    # Check 4 hours and offset time
    ${order_number_locator}             String.Replace string    ${orderhistory.txt_time_expire}    {{order_number}}    ${order_number}
    ${txt_time_expire_locator}          String.Replace string    ${order_number_locator}    {{time_expire}}    ${time_expire}
    ${txt_time_offset_locator}          String.Replace string    ${order_number_locator}    {{time_expire}}    ${time_offset}
    ${txt_time_offset2_locator}         String.Replace string    ${order_number_locator}    {{time_expire}}    ${time_offset2}
    ${element_status}=      Run keyword and return status    DobbyAppCommon.Wait until element is visible except stale       ${txt_time_expire_locator}       timeout=30s
    ${element_status2}=     Run keyword and return status    DobbyAppCommon.Wait until element is visible except stale       ${txt_time_offset_locator}       timeout=10s
    ${element_status3}=     Run keyword and return status    DobbyAppCommon.Wait until element is visible except stale       ${txt_time_offset2_locator}      timeout=10s
    Run keyword if  '${element_status}'=='False' and '${element_status2}'=='False' and '${element_status3}'=='False'     AppiumLibrary.Capture Page Screenshot
    Run keyword if  '${element_status}'=='False' and '${element_status2}'=='False' and '${element_status3}'=='False'     Fail   Expire time is not 4 hours   

Wait for 2c2p to sync
    Sleep   5s

Select first order that has seller name as
    [Arguments]     ${seller_name}
    ${txt_order_section_locator}            String.Replace string    ${orderhistory.txt_order_section}    {{seller_name}}    ${seller_name}
    DobbyAppCommon.Swipe up
    DobbyAppCommon.Tap element when ready   ${txt_order_section_locator}

Select order by order id and seller name
    [Arguments]     ${order_id}    ${seller_name}
    ${seller_name_locator}            String.Replace string    ${orderhistory.txt_order_id}    {{seller_name}}    ${seller_name}
    ${txt_order_id_locator}            String.Replace string    ${seller_name_locator}    {{order_id}}    ${order_id}
    FOR     ${i}    IN RANGE    1   21
        ${result}=  Run keyword and return status   DobbyAppCommon.Wait until element is visible except stale    ${txt_order_id_locator}    timeout=10s
        Exit for loop if    ${result}
        mobile_common.tap basket menu
        mobile_common.Tap my orders menu
    END
    DobbyAppCommon.Tap element when ready    ${txt_order_id_locator}

Page should show time order unpaid bank transfer status 
    [Arguments]   ${time}
    DobbyAppCommon.Wait until element is visible except stale       ${orderhistory.pay_within}
    ${time_expire} =        Add time to date  ${time}  4 hours                date_format=%H:%M  result_format=%H:%M  
    ${time_offset} =        Add time to date  ${time}  3 hours 59 minutes     date_format=%H:%M  result_format=%H:%M
    ${time_offset2} =       Add time to Date  ${time}  4 hours 1 minutes      date_format=%H:%M  result_format=%H:%M 
    ${time_expire_locator}          String.Replace string    ${orderhistory.time_expire}    {{time_expire}}    ${time_expire}
    ${time_offset_locator}          String.Replace string    ${orderhistory.time_expire}    {{time_expire}}    ${time_offset}
    ${time_offset2_locator}         String.Replace string    ${orderhistory.time_expire}    {{time_expire}}    ${time_offset2}

    ${element_status}=      Run keyword and return status    DobbyAppCommon.Wait until element is visible except stale       ${time_expire_locator}      timeout=30s
    ${element_status2}=     Run keyword and return status    DobbyAppCommon.Wait until element is visible except stale       ${time_offset_locator}       timeout=10s
    ${element_status3}=     Run keyword and return status    DobbyAppCommon.Wait until element is visible except stale       ${time_offset2_locator}      timeout=10s
    Run keyword if  '${element_status}'=='False' and '${element_status2}'=='False' and '${element_status3}'=='False'     Capture Page Screenshot
    Run keyword if  '${element_status}'=='False' and '${element_status2}'=='False' and '${element_status3}'=='False'     Fail   Expire time is not 4 hours 

Order status in timeline should be
    [Arguments]     ${order_id}    ${seller_name}  ${order_status}
    FOR     ${i}    IN RANGE    1   21
        Sleep    2s    #wait for animation
        ${order_id_locator}          String.Replace string    ${orderhistory.txt_status_order_id}    {{order_id}}    ${order_id}
        ${seller_name_locator}       String.Replace string    ${order_id_locator}    {{seller_name}}    ${seller_name}
        ${txt_status_order_id_locator}      String.Replace string    ${seller_name_locator}    {{order_status}}    ${order_status}
        ${result}=  Run keyword and return status   DobbyAppCommon.Wait until element is visible except stale    ${txt_status_order_id_locator}       timeout=10s
        Exit for loop if    ${result}
        mobile_common.tap basket menu
        mobile_common.Tap my orders menu
    END
    Should be true  ${result}   msg='[${order_status}] is not display within 10 mins'

Order status should be cancelled
    FOR     ${i}    IN RANGE    1   21
        ${result}=  Run keyword and return status   DobbyAppCommon.Wait until element is visible except stale    ${orderhistory.txt_cancel_1}    timeout=30s
        Exit for loop if    ${result}
        mobile_common.tap basket menu
        mobile_common.Tap my orders menu
    END
    Should be true  ${result}   msg='[status is not display within 10 mins'

Order status should be completed by seller
    [Arguments]     ${order_number}  ${seller_name}
    ${order_number_locator}                         String.Replace string    ${orderhistory.txt_order_delivered_success}    {{order_number}}    ${order_number}
    ${txt_order_delivered_success_locator}          String.Replace string    ${order_number_locator}    {{seller_name}}    ${seller_name}
    FOR     ${i}    IN RANGE    1   21
        ${result}=  Run keyword and return status   DobbyAppCommon.Wait until element is visible except stale    ${txt_order_delivered_success_locator}    timeout=30s

        Exit for loop if    ${result}
        mobile_common.tap basket menu
        mobile_common.Tap my orders menu
    END
    Should be true  ${result}   msg='[status is not display within 10 mins]'

Order status should be completed by
    [Arguments]     ${order_number}
    ${txt_order_success_locator}         String.Replace string    ${orderhistory.txt_order_success}    {{order_number}}    ${order_number}
    FOR     ${i}    IN RANGE    1   21
        ${result}=  Run keyword and return status   DobbyAppCommon.Wait until element is visible except stale    ${txt_order_success_locator}    timeout=30s
        Exit for loop if    ${result}
        mobile_common.tap basket menu
        mobile_common.Tap my orders menu
    END
    Should be true  ${result}   msg='[status is not display within 10 mins'

Tap the first order with status bank transfer unpaid
    DobbyAppCommon.Tap element when ready  ${orderhistory.pay_within}

Get date time order paid bank transfer status
    ${get_text}  DobbyAppCommon.Get text from element when ready  ${orderhistory.time_expire_1}
    ${date}  Get Regexp Matches  ${get_text}   \\d{2} [ก-โ]{1}.[ก-โ]{1}. \\d{2}:\\d{2}
    ${date}=      Split String        ${date}[0]     ${SPACE}
    [Return]   ${date}[0]   ${date}[1]   ${date}[2]

Get order accepted notification title from order number
    [Arguments]     ${order_number}
    ${str_number}=  Convert to string   ${order_number}
    ${title}=   Replace string  ${push_notification['order_accept_title']}  _ORDER_NUMBER_  ${str_number}
    [Return]    ${title.strip()}

Get order cancelled notification title from order number
    [Arguments]     ${order_number}  ${seller_name}
    ${str_number}=  Convert to string   ${order_number}
    ${str_seller}=  Convert to string   ${seller_name}
    ${title}=   Replace string  ${push_notification['order_cancle_title']}  _ORDER_NUMBER_  ${str_number}
    ${title}=   Replace string  ${title}  _SELLER_NAME_  ${str_seller}
    [Return]    ${title.strip()}

Get order shipped notification title from order number
    [Arguments]     ${order_number}
    ${str_number}=  Convert to string   ${order_number}
    ${title}=   Replace string  ${push_notification['order_shipped_title']}  _ORDER_NUMBER_  ${str_number}
    [Return]    ${title.strip()}

Get order attemp delivery notification body from order number
    [Arguments]     ${order_number}
    ${str_number}=  Convert to string   ${order_number}
    ${title}=   Replace string  ${push_notification['order_attemped_delivery_body']}  _ORDER_NUMBER_  ${str_number}
    [Return]    ${title.strip()}

Get order expired notification title from order number
    [Arguments]     ${order_number}
    ${str_number}=  Convert to string   ${order_number}
    ${title}=   Replace string  ${push_notification['order_expired_title']}  _ORDER_NUMBER_  ${str_number}
    [Return]    ${title.strip()}

Verify seller name of target number correct
    [Arguments]     ${order_number}    ${seller_name}
    ${order_number}                      Convert to string        ${order_number}
    ${order_number_locator}              String.Replace string    ${orderhistory.order_card_seller}    {{order_id}}    ${order_number}
    ${order_card_seller_locator}         String.Replace string    ${order_number_locator}    {{seller_name}}    ${seller_name}
    DobbyAppCommon.Wait until element is visible except stale     ${order_card_seller_locator}

Verify order status
    [Arguments]      ${order_id}   ${tab_name}    @{seller_name}
    FOR    ${name}    IN    @{seller_name}
        order_history_page.verify order status and seller name    ${order_id}   ${name}  ${tab_name}
    END
    
Swipe to the tab in my orders
    [Arguments]      ${tab_name}  
    ${txt_tab_name_locator}              String.Replace string    ${orderhistory.txt_tab_name}    {{tab_name}}    ${tab_name}
    order_history_page.Refresh order history list
    FOR    ${i}    IN    ${mobile['order']['tab']}
        ${found_status}      Run keyword and return status    DobbyAppCommon.Wait until element is visible except stale    ${txt_tab_name_locator}    ${short_timeout}
        IF    '${found_status}' == "True"    BREAK
        mobile_common.Swipe left to right                  ${orderhistory.side_bar}
    END
    DobbyAppCommon.Tap element when ready       ${txt_tab_name_locator} 

Verify current tab is target status
    [Arguments]     ${tab_name}
    ${txt_tab_name_locator}              String.Replace string    ${orderhistory.txt_current_tab_name}    {{tab_name}}    ${tab_name}
    DobbyAppCommon.Wait until element is visible except stale    ${txt_tab_name_locator}    ${short_timeout}

verify order status and seller name 
    [Arguments]     ${order_id}   ${seller_name}   ${tab_name}
    Wait until loading complete   ${long_timeout}
    order_history_page.Order status in order history should be    ${order_id}    ${seller_name}    ${tab_name}
    ${element_size}    mobile_common.Get Order Element Size    ${orderhistory.order_card}
    ${txt_order_id_1_locator}     String.Replace string    ${orderhistory.txt_order_id_1}    {{order_id}}    ${order_id}
    ${txt_tab_name_1_locator}     String.Replace string    ${orderhistory.txt_tab_name_1}    {{tab_name}}    ${tab_name}
    ${order_status}     Run Keyword And Return Status    DobbyAppCommon.Wait until element is visible except stale      ${txt_order_id_1_locator}
    IF  '${order_status}'=='True'
         ${order_status}  DobbyAppCommon.Get text from element when ready  ${txt_tab_name_1_locator}
         Should be equal     ${order_status}    ${tab_name}
         ${get_seller_name}  DobbyAppCommon.Get text from element when ready    ${orderhistory.order_card_seller_1} 
         Should be equal     ${get_seller_name}    ${seller_name}
    END
    order_history_page.Swipe one order card using element size of order card   ${orderhistory.order_card}    ${element_size}

Swipe one order card using element size of order card
    [Arguments]    ${locator}    ${element_size}
    ${element_location}=    Get Element Location    ${locator}
    ${start_x}=         Evaluate      ${element_location['x']} + (${element_size['width']} * 0.5)
    ${start_y}=         Evaluate      ${element_location['y']} + (${element_size['height']} * 1.0)
    ${end_x}=           Evaluate      ${element_location['x']} + (${element_size['width']} * 0.5)
    ${end_y}=           Evaluate      ${element_location['y']} - (${element_size['height']} * 0.0)
    Swipe               ${start_x}    ${start_y}  ${end_x}  ${end_y}  500
    Sleep  1

Get latest order number
    mobile_common.Tap my orders menu
    mobile_common.Wait until loading complete    ${long_timeout}
    ${order_id}     order_history_page.Get lastest order number of order history
    [Return]    ${order_id}

Get total price of same order id   
    [Arguments]     ${order_id}
    Wait until loading complete    ${long_timeout}
    ${element_size}    mobile_common.Get Order Element Size    ${orderhistory.order_card}
    ${total_amount}     Set variable    0
    ${txt_order_id_locator}     String.Replace string    ${orderhistory.txt_order_id}    {{order_id}}    ${order_id}
    ${txt_order_id_textview_locator}     String.Replace string    ${orderhistory.txt_order_id_textview}    {{order_id}}    ${order_id}
    FOR    ${i}    IN RANGE    1    9 
        ${order_status}     Run Keyword And Return Status    DobbyAppCommon.Wait until element is visible except stale      ${txt_order_id_locator}
         IF  '${order_status}'=='True'
            ${order_price}    DobbyAppCommon.Get text from element when ready    ${txt_order_id_textview_locator}
            ${price_cut}=   Fetch From Left    ${order_price}  ${SPACE}
            ${price_cut}=  Replace String  ${price_cut}  ,  ${EMPTY}
            ${price_cut}=  Convert To Number  ${price_cut}  
            ${total_amount}=    Evaluate    ${total_amount}+${price_cut}
            order_history_page.Swipe one order card using element size of order card    ${orderhistory.order_card}    ${element_size}
         ELSE
            Exit for loop if    '${order_status}'=='False'
         END
    END
    [Return]    ${total_amount}

Verify total amount on latest order should be equal
    [Arguments]     ${total_amount}
    ${order_id}     order_history_page.Get latest order number
    ${total_amount_show}     order_history_page.Get total price of same order id     ${order_id} 
    Should be equal     ${total_amount_show}    ${total_amount}     

Verify underline highlight on selected tab
    [Arguments]    @{tabs_name}
    FOR    ${name}    IN    @{tabs_name}
        order_history_page.Swipe to the tab in my orders    ${name}
        ${txt_top_tab_bar_tab_name_locator}     String.Replace string    ${orderhistory.txt_top_tab_bar_tab_name}    {{name}}    ${name}
        DobbyAppCommon.Wait until element is visible except stale     ${txt_top_tab_bar_tab_name_locator}
    END
Verify order thumbnail it shows first five products and then shows plus 5
    [Arguments]     ${order_id}   
    Wait until loading complete   ${long_timeout}
    ${element_size}    Get Order Element Size    ${orderhistory.order_card}
    ${txt_order_id_1_locator}     String.Replace string    ${orderhistory.txt_order_id_1}    {{order_id}}    ${order_id}
    ${order_status}     Run Keyword And Return Status    DobbyAppCommon.Wait until element is visible except stale      ${txt_order_id_1_locator}
    IF  '${order_status}'=='True'
        ${count}    Get Matching Xpath Count   ${orderhistory.order_card_order_card_product_thumbnail}
        Should be equal     ${count}    ${5} 
        ${Tumbnail_text}    DobbyAppCommon.Get text from element when ready    ${orderhistory.order_card_unvisible_thumbnails_amount}
        Should be equal     ${Tumbnail_text}    + 5
    END
    order_history_page.Swipe one order card using element size of order card   ${orderhistory.order_card}    ${element_size}
Get the ordercard count
    [Arguments]    ${order_id} 
    ${order_id_list_locator}     String.Replace string    ${orderhistory.order_id_list}    {{order_id}}    ${order_id}
    ${count}    Get Matching Xpath Count     ${order_id_list_locator}
    [Return]    ${count}

Verify order won't split when status is unpaid 
    [Arguments]     ${order_id}   
    ${txt_order_id_1_locator}     String.Replace string    ${orderhistory.txt_order_id_1}    {{order_id}}    ${order_id}
    ${order_status_show}     Run Keyword And Return Status    DobbyAppCommon.Wait until element is visible except stale      ${txt_order_id_1_locator}
    IF  '${order_status_show}'=='${true}'  
         ${order_status_show}  DobbyAppCommon.Get text from element when ready     ${orderhistory.order_card_status_1}
         Should be equal as strings     ${order_status_show}   ${orderoverview_tab['Unpaid']}
    END     
    ${count}   Get the ordercard count      ${order_id}
    Should be equal as strings      ${count}    ${1}

Verify the order splitted into fulfillment order
    [Arguments]     ${order_id}   @{seller_name}
    ${txt_order_id_1_locator}     String.Replace string    ${orderhistory.txt_order_id_1}    {{order_id}}    ${order_id}
    ${order_status_show}     Run Keyword And Return Status    DobbyAppCommon.Wait until element is visible except stale      ${txt_order_id_1_locator}
    IF  '${order_status_show}'=='${true}'  
         ${count}   Get the ordercard count      ${order_id}
         Should be True      ${count}   > ${1}
         ${order_status_show}  DobbyAppCommon.Get text from element when ready   ${orderhistory.order_card_status_1}
         Should be equal     ${order_status_show}   ${orderoverview_tab['Being_prepared']}
         FOR     ${s_name}  IN  @{seller_name}
         verify order status and seller name    ${order_id}   ${s_name}  ${order_status_show}    
         END            
    END     

Click on browse categories on my order page
    DobbyAppCommon.Tap element when ready    ${orderhistory.browse_categories_button}

Verify blank order history page and verify navigation to shopping page
    [Arguments]    @{tabs_name}
    FOR    ${name}    IN    @{tabs_name}
        mobile_common.Tap my orders menu
        order_history_page.Swipe to the tab in my orders    ${name}
        order_history_page.Verify blank order history page
        order_history_page.Click on browse categories on my order page
        promotion_page.Verify promotion section display
    END

Verify amount on order card
    [Arguments]    ${order_no}    ${amount}
    ${order_no}               Convert to string        ${order_no}
    ${amount}                 Convert to string        ${amount}
    ${order_no_locator}       String.Replace string    ${orderhistory.txt_amount}    {{order_no}}    ${order_no}
    ${txt_amount_locator}     String.Replace string    ${order_no_locator}    {{amount}}    ${amount}
    DobbyAppCommon.Wait until element is visible except stale    ${txt_amount_locator}

Verify delivery date on order card
    [Arguments]    ${order_no}    ${delivery_date}
    ${order_no_locator}              String.Replace string    ${orderhistory.txt_delivery_date}    {{order_no}}    ${order_no}
    ${txt_delivery_date_locator}     String.Replace string    ${order_no_locator}    {{delivery_date}}    ${delivery_date}
    DobbyAppCommon.Wait until element is visible except stale    ${txt_delivery_date_locator}

Verify order card details
    [Arguments]    ${order_id}     ${seller_name}    ${name}    ${delivery_date}    ${amount}
    mobile_common.tap basket menu
    mobile_common.Tap my orders menu
    order_history_page.Swipe to the tab in my orders    ${name}
    order_history_page.Order status in order history should be    ${order_id}     ${seller_name}    ${name}
    order_history_page.Verify delivery date on order card  ${order_id}  ${delivery_date}
    order_history_page.Verify amount on order card  ${order_id}  ${amount}

Swipe to the tab in my orders and verify order status
    [Arguments]    ${order_id}    ${seller_name}    ${tab_name}
    order_history_page.Swipe to the tab in my orders    ${tab_name}
    order_history_page.Order status in order history should be    ${order_id}    ${seller_name}    ${tab_name}

Get seller name with count
    [Arguments]    @{seller_name}
    ${cnt}=    Get Length    ${seller_name}
    ${str1}=    Convert To String    ${cnt}
    ${str}=    String.Replace string      ${order['label']['fulfilledBySellers']}  {{sellersAmount}}   ${str1}      
    [Return]    ${str}

# iOS

Tap the first order with order no
    [Arguments]    ${order_no}
    ${txt_order_no_locator}     String.Replace string    ${orderhistory.txt_order_no}    {{order_no}}    ${order_no}
    DobbyAppCommon.Tap element when ready  ${txt_order_no_locator}

Order status ios should be completed by
    [Arguments]     ${order_number}   ${seller_name}
    ${order_number_locator}       String.Replace string    ${orderhistory.txt_order_success}    {{order_number}}    ${order_number}
    ${txt_order_success_locator}     String.Replace string    ${order_number_locator}    {{seller_name}}    ${seller_name}
    FOR     ${i}    IN RANGE    1   21
        ${result}=  Run keyword and return status   DobbyAppCommon.Wait until element is visible except stale       ${txt_order_success_locator}
        Exit for loop if    ${result}
        mobile_common.tap basket menu
        mobile_common.Tap my orders menu
    END
    Should be true  ${result}   msg='order was not marked as completed within 10 mins'

Click on order using order number and seller name
    [Arguments]  ${order_number}    ${seller_name}
    ${order_number_locator}       String.Replace string    ${orderhistory.order_number}    {{order_number}}    ${order_number}
    ${order_number_seller_locator}     String.Replace string    ${order_number_locator}    {{seller_name}}    ${seller_name}
    DobbyAppCommon.Tap element when ready       ${order_number_seller_locator}

Tap at order number
	[Arguments]    ${order_number}
    ${order_number_str}   Convert to string   ${order_number}
    ${txt_order_number_locator}       String.Replace string    ${orderhistory.txt_order_number}    {{orderId}}    \#${order_number_str}
	DobbyAppCommon.Tap element when ready       ${txt_order_number_locator}

Unpaid order will be cancelled message should be displayed 
    [Arguments]     ${order_number}
    ${txt_unpaid_locator}       String.Replace string    ${orderhistory.txt_unpaid}    {{order_number}}    ${order_number}
    DobbyAppCommon.Wait until element is visible except stale      ${txt_unpaid_locator}

Verify red highlight when select all tab
    DobbyAppCommon.Wait until element is visible except stale     ${orderhistory.txt_order_last}
    DobbyAppCommon.Wait until element is visible except stale     ${orderhistory.txt_total}
    DobbyAppCommon.Wait until element is visible except stale     ${orderhistory.total_selected_underline}
    AppiumLibrary.Wait until page does not contain element       ${orderhistory.txt_must_pay_selected_underline}
    AppiumLibrary.Wait until page does not contain element       ${orderhistory.txt_prepare_selected_underline}
    AppiumLibrary.Wait until page does not contain element       ${orderhistory.txt_delivery_selected_underline}
    AppiumLibrary.Wait until page does not contain element       ${orderhistory.txt_delivered_success_selected_underline}
    AppiumLibrary.Wait until page does not contain element       ${orderhistory.txt_canceled_selected_underline}

Verify red highlight when select unpaid tab
    DobbyAppCommon.Wait until element is visible except stale     ${orderhistory.txt_order_last}
    DobbyAppCommon.Tap element when ready                                 ${orderhistory.txt_must_pay}
    mobile_common.Page should not contain loading spinner
    DobbyAppCommon.Wait until element is visible except stale     ${orderhistory.txt_must_pay_selected_underline} 
    AppiumLibrary.Wait until page does not contain element       ${orderhistory.total_selected_underline}
    AppiumLibrary.Wait until page does not contain element       ${orderhistory.txt_prepare_selected_underline}
    AppiumLibrary.Wait until page does not contain element       ${orderhistory.txt_delivery_selected_underline}
    AppiumLibrary.Wait until page does not contain element       ${orderhistory.txt_delivered_success_selected_underline}
    AppiumLibrary.Wait until page does not contain element       ${orderhistory.txt_canceled_selected_underline}

Verify red highlight when select being prepared tab
    DobbyAppCommon.Wait until element is visible except stale     ${orderhistory.txt_order_last}
    DobbyAppCommon.Tap element when ready                                 ${orderhistory.txt_prepare}
    mobile_common.Page should not contain loading spinner
    DobbyAppCommon.Wait until element is visible except stale     ${orderhistory.txt_prepare_selected_underline}
    AppiumLibrary.Wait until page does not contain element       ${orderhistory.total_selected_underline}
    AppiumLibrary.Wait until page does not contain element       ${orderhistory.txt_must_pay_selected_underline}
    AppiumLibrary.Wait until page does not contain element       ${orderhistory.txt_delivery_selected_underline}
    AppiumLibrary.Wait until page does not contain element       ${orderhistory.txt_delivered_success_selected_underline}
    AppiumLibrary.Wait until page does not contain element       ${orderhistory.txt_canceled_selected_underline}

Verify red highlight when select shipped tab
    DobbyAppCommon.Wait until element is visible except stale           ${orderhistory.txt_order_last}
    mobile_common.Swipe right to left                                  ${orderhistory.txt_total_scrollview}
    DobbyAppCommon.Tap element when ready                                       ${orderhistory.txt_delivery}
    mobile_common.Page should not contain loading spinner
    DobbyAppCommon.Wait until element is visible except stale          ${orderhistory.txt_delivery_selected_underline}
    AppiumLibrary.Wait until page does not contain element      ${orderhistory.total_selected_underline}
    AppiumLibrary.Wait until page does not contain element      ${orderhistory.txt_must_pay_selected_underline}
    AppiumLibrary.Wait until page does not contain element      ${orderhistory.txt_prepare_selected_underline}
    AppiumLibrary.Wait until page does not contain element      ${orderhistory.txt_delivered_success_selected_underline}
    AppiumLibrary.Wait until page does not contain element      ${orderhistory.txt_canceled_selected_underline}

Verify red highlight when select delivered tab
    DobbyAppCommon.Wait until element is visible except stale       ${orderhistory.txt_order_last}
    mobile_common.Swipe right to left                              ${orderhistory.txt_total_scrollview}
    DobbyAppCommon.Tap element when ready                                   ${orderhistory.txt_delivered_success}
    mobile_common.Page should not contain loading spinner
    DobbyAppCommon.Wait until element is visible except stale       ${orderhistory.txt_delivered_success_selected_underline}
    AppiumLibrary.Wait until page does not contain element         ${orderhistory.total_selected_underline}
    AppiumLibrary.Wait until page does not contain element         ${orderhistory.txt_must_pay_selected_underline}
    AppiumLibrary.Wait until page does not contain element         ${orderhistory.txt_prepare_selected_underline}
    AppiumLibrary.Wait until page does not contain element         ${orderhistory.txt_delivery_selected_underline}
    AppiumLibrary.Wait until page does not contain element         ${orderhistory.txt_canceled_selected_underline}

Verify red highlight when select cancelled tab
    DobbyAppCommon.Wait until element is visible except stale     ${orderhistory.txt_order_last}
    mobile_common.Swipe right to left                            ${orderhistory.txt_total_scrollview}
    DobbyAppCommon.Tap element when ready                                 ${orderhistory.txt_cancel}
    mobile_common.Page should not contain loading spinner
    DobbyAppCommon.Wait until element is visible except stale       ${orderhistory.txt_canceled_selected_underline}
    AppiumLibrary.Wait until page does not contain element         ${orderhistory.total_selected_underline}
    AppiumLibrary.Wait until page does not contain element         ${orderhistory.txt_must_pay_selected_underline}
    AppiumLibrary.Wait until page does not contain element         ${orderhistory.txt_prepare_selected_underline}
    AppiumLibrary.Wait until page does not contain element         ${orderhistory.txt_delivery_selected_underline}
    AppiumLibrary.Wait until page does not contain element         ${orderhistory.txt_delivered_success_selected_underline}

Verify current page is order history by title
    DobbyAppCommon.Wait until element is visible except stale       ${orderhistory.order}

Verify target order number has cancel status display on order list
    [Arguments]    ${order_number}      ${moveto}=${scroll_direction['bottom']}
    ${order_number_str}   Convert to string   ${order_number}
    ${txt_order_number_locator}       String.Replace string     ${orderhistory.txt_cancel_order}    {{orderId}}    \#${order_number_str}
    FOR     ${i}    IN RANGE    1   5
        ${order_shown}   Run keyword and return status   DobbyAppCommon.Wait until element is visible except stale    ${txt_order_number_locator}    timeout=${short_timeout}
        IF    ${order_shown} == ${True}    BREAK
        IF     "${moveto}" == "Top"
            mobile_common.Swipe top to bottom  ${orderhistory.order_list_area}
            ${order_shown}   Run keyword and return status   DobbyAppCommon.Wait until element is visible except stale    ${txt_order_number_locator}    timeout=${short_timeout}
        ELSE
            mobile_common.Swipe bottom to top  ${orderhistory.order_list_area}
            ${order_shown}   Run keyword and return status   DobbyAppCommon.Wait until element is visible except stale    ${txt_order_number_locator}    timeout=${short_timeout}
        END
        IF    ${order_shown} == ${True}    BREAK
    END

Verify order status by order id
    [Arguments]     ${order_id}     ${order_status}
    ${order_id}           Convert to string   ${order_id}
    ${order_id_locator}            String.Replace string    ${orderhistory.order_status}    {{order_id}}    ${order_id}
    ${order_status_locator}            String.Replace string    ${order_id_locator}    {{order_status}}    ${order_status}
    DobbyAppCommon.Wait until element is visible except stale       ${order_status_locator}

Verify refund tag is display on order list
    DobbyAppCommon.Find element   ${orderhistory.txt_refund_cencel}     scroll_panel=${default_scroll_view}    moveto=Top    percent=${swipeLongScroll}  timeout=${shortTimeout}

Refresh order history list
    mobile_common.Tap more menu
    mobile_common.Wait until loading complete
    mobile_common.Tap my orders menu
    mobile_common.Wait until loading complete

Verify order history card status same like order title tab
    [Arguments]        ${expected_status}
    ${order_status_show}  DobbyAppCommon.Get text from element when ready     ${orderhistory.order_card_status_1}
    Should be equal as strings     ${order_status_show}       ${expected_status}

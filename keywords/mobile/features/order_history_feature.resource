*** Settings ***
Resource        ../pages/order_history_page.resource
Resource        ../pages/order_detail_page.resource
Resource        ../pages/basket_page.resource
Resource        ../pages/home_page.resource

*** Keywords ***
Verify lastest order match with pickpack order number
    [Arguments]     ${pickpack_order_number}
    ${lastest_order}  order_history_page.Get lastest order number of order history
    Should be equal           ${lastest_order}      ${pickpack_order_number}

Click first order and add all item to basket
    order_history_page.Click the first order in order history
    order_detail_page.Click add all items to the basket button

Change tab for refresh status
    [Arguments]     ${expect_status}
    mobile_common.Tap more menu     #change page for refresh status
    mobile_common.Tap my orders menu      
    DobbyAppCommon.Wait until element is visible except stale       ${expect_status}

Change tab and verify order status by order id
    [Arguments]     ${order_id}     ${order_status}
    ${order_id}           Convert to string   ${order_id}
    ${order_id_locator}            String.Replace string    ${orderhistory.order_status}    {{order_id}}    ${order_id}
    ${order_status_locator}            String.Replace string    ${order_id_locator}    {{order_status}}    ${order_status}
    Wait until keyword succeeds  5x   10s  order_history_feature.Change tab for refresh status       ${order_status_locator}

Get order history to dictionary
    [Arguments]    ${order_card_details}     ${order_card_status}
    &{order_dict}    Create dictionary
    ${order_length}    Set variable    0
    WHILE   ${order_length} < 5
        ${order_card_details_list}    AppiumLibrary.Get webelements    ${orderhistory.order_history_card_details}
        ${order_card_status_list}     AppiumLibrary.Get webelements    ${orderhistory.order_history_card_status}
        FOR    ${order_details}       ${order_status}    IN ZIP     ${order_card_details_list}    ${order_card_status_list}
            ${order_number_txt}       AppiumLibrary.Get text    ${order_details}
            ${order_status}           AppiumLibrary.Get text    ${order_status}
            ${extract_order_number_details}          String.Get regexp matches    ${order_number_txt}    (\\d+)
            ${key_not_exists}        Run keyword and return status    Collections.Dictionary should not contain key    ${order_dict}    ${extract_order_number_details[0]}
            IF    ${key_not_exists}==True
                @{order_list}    Create list     ${order_status}    ${extract_order_number_details[1]}
                Collections.Set to dictionary    ${order_dict}    ${extract_order_number_details[0]}=${order_list}
            END
        END
        ${order_length}    Get length    ${order_dict}
        DobbyAppCommon.Swipe up      end_y=${swipe_70}
    END
    @{order_list}    Evaluate    [{'order_number': key, 'order_status': value[0], 'order_item_number': int(value[1])} for key, value in ${order_dict}.items()]
    [Return]    ${order_list}

Navigate and verify my orders list page not login
    mobile_common.Tap my orders menu
    order_history_page.Verify my orders list page not login

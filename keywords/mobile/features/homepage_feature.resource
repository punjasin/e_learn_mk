*** Settings ***
Resource        ../pages/home_page.resource
Resource        ../pages/order_detail_page.resource
Resource        ../pages/basket_page.resource

*** Keywords ***
Enter zip code when open application
    [Arguments]     ${zipcode}=${multistore_data['samaedam_zipcode']}     ${subdistrict}=${multistore_data['samaedam_subdistrict']['${lang}']} 
    home_page.Verify provide your zip code popup is display  
    home_page.Enter zip code        ${zipcode}
    home_page.Select subdistrict    ${zipcode}  ${subdistrict}
    home_page.Click save zip code

Enter zip code and save
    [Arguments]     ${zipcode}      ${subdistrict}
    home_page.Enter zip code        ${zipcode}
    home_page.Select subdistrict    ${zipcode}  ${subdistrict}
    home_page.Click save zip code

Verify zip code popup not close when swipe or tap back
    mobile_common.Swipe up    2
    mobile_common.Swipe down  2
    AppiumLibrary.Go back
    home_page.Verify provide your zip code popup is display

Verify zip code popup display after quit app and reopen
    AppiumLibrary.Background app        seconds=${short_timeout}
    home_page.Verify provide your zip code popup is display

Skip register makro point if exist
    ${status}       Run keyword and return status     DobbyAppCommon.Wait until element is visible except stale       ${homepage.txt_makropoint_title}     ${timeout}=${short_timeout}
    IF      ${status}
        DobbyAppCommon.Tap element when ready       ${homepage.btn_create_makrocard}
        DobbyAppCommon.Wait until element is visible except stale       ${homepage.member_card_container}
        DobbyAppCommon.Tap element when ready       ${homepage.btn_confirm_create_card}
    END

Verify zipcode outside of delivery area has error message
    [Arguments]     ${zipcode}
    home_page.Enter zip code    ${zipcode}
    home_page.Verify outside of delivery area error message display
    mobile_common.Hide keyboard down
    home_page.Verify continue button is disable

Tap and verify banner should be expected page
    [Arguments]     ${banner_name}    ${expect_page}
    ${status}=      Run keyword and return status    DobbyAppCommon.Wait until element is visible except stale       ${mobile_common.icon_button}       ${timeout}=${short_timeout}
    home_page.Tap banner by banner name     ${banner_name}
    DobbyAppCommon.Wait until element is visible except stale       ${expect_page}
    IF    '${status}'=='True'
        mobile_common.Tap go back icon
    ELSE
        AppiumLibrary.Go back
    END

Get recent order to dictionary
    [Arguments]    ${minimum_recent_order}=5
    [Documentation]    This feature also verify image on recent order card and verify element is display on order card
    mobile_common.Tap shopping menu
    DobbyAppCommon.Swipe up      end_y=${swipe_50}
    ${element_size}        AppiumLibrary.Get element size          ${homepage.section_recent_order}
    ${element_location}    AppiumLibrary.Get element location      ${homepage.section_recent_order}
    ${start_y}         Evaluate      ${element_location['y']} + (${element_size['height']} * 0.1)
    ${end_y}           Evaluate      ${element_location['y']} + (${element_size['height']} * 0.1)
    ${start_x}         Evaluate      ${element_location['x']} + (${element_size['width']} * 0.7)
    ${end_x}           Evaluate      ${element_location['x']} + (${element_size['width']} * 0)
    @{recent_order_list}    Create list
    FOR    ${round}    IN RANGE    0    ${minimum_recent_order}
        @{recent_order}        AppiumLibrary.Get webelements                 ${homepage.section_recent_order_item}
        @{orders_list}         order_detail_page.Get order detail to list    @{recent_order}    locator=${homepage.txt_recent_order_item}
        &{order_dict}          homepage_feature.Create order detail dictionary    @{orders_list}
        Collections.Append to list    ${recent_order_list}    ${order_dict}
        AppiumLibrary.Swipe    ${start_x}    ${start_y}   ${end_x}    ${end_y}
    END
    [Return]   ${recent_order_list}

Create order detail dictionary
    [Arguments]    @{orders_list}
    [Documentation]    This keyword is used to get all element text from all recent orders during by checking if that group during swipe found every data like order id, date, total amount, order status, image (None data happened when swipe and not see full order detail to get element text)
    &{recent_order_dict}    Create dictionary
    FOR    ${order_locator}    IN    @{orders_list}
        ${order_number}    ${order_date}    ${order_total}    ${order_status}    ${order_image_reminder}    homepage_feature.Extract order detail from list of order items    order_locator=${order_locator}
        ${key_not_exists}    Run keyword and return status    Collections.Dictionary should not contain key    ${recent_order_dict}    ${order_number}
        IF    ${key_not_exists}==True and '${order_number}'!='${None}' and '${order_date}'!='${None}' and '${order_total}'!='${None}' and '${order_status}'!='${None}' and '${order_image_reminder}'
            ${order_number}         String.Remove string     ${order_number}     ${mobile_additional['order']['label']['order']}
            ${image_locator}        String.Replace string    ${order_locator}    TextView    ImageView
            ${image_number}         homepage_feature.Get image number from recent order list    ${image_locator}
            ${image_number}         Evaluate    ${image_number} + ${order_image_reminder}
            Collections.Set to dictionary    ${recent_order_dict}
            ...    order_number=${order_number}
            ...    order_date=${order_date}
            ...    order_total=${order_total}
            ...    order_status=${order_status}
            ...    order_item_number=${image_number}
        END
    END
    [Return]    ${recent_order_dict}

Extract order detail from list of order items
    [Arguments]    ${order_locator}
    TRY
        @{orders_list}             AppiumLibrary.Get webelements           ${order_locator}
        ${order_image_reminder}    Set variable                            0
        ${order_number}            AppiumLibrary.Get text                  ${orders_list[0]}
        ${order_date}              AppiumLibrary.Get text                  ${orders_list[1]}
        ${order_total}             AppiumLibrary.Get text                  ${orders_list[2]}
        ${order_status}            AppiumLibrary.Get text                  ${orders_list[3]}
        ${is_total}                String.Get regexp matches               ${order_total}       (\\+\\s\\d)
        ${matches}                 Get length                              ${is_total}
        IF   ${matches} > 0
            ${order_image_reminder}    AppiumLibrary.Get text      ${orders_list[2]}
            ${order_image_reminder}    String.Remove string        ${order_image_reminder}    +${SPACE}
            ${order_image_reminder}    Convert to integer          ${order_image_reminder}
            ${order_total}     AppiumLibrary.Get text              ${orders_list[3]}
            ${order_status}    AppiumLibrary.Get text              ${orders_list[4]}
        END
    EXCEPT
        ${order_number}            Set variable      ${None}
        ${order_date}              Set variable      ${None}
        ${order_total}             Set variable      ${None}
        ${order_status}            Set variable      ${None}
        ${order_image_reminder}    Set variable      0
    END
    [Return]    ${order_number}    ${order_date}    ${order_total}    ${order_status}    ${order_image_reminder}


Get image number from recent order list
    [Arguments]    ${image_locator}
    @{image_list}     AppiumLibrary.Get webelements    ${image_locator}
    ${image_number}   Get length    ${image_list}
    [Return]    ${image_number}

Verify the recent order section is displayed betweeen top banner and above collections in homepage
    ${banner}            AppiumLibrary.Get element location    ${homepage.section_banner} 
    ${recent_recent}     AppiumLibrary.Get element location    ${homepage.section_recent_order}
    ${collections}       AppiumLibrary.Get element location    ${homepage.section_collections}
    Should be true    ${banner['y']} < ${recent_recent['y']} and ${recent_recent['y']} < ${collections['y']}

Verify see all button is display and tap see all button
    [Arguments]    ${see_all_locator}
    DobbyAppCommon.Wait until element is visible except stale    ${see_all_locator}
    DobbyAppCommon.Tap element when ready    ${see_all_locator}

Verify order details on recent order cards display correct
    [Arguments]    ${order_list}    ${recent_order_list}
    FOR    ${order}    ${recent_order}    IN ZIP    ${order_list}   ${recent_order_list}
        order_detail_page.Verify order number is same as recent order number        ${order['order_number']}    ${recent_order['order_number']}
        order_detail_page.Verify date format is correct     ${recent_order['order_date']}    %d/%m/%Y
        order_detail_page.Verify order total format         ${recent_order['order_total']}
        order_detail_page.Verify order status format        ${recent_order['order_status']}
    END

Verify recent orders displays the same list as the order history page
    [Arguments]    ${order_list}    ${recent_order_list}
    @{new_recent_order_list}         Create list
    FOR    ${order}    IN    @{recent_order_list}
        &{recent_dict}    Create dictionary
        Collections.Set to dictionary    ${recent_dict}    
        ...    order_number=${order['order_number']}
        ...    order_status=${order['order_status']}
        ...    order_item_number=${order['order_item_number']}
        Collections.Append to list     ${new_recent_order_list}    ${recent_dict}
    END
    Collections.Lists should be equal    ${order_list}    ${new_recent_order_list}
Click first recent order get all productname and add all productname to basket until verify product to basket
    home_page.Click first order in recent orders
    ${product_order}     order_detail_page.Get all product name from order detail
    order_detail_page.Click add all items to the basket button
    mobile_common.Tap basket menu
    ${product_basket}     basket_page.Get all product name from basket
    basket_page.Verify product on basket should be product from order history       ${product_basket}        ${product_order}        
    [Return]  ${product_basket}

Get all sub district by scroll until last sub district
    [Arguments]        ${total_subdistrict}        ${subdistrict}
    ${getsize_subdistrict}    AppiumLibrary.Get element size          ${homepage.zipcode_subdistrict_dropdown}
    ${getcoor_subdistrict}    AppiumLibrary.Get element location      ${homepage.zipcode_subdistrict_dropdown}
    ${center_x}   Evaluate    ${getcoor_subdistrict['x']}+${getsize_subdistrict['width']}/2
    ${center_y}   Evaluate    ${getcoor_subdistrict['y']}+${getsize_subdistrict['height']}/2
    ${new_y}      Evaluate    ${center_y}/1.5
    ${subdistrict_txt_locator}    String.Replace string    ${homepage.subdistrict_txt}    {{subdistrict}}    ${subdistrict}
    ${all_subdistrict}        Create list
    FOR    ${index}        IN RANGE    ${total_subdistrict}
        ${sub_district_list}      AppiumLibrary.Get webelements      ${homepage.txt_all_subdistrict}
        ${total_subdistrict}      Get length              ${sub_district_list}
        ${xpath_subdistrict}      String.Remove string      ${homepage.txt_all_subdistrict}      xpath=   
        FOR    ${index}              IN RANGE             1         ${total_subdistrict}+1
            ${subdistrict_with_index}         Catenate    SEPARATOR=    xpath=    (${xpath_subdistrict})     [${index}]
            IF  "${platform}" == "${platform_list['ios']}"
                ${subdistrict_text}      AppiumLibrary.Get text     ${subdistrict_with_index}
            ELSE IF   "${platform}" == "${platform_list['android']}"
                ${subdistrict_text}      DobbyAppCommon.Get text from element when ready     ${subdistrict_with_index}      timeout=${appium_timeout}
            END
            Collections.Append to list      ${all_subdistrict}      ${subdistrict_text.strip()}
        END
        ${status}       Run keyword and return status       DobbyAppCommon.Wait until element is visible except stale  ${subdistrict_txt_locator}  timeout=${short_timeout}
        IF    ${status}==${True}
            Exit for loop
        END
        AppiumLibrary.Swipe         ${center_x}  ${center_y}  ${center_x}  ${new_y}
    END
    ${all_subdistrict}    Collections.Remove duplicates     ${all_subdistrict}
    [Return]        ${all_subdistrict}

Verify all sub district from its zipcode display correct
    [Arguments]     ${zipcode}
    home_page.Verify provide your zip code popup is display  
    home_page.Enter zip code        ${zipcode}
    ${sub_district_db_data}    zipcode_db_page.Get all sub district by zipcode     ${zipcode}       ${makropro_db['catalog_data_service']}
    ${total_subdistrict}       Get length        ${sub_district_db_data}
    ${last_subdistrict}        Set variable      ${sub_district_db_data[-1]}
    ${sub_district_app_data}   homepage_feature.Get all sub district by scroll until last sub district    ${total_subdistrict}    ${last_subdistrict}
    Collections.Lists should be equal       ${sub_district_app_data}    ${sub_district_db_data}     ignore_order=${True}

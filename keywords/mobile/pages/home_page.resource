*** Settings ***
Resource        ../../../resources/locators/${platform}/home_locator.resource
Resource        ../../../resources/locators/${platform}/product_locator.resource
Resource        ../../../resources/locators/${platform}/common_locator.resource
Resource        ../../../common/mobile/mobile_common.resource

*** Keywords ***
Tap zip code selector
    IF   "${platform}" == "${platform_list['android']}"
        DobbyAppCommon.Tap element when ready       ${homepage.location_selector_zipcode}
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        DobbyAppCommon.Tap element when ready   ${homepage.zipcode_selector}
    END    

Verify selected zip code display as
    [Arguments]     ${zipcode}
    ${zipcode}      Convert to string       ${zipcode}
    ${zipcode_selected_locator}    String.Replace string    ${homepage.zipcode_selected}    {{zipcode}}    ${zipcode}
    DobbyAppCommon.Wait until element is visible except stale   ${zipcode_selected_locator}

Verify provide your zip code popup is display
    IF   "${platform}" == "${platform_list['android']}"
        DobbyAppCommon.Wait until element is visible except stale    ${homepage.zipcode_title}
        DobbyAppCommon.Wait until element is visible except stale    ${homepage.input_zipcode}
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        DobbyAppCommon.Wait until element is visible except stale   ${homepage.zipcode_title}
        DobbyAppCommon.Wait until element is visible except stale   ${homepage.input_zipcode}
    END

Verify your zip code popup is display
    ${txt_title_your_zipcode_locator}    String.Replace string    ${homepage.txt_title_your_zipcode}    {{title_your_zipcode}}    ${title_your_zipcode}
    DobbyAppCommon.Wait until element is visible except stale    ${txt_title_your_zipcode_locator}
    DobbyAppCommon.Wait until element is visible except stale    ${homepage.txt_zip_code_dialog_text}
    DobbyAppCommon.Wait until element is visible except stale    ${homepage.input_zipcode}

Enter zip code
    [Arguments]     ${zipcode}
    Wait until keyword succeeds  5x   10s  DobbyAppCommon.Input text to element when ready     ${homepage.input_zipcode}     ${zipcode}                                                       
    FOR     ${i}    IN RANGE    0   2
        ${subdistrict_shown}=  Run keyword and return status   DobbyAppCommon.Wait until element is visible except stale    ${homepage.zipcode_subdistrict_dropdown}    timeout=${short_timeout}
        IF    ${subdistrict_shown} == ${True}    BREAK
        DobbyAppCommon.Clear text when ready    ${homepage.input_zipcode}
        Sleep   2s
        DobbyAppCommon.Input text to element when ready     ${homepage.input_zipcode}     ${zipcode}
    END

Select subdistrict
    [Arguments]     ${zipcode}      ${subdistrict}
    DobbyAppCommon.Wait until element is visible except stale   ${homepage.zipcode_subdistrict_dropdown}   timeout=${short_timeout}
    ${getsize_subdistrict} =   AppiumLibrary.Get Element Size          ${homepage.zipcode_subdistrict_dropdown}
    ${getcoor_subdistrict} =   Get element location      ${homepage.zipcode_subdistrict_dropdown}
    ${center_x}   Evaluate    ${getcoor_subdistrict['x']}+${getsize_subdistrict['width']}/2
    ${center_y}   Evaluate    ${getcoor_subdistrict['y']}+${getsize_subdistrict['height']}/2
    ${new_y}      Evaluate    ${center_y}/1.5
    FOR     ${i}    IN RANGE    1       10
        ${subdistrict_txt_locator}    String.Replace string    ${homepage.subdistrict_txt}    {{subdistrict}}    ${subdistrict}
        ${status}       Run keyword and return status       DobbyAppCommon.Wait until element is visible except stale  ${subdistrict_txt_locator}  timeout=${short_timeout}
        Exit for loop if    ${status}
        Swipe         ${center_x}  ${center_y}  ${center_x}  ${new_y}
    END
    DobbyAppCommon.Tap element when ready   ${subdistrict_txt_locator}      timeout=${short_timeout}
    AppiumLibrary.Hide keyboard

Click save zip code
    DobbyAppCommon.Tap element when ready     ${homepage.zipcode_save}

Toast message should display save zip code success
    mobile_common.Toast message should display and close   ${homepage.toast_success}

Click x buttonto close your zip code popup
    DobbyAppCommon.Tap element when ready     ${homepage.icon_button}

Error message should display as
    [Documentation]     using ${address['message']['invalidPostalCode']} , ${multistore['message']['outsideAreaErrorInput']}
    [Arguments]     ${error}
    ${txt_error_locator}    String.Replace string    ${homepage.txt_error}    {{error}}    ${error}
    DobbyAppCommon.Wait until element is visible except stale   ${txt_error_locator}

## out of delivery
Click continue with out of delivery zip code
    DobbyAppCommon.Tap element when ready     ${homepage.btn_continue_on_out_of_delivery_area}

Verify outside of delivery area error message display
    DobbyAppCommon.Wait until element is visible except stale   ${homepage.txt_zipcode_outside_area} 

Verify continue button is disable
    AppiumLibrary.Element should be disabled     ${homepage.btn_continue}
    
Click change zipcode on out of delivery popup
    DobbyAppCommon.Tap element when ready     ${homepage.btn_update}

Verify out of delivery footer is display
    DobbyAppCommon.Wait until element is visible except stale   ${homepage.txt_we_are_unable_to_deliver}
    
Click accept on terms and conditions popup
    DobbyAppCommon.Tap element when ready    ${homepage.btn_accept_terms_and_conditions}

Verify target category name display on home page
    [Arguments]     ${category_name}
    [Documentation]     Example: find fresh section on home page
    ${category_locator}            String.Replace string    ${homepage.txt_category_name}   {{category_name}}       ${category_name}
    DobbyAppCommon.Find element    ${category_locator}   scroll_panel=${default_scroll_view}    moveto=Top    percent=${swipeLongScroll}  timeout=${shortTimeout}
    
Tap see all category
    [Arguments]     ${category_name}
    ${sell_all_category_locator}   String.Replace string    ${homepage.txt_see_all}     {{category_name}}     ${category_name}
    mobile_common.Find element and tap       ${sell_all_category_locator}
    
Select product in recommendation
    [Arguments]     ${product}
    ${fresh_list_container_product_item_gid_locator}    String.Replace string    ${homepage.fresh_list_container_product_item_gid}    {{product}}    ${product}
    DobbyAppCommon.Tap element when ready  ${fresh_list_container_product_item_gid_locator}
    
Swipe right in fresh module until find product
    [Arguments]     ${product}
    IF   "${platform}" == "${platform_list['android']}"
        ${1pos}=    Get Element Location    ${homepage.fresh_list_container_imageview}
        FOR     ${i}    IN RANGE    15
            ${product_item_gid_locator}    String.Replace string    ${homepage.product_item_gid}    {{product}}    ${product}
            ${status}       Run keyword and return status       DobbyAppCommon.Wait until element is visible except stale   ${product_item_gid_locator}      timeout=${short_timeout}
            Exit for loop if    ${status}
            Swipe   500      ${1pos}[y]      ${1pos}[x]     ${1pos}[y]     #swipe left
        END
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        ${1pos}=    Get Element Location    ${homepage.fresh_list_container_imageview}
        FOR     ${i}    IN RANGE    15
            ${product_item_gid_product_locator}    String.Replace string    ${homepage.product_item_gid_product}    {{product}}    ${product}
            ${status}       Run keyword and return status       DobbyAppCommon.Wait until element is visible except stale   ${product_item_gid_product_locator}      timeout=${short_timeout}
            Exit for loop if    ${status}
            Swipe   500      ${1pos}[y]      ${1pos}[x]     ${1pos}[y]     #swipe left
        END
    END

Verify total point on home page is correct
    [Arguments]     ${total_point}
    ${total_point}      Evaluate      "{:,}".format(${total_point})
    ${point_locator}    String.Replace string    ${homepage.txt_total_point}    {{total_point}}    ${total_point}
    DobbyAppCommon.Wait until element is visible except stale        ${point_locator}

Verify promotion category is display
    DobbyAppCommon.Wait until element is visible except stale   ${homepage.promotion_group}

Tap + add first item in promotion category
    [Arguments]     ${count}=1
    mobile_common.Find element and tap      ${homepage.btn_add_promo_first_item}
    productcard_page.Click add to basket on add to basket modal     ${count}
    productcard_page.Verify toast add to basket successfully

Tap trash button
    DobbyAppCommon.Tap element when ready       ${homepage.btn_trash}

Verify toast message show product remove from basket
    DobbyAppCommon.Wait until element is visible except stale   ${homepage.txt_toast_remove_product}

Get product name of first product in promotion category
    ${product_name}       DobbyAppCommon.Get text from element when ready     ${homepage.txt_first_product_promotion_item}
    [Return]        ${product_name}

Tap at product name
    [Arguments]     ${product_name}
    ${product_name_locator}    String.Replace string    ${homepage.txt_product_name}    {{productname}}    ${productname}
    DobbyAppCommon.Tap element when ready               ${product_name_locator}

Tap banner by banner name
    [Arguments]     ${banner_name}
    ${banner_locator}    String.Replace string    ${homepage.banner}    {{bannername}}    ${banner_name}
    DobbyAppCommon.Tap element when ready               ${banner_locator}
    
Verify total point display amount correct
    [Arguments]    ${expected_total_point}
    ${total_point}      Evaluate      "{:,}".format(${expected_total_point})
    ${point_locator}    String.Replace string    ${homepage.txt_point}    {{total_point}}    ${total_point}
    DobbyAppCommon.Wait until element is visible except stale        ${point_locator}

Verify image on recent order card is display correct number
    [Arguments]    ${order_dict}    ${recent_order_dict}
    FOR    ${order}    ${recent_order}    IN ZIP    ${order_dict}    ${recent_order_dict}
        IF    ${order['order_number']} == ${recent_order['order_number']}
            Should be equal    ${order['order_item_number']}    ${recent_order['order_item_number']}
        END
    END
Click first order in recent orders
    DobbyAppCommon.Tap element when ready     ${homepage.first_recent}

Tap first product at target category to PDP page
    [Arguments]     ${target_category}
    ${target_locator}    String.Replace string    ${homepage.first_product}    {{target_category}}    ${target_category}
    mobile_common.Find element and tap               ${target_locator}

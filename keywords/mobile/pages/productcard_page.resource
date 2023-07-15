*** Settings ***
Resource        ../../../resources/locators/${platform}/product_locator.resource
Resource        ../../../resources/locators/${platform}/common_locator.resource
Resource        ../../../common/mobile/mobile_common.resource

*** Keywords ***
Increase quantity at product card
    [Arguments]    ${product}   ${number}=1
    ${increment_btn_wrapper_locator}    String.Replace string    ${productcard_page.increment_btn_wrapper}    {{product}}    ${product}
    ${current_quantity}    String.Replace string    ${productcard_page.select_quantity}    {{product}}    ${product}
    DobbyAppCommon.Tap element when ready    ${current_quantity}
    IF   "${platform}" == "${platform_list['android']}"
        FOR     ${round}    IN RANGE    ${number}   
            DobbyAppCommon.Tap element when ready    ${increment_btn_wrapper_locator}
            mobile_common.Wait until loading complete
        END
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        FOR    ${i}    IN RANGE    ${number}
            DobbyAppCommon.Tap element when ready    ${increment_btn_wrapper_locator}
        END
    END
    productcard_page.Update basket    ${product}

Decrease quantity at product card
    [Arguments]    ${product}   ${number}=1
    ${decrement_btn_wrapper_locator}    String.Replace string    ${productcard_page.decrement_btn_wrapper}    {{product}}    ${product}
    IF   "${platform}" == "${platform_list['android']}"
        FOR     ${round}    IN RANGE    ${number}   
            DobbyAppCommon.Tap element when ready    ${decrement_btn_wrapper_locator}
            mobile_common.Wait until loading complete
        END
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        FOR    ${i}    IN RANGE    ${number}
            DobbyAppCommon.Tap element when ready    ${decrement_btn_wrapper_locator}
        END
    END
    
Adjust quantity by typing at product card
    [Arguments]     ${product}      ${quantity} 
    ${qty_input_locator}    String.Replace string    ${productcard_page.qty_input}    {{product}}    ${product}
    IF   "${platform}" == "${platform_list['android']}"
        DobbyAppCommon.Wait until element is visible except stale        ${qty_input_locator}
        DobbyAppCommon.Input text to element when ready     ${qty_input_locator}         ${quantity} 
        DobbyAppCommon.Tap element when ready        ${qty_input_locator}
        Press keycode   66   # Enter key
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        DobbyAppCommon.Tap element when ready               ${qty_input_locator}
        DobbyAppCommon.Clear text when ready        ${qty_input_locator}
        DobbyAppCommon.Input text to element when ready             ${qty_input_locator}     ${quantity}
        DobbyAppCommon.Tap element when ready               ${product_page.succesess}
    END

Verify product quantity at product card
    [Arguments]     ${product}      ${quantity}
    ${product_locator}           String.Replace string    ${productcard_page.quantity_input}    {{product}}    ${product}
    ${quantity_input_locator}    String.Replace string    ${product_locator}    {{quantity}}    ${quantity}
    DobbyAppCommon.Wait until element is visible except stale      ${quantity_input_locator}

Click product name at product card
    [Arguments]    ${product}
    IF   "${platform}" == "${platform_list['android']}"
        ${txt_product_locator}           String.Replace string    ${productcard_page.txt_product}    {{product}}    ${product}
        DobbyAppCommon.Tap element when ready    ${txt_product_locator}
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        ${product_image_locator}           String.Replace string    ${productcard_page.product_image}    {{product}}    ${product}
        DobbyAppCommon.Tap element when ready    ${product_image_locator}
    END

Click add to basket at product card
    [Arguments]     ${productname}
    ${txt_add_to_basket_locator}      String.Replace string    ${productcard_page.txt_add_to_basket}    {{product}}    ${productname}
    mobile_common.Find element and tap     ${txt_add_to_basket_locator}
    mobile_common.Wait until loading complete

Open update quantity
    [Arguments]     ${product}      ${quantity}
    ${product_quantity}    Convert to string    ${quantity}
    ${product_locator}           String.Replace string    ${productcard_page.quantity_input}    {{product}}    ${product}
    ${quantity_input_locator}    String.Replace string    ${product_locator}    {{quantity}}    ${product_quantity}
    mobile_common.Find element and tap     ${quantity_input_locator}

Update basket
    [Arguments]     ${productname}
    ${txt_add_to_basket_locator}      String.Replace string    ${productcard_page.update_basket}    {{product}}    ${productname}
    mobile_common.Find element and tap     ${txt_add_to_basket_locator}
    mobile_common.Wait until loading complete

Tap add to basket button
    [Arguments]     ${productname}
    IF   "${platform}" == "${platform_list['android']}"
        productcard_page.Click add to basket at product card  ${productname}
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        DobbyAppCommon.Tap element when ready       ${productcard_page.btn_add_basket}
    END

Verify qty product display correct
    [Arguments]     ${product_name}     ${qty}
    IF   "${platform}" == "${platform_list['android']}"
        productcard_page.Verify product quantity at product card    ${product_name}       ${qty}
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        ${txt_qty_locator}      String.Replace string    ${productcard_page.txt_qty}    {{qty}}    ${qty}
        DobbyAppCommon.Wait until element is visible except stale       ${txt_qty_locator}
    END

Verify product original price and discount at product card
    [Arguments]     ${productname}   ${original}    ${discount}=0
    IF   "${platform}" == "${platform_list['android']}"
        ${productname_locator}        String.Replace string    ${productcard_page.txt_original}    {{productname}}    ${productname}
        ${original_price_locator}     String.Replace string    ${productname_locator}    {{original}}      ${original}
        ${discount_price_locator}     String.Replace string    ${productname_locator}    {{original}}      ${discount}
        IF   '${discount}'== '0'
            DobbyAppCommon.Wait until element is visible except stale    ${original_price_locator}
        ELSE
            DobbyAppCommon.Wait until element is visible except stale    ${discount_price_locator}
        END   
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        
        IF   '${discount}'== '0'
            ${product_price_locator}      String.Replace string    ${productcard_page.item_gid_list_item_price_original}       {{product}}    ${productname}
            ${product_price_locator}      String.Replace string    ${product_price_locator}    {{original}}    ${original}
            DobbyAppCommon.Wait until element is visible except stale    ${product_price_locator}
        ELSE
            ${product_price_locator}      String.Replace string    ${productcard_page.item_gid_list_item_price_discount}    {{product}}    ${productname}
            ${product_price_locator}      String.Replace string    ${product_price_locator}    {{discount}}    ${discount}
            ${product_price_locator}      String.Replace string    ${product_price_locator}    {{original}}    ${original}
            DobbyAppCommon.Wait until element is visible except stale    ${product_price_locator}
        END   
    END

Verify product price at product card
    [Documentation]     This KW for product card on "PLP" section
    [Arguments]     ${productname}  ${original}    ${discount}=0
    IF   "${platform}" == "${platform_list['android']}"
        ${productname_locator}      String.Replace string    ${productcard_page.txt_original}    {{productname}}    ${productname}
        ${txt_original_locator}      String.Replace string    ${productcard_page.txt_original}    {{original}}    ${original}
        Run Keyword If      '${discount}'== '0'     DobbyAppCommon.Wait until element is visible except stale   ${txt_original_locator}
        Run Keyword If      '${discount}'!= '0'     productcard_page.Check product price with discount at product card   ${productname}  ${original}    ${discount}
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        ${productname_locator}                            String.Replace string    ${productcard_page.item_gid_list_item_price_original}    {{productname}}    ${productname}
        ${item_gid_list_item_price_original_locator}      String.Replace string    ${productname_locator}    {{original}}    ${original}
        
        ${productname_locator}                            String.Replace string    ${productcard_page.item_gid_list_item_price_discount}    {{productname}}    ${productname}
        ${discount_locator}                               String.Replace string    ${productname_locator}    {{discount}}    ${discount}
        ${item_gid_list_item_price_discount_locator}      String.Replace string    ${productname_locator}    {{original}}    ${original}

        Run keyword if     '${discount}'== '0'  DobbyAppCommon.Wait until element is visible except stale   ${item_gid_list_item_price_original_locator}
        ...     ELSE IF    '${discount}'!= '0'  DobbyAppCommon.Wait until element is visible except stale   ${item_gid_list_item_price_discount_locator}
    END

Verify product out of stock tag display at product card
    [Arguments]     ${product}
    ${txt_out_of_stock_locator}    String.Replace string    ${productcard_page.txt_out_of_stock}    {{product}}    ${product} 
    IF   "${platform}" == "${platform_list['android']}"
        FOR    ${i}    IN RANGE    5
            ${status}=      Run Keyword And Return Status   Element Should Be Visible       ${txt_out_of_stock_locator}
            Run keyword if      '${status}'== 'False'      DobbyAppCommon.Move to    Left
            Exit for loop if    '${status}'=='True'     
        END 
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        DobbyAppCommon.Wait until element is visible except stale      ${txt_out_of_stock_locator}
    END

Verify out of delivery button is display
    IF   "${platform}" == "${platform_list['android']}"
        DobbyAppCommon.Wait until element is visible except stale    ${productcard_page.unavailable}
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        DobbyAppCommon.Wait until element is visible except stale       ${productcard_page.add_to_cart_gid}
    END

Verify product list show available product
    [Documentation]     Example: fresh category found add to cart button show
    DobbyAppCommon.Wait until element is visible except stale     ${productcard_page.btn_addbasket_first}

Verify product list show unavailable product
    [Documentation]     Example: fresh category found out of stock button show
    DobbyAppCommon.Find element    ${productcard_page.btn_outofstock_first}   scroll_panel=${default_scroll_view}    moveto=Top    percent=${swipeLongScroll}  timeout=${shortTimeout}

Verify target badge display on product card
    [Arguments]     ${badge_name}   ${product_name}
    [Documentation]     Verify first index of search result or category list show target badge
    ${badge_locator}     String.Replace string      ${productcard_page.txt_badge}   {{badge_name}}    ${badge_name}
    ${product_with_badge_locator}   String.Replace string       ${badge_locator}   {{product_name}}   ${product_name}
    mobile_common.Swipe to find element    ${product_with_badge_locator}  round_amount=${10}

Verify product has percent discount
    [Arguments]     ${product_name}
    ${product_locator}     String.Replace string    ${productcard_page.txt_product}     {{product}}   ${product_name}
    DobbyAppCommon.Find element    ${product_locator}   scroll_panel=${default_scroll_view}    moveto=Top    percent=${swipeLongScroll}  timeout=${shortTimeout}
    ${product_with_discount_locator}     String.Replace string    ${productcard_page.txt_discount_product}      {{product_name}}      ${product_name}
    DobbyAppCommon.Wait until element is visible except stale     ${product_with_discount_locator}      timeout=${time_scroll}

Verify product not has percent discount
    [Arguments]     ${product_name}
    ${found_discount}   Run keyword and return status    productcard_page.Verify product has percent discount  ${product_name}
    Should not be true      ${found_discount}

Verify product quantity at product card not equal
    [Arguments]     ${product}      ${quantity}
    ${qty_input_locator}    String.Replace string    ${productcard_page.qty_input}    {{product}}    ${product}
    IF   "${platform}" == "${platform_list['android']}"
        ${qty_show}=    DobbyAppCommon.Get text from element when ready        ${qty_input_locator}
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        ${qty_show}=    AppiumLibrary.Get element attribute        ${qty_input_locator}       value
    END
    Should not be equal    ${qty_show}       ${quantity}

Verify toast add to basket successfully
    DobbyAppCommon.Wait until element is visible except stale       ${productcard_page.toast_success_add}
    AppiumLibrary.Wait until page does not contain element       ${productcard_page.toast_success_add}     timeout=${short_timeout}

Click add to basket on add to basket modal
    [Arguments]  ${count}
    DobbyAppCommon.Wait until element is visible except stale   ${productcard_page.title_select_qty}  
    ${btn_add_to_basket_locator}    String.Replace string    ${productcard_page.btn_add_item_to_basket}    {{count}}    ${count}
    DobbyAppCommon.Tap element when ready       ${btn_add_to_basket_locator}

# Android

Verify product price at product card in promotion
    [Documentation]     This KW for product card on "Promotion" section
    [Arguments]     ${productname}  ${original}    ${discount}=0
    ${productname_locator}      String.Replace string    ${productcard_page.txt_original}    {{productname}}    ${productname}
    ${txt_original_locator}      String.Replace string    ${productcard_page.txt_original}    {{original}}    ${original}
    Run Keyword If      '${discount}'== '0'     DobbyAppCommon.Wait until element is visible except stale   ${txt_original_locator}
    Run Keyword If      '${discount}'!= '0'     productcard_page.Check product price with discount at product card in promotion   ${productname}  ${original}    ${discount}

Check product price with discount at product card in promotion
    [Documentation]     This KW for product card on "Promotion" section
    [Arguments]     ${productname}  ${original}    ${discount}
    ${productname_locator}      String.Replace string    ${productcard_page.item_gid_original}    {{productname}}    ${productname}
    ${item_gid_original_locator}      String.Replace string    ${productname_locator}    {{original}}    ${original}
    ${productname_locator}      String.Replace string    ${productcard_page.item_gid_discount}    {{productname}}    ${productname}
    ${item_gid_discount_locator}      String.Replace string    ${productname_locator}    {{discount}}    ${discount}
    DobbyAppCommon.Wait until element is visible except stale   ${item_gid_original_locator}
    DobbyAppCommon.Wait until element is visible except stale   ${item_gid_discount_locator}

Check product price with discount at product card
    [Documentation]     This KW for product card on "PLP" section
    [Arguments]     ${productname}  ${original}    ${discount}
    ${productname_locator}      String.Replace string    ${productcard_page.item_gid_list_item_price_original}    {{productname}}    ${productname}
    ${item_gid_original_locator}      String.Replace string    ${productname_locator}    {{original}}    ${original}
    ${productname_locator}      String.Replace string    ${productcard_page.item_gid_list_item_price_discount}    {{productname}}    ${productname}
    ${item_gid_discount_locator}      String.Replace string    ${productname_locator}    {{discount}}    ${discount}
    DobbyAppCommon.Wait until element is visible except stale   ${item_gid_original_locator}
    DobbyAppCommon.Wait until element is visible except stale   ${item_gid_discount_locator}

# iOS

Verify product display on product card page
    [Arguments]    ${product}
    ${product_locator}      String.Replace string    ${productcard_page.product}    {{product}}    ${product}
    ${element_status}=      Run keyword and return status    DobbyAppCommon.Wait until element is visible except stale      ${product_locator}     timeout=3s
    Should be true      ${element_status}   msg='Unable to find product on this list [${product}]'
    
Verify product quantity at product card in PLP
    [Arguments]     ${product}      ${quantity}
    ${productname_locator}      String.Replace string    ${productcard_page.increment_btn_wrapper_quantity}    {{product}}    ${product}
    ${increment_btn_wrapper_quantity_locator}      String.Replace string    ${productname_locator}    {{quantity}}    ${quantity}
    DobbyAppCommon.Wait until element is visible except stale       ${productname_locator}

Verify product display all slab prices type
    [Arguments]   ${slab_price_1}  ${slab_price_2}=${False}   ${slab_price_3}=${False} 
    ${slab_price_locator_1}    String.Replace string    ${productcard_page.slab_price_list}     {{slab_price}}    ${slab_price_1}
    DobbyAppCommon.Find element    ${slab_price_locator_1}  scroll_panel=${default_scroll_view} 
    IF  '${slab_price_2}'!='False'
        ${slab_price_locator_2}    String.Replace string   ${productcard_page.slab_price_list_under}     {{slab_price}}    ${slab_price_2}
        DobbyAppCommon.Find element    ${slab_price_locator_2}  scroll_panel=${default_scroll_view} 
        IF  '${slab_price_3}' != 'False'
            ${slab_price_locator_3}    String.Replace string   ${productcard_page.slab_price_list_under}     {{slab_price}}    ${slab_price_3}
            DobbyAppCommon.Find element    ${slab_price_locator_3}  scroll_panel=${default_scroll_view} 
        END
    END
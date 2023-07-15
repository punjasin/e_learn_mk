*** Settings ***
Resource        ../../../resources/locators/${platform}/favourite_locator.resource
Resource        ../../../resources/locators/${platform}/common_locator.resource
Resource        ../pages/favourite_page.resource
Resource        ../../../common/mobile/mobile_common.resource

*** Keywords ***
User location should be list detail of list
    [Arguments]     ${listname}
    IF   "${platform}" == "${platform_list['android']}"
        DobbyAppCommon.Wait until element is visible except stale   ${favourite_detail.my_favourite_viewgroup}   ## back button
        DobbyAppCommon.Wait until element is visible except stale   ${favourite_detail.my_favourite}
        favourite_detail_page.List display list name on list detail    ${listname}
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        DobbyAppCommon.Wait until element is visible except stale   ${favourite_detail.my_favourite}
        ${txt_listname_locator}    String.Replace string    ${favourite_detail.txt_listname}    {{listname}}    ${listname}
        DobbyAppCommon.Wait until element is visible except stale   ${txt_listname_locator} 
    END

Swipe left on product list for delete
    [Arguments]     ${listname}
    IF   "${platform}" == "${platform_list['android']}"
        ${txt_listname_locator}    String.Replace string    ${favourite_detail.txt_listname}    {{listname}}    ${listname}
        DobbyAppCommon.Wait until element is visible except stale    ${txt_listname_locator}
        ${1pos}=    Get Element Location    ${txt_listname_locator}
        Swipe   500      ${1pos}[y]      ${1pos}[x]     ${1pos}[y]     #swipe left
        DobbyAppCommon.Wait until element is visible except stale    ${favourite_detail.txt_delete}
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        ${txt_label_listname_locator}    String.Replace string    ${favourite_detail.txt_label_listname}    {{listname}}    ${listname}
        mobile_common.Swipe left to right  ${txt_label_listname_locator}
        DobbyAppCommon.Wait until element is visible except stale      ${favourite_detail.txt_delete}        
    END

Click delete product button on list detail page
    [Arguments]     ${productname}
    DobbyAppCommon.Tap element when ready   ${favourite_detail.txt_delete}
    favourite_detail_page.Verify modal confirm delete product from list display    ${productname}

List detail display product
    [Arguments]     ${productname}
    IF   "${platform}" == "${platform_list['android']}"
        ${txt_productname_locator}    String.Replace string    ${favourite_detail.txt_productname}    {{productname}}    ${productname}
        DobbyAppCommon.Wait until element is visible except stale   ${txt_productname_locator}
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        ${productname_locator}    String.Replace string    ${favourite_detail.productname}    {{productname}}    ${productname}
        DobbyAppCommon.Wait until element is visible except stale   ${productname_locator}         
    END

Type product quantity on list
    [Arguments]     ${productname}      ${productqty}
    IF   "${platform}" == "${platform_list['android']}"
        favourite_detail_page.Get product row on list detail from product name     ${productname}
        ${qty_input_locator}    String.Replace string    ${favourite_detail.qty_input}    {{productcontent}}    ${productcontent}
        DobbyAppCommon.Tap element when ready     ${qty_input_locator}
        DobbyAppCommon.Wait until element is visible except stale       ${qty_input_locator}
        DobbyAppCommon.Input text to element when ready         ${qty_input_locator}      ${productqty}
        Press keycode   66   #Enter key
        mobile_common.Wait until loading complete
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        ${productname_locator}    String.Replace string    ${favourite_detail.productname_2}    {{productname}}    ${productname}
        DobbyAppCommon.Wait until element is visible except stale       ${productname_locator}
        DobbyAppCommon.Tap element when ready               ${productname_locator}
        AppiumLibrary.Tap with number of taps       ${productname_locator}      2       1
        DobbyAppCommon.Tap element when ready   ${favourite_detail.delete}
        DobbyAppCommon.Input text to element when ready            ${productname_locator}      ${productqty}
        mobile_common.Tap finish to hide keyboard        
    END

Verify modal confirm delete product from list display
    [Arguments]     ${productname}
    ${delete_product_list_locator}    String.Replace string    ${favourite_detail.delete_product_list}    {{productName}}    ${productname}
    DobbyAppCommon.Wait until element is visible except stale   ${favourite_detail.delete_list}
    DobbyAppCommon.Wait until element is visible except stale   ${delete_product_list_locator}

Confirm delete product on modal confirm delete product from list
    [Arguments]     ${productname}
    IF   "${platform}" == "${platform_list['android']}"
        DobbyAppCommon.Tap element when ready   ${favourite_detail.delete_item_in_list}
        favourite_page.List should not display on favourite list    ${productname}
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        DobbyAppCommon.Tap element when ready   ${favourite_detail.remove_this_list}
        favourite_page.List should not display on favourite list    ${productname}        
    END

Cancel delete product on modal confirm delete product from list
    DobbyAppCommon.Tap element when ready  ${favourite_detail.txt_cancel}

Toast message should display update remove product to list successful	
    mobile_common.Toast message should display and close   ${favourite_detail.this_product_delete_form_list}    

List detail should not display product
    [Arguments]     ${productname}
    IF   "${platform}" == "${platform_list['android']}"
        ${txt_productname_locator}    String.Replace string    ${favourite_detail.txt_productname}    {{productname}}    ${productname}
        AppiumLibrary.Wait until page does not contain element   ${txt_productname_locator}
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        ${productname_locator}    String.Replace string    ${favourite_detail.productname}    {{productname}}    ${productname}
        AppiumLibrary.Wait until page does not contain element   ${productname_locator}
    END

Click increase quantity button on list
    [Arguments]     ${productname}
    IF   "${platform}" == "${platform_list['android']}"
        favourite_detail_page.Get product row on list detail from product name     ${productname}
        ${btn_increase_quantity_locator}    String.Replace string    ${favourite_detail.btn_increase_quantity}    {{productcontent}}    ${productcontent}    
        DobbyAppCommon.Tap element when ready     ${btn_increase_quantity_locator}
        mobile_common.Wait until loading complete
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        ${btn_increase_quantity_locator}    String.Replace string    ${favourite_detail.btn_increase_quantity}    {{productname}}    ${productname}
        DobbyAppCommon.Tap element when ready     ${btn_increase_quantity_locator}
    END

Click decrease quantity button on list
    [Arguments]     ${productname}
    IF   "${platform}" == "${platform_list['android']}"
        favourite_detail_page.Get product row on list detail from product name     ${productname}
        ${btn_decrease_quantity_locator}    String.Replace string    ${favourite_detail.btn_decrease_quantity}    {{productcontent}}    ${productcontent}   
        DobbyAppCommon.Tap element when ready     ${btn_decrease_quantity_locator}
        mobile_common.Wait until loading complete
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        ${btn_decrease_quantity_locator}    String.Replace string    ${favourite_detail.btn_decrease_quantity}    {{productname}}    ${productname}
        DobbyAppCommon.Tap element when ready    ${btn_decrease_quantity_locator}
    END

List detail display empty
    IF   "${platform}" == "${platform_list['android']}"
        DobbyAppCommon.Wait until element is visible except stale   ${favourite_detail.favourite_item_list_empty}
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        DobbyAppCommon.Wait until element is visible except stale   ${favourite_detail.favourite_item_list_empty}   ${long_timeout} 
    END

List detail display product with quantity
    [Arguments]     ${productname}     ${productqty}=${1}
    ${productqty}             Convert to string        ${productqty}
    ${productname_locator}    String.Replace string    ${favourite_detail.product_qty}    {{productname}}    ${productname}
    ${qty}=        Convert to string     ${productqty}
    ${product_qty_locator}    String.Replace string    ${productname_locator}    {{productqty}}    ${qty}
    DobbyAppCommon.Wait until element is visible except stale  ${product_qty_locator}       timeout=${shortTimeout}

List detail display product with weight 
    [Arguments]     ${productname}      ${productweight}
    IF   "${platform}" == "${platform_list['android']}"
        favourite_detail_page.Get product row on list detail from product name      ${productname}
        ${productcontent_locator}    String.Replace string    ${favourite_detail.txt_product_weight}    {{productcontent}}    ${productcontent}
        ${txt_product_weight_locator}    String.Replace string    ${productcontent_locator}    {{productweight}}    ${productweight}
        DobbyAppCommon.Wait until element is visible except stale   ${txt_product_weight_locator}
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        ${productname_locator}    String.Replace string    ${favourite_detail.txt_product_weight}    {{productname}}    ${productname}
        ${txt_product_weight_locator}    String.Replace string    ${productcontent_locator}    {{productweight}}    ${productweight}
        DobbyAppCommon.Wait until element is visible except stale   ${txt_product_weight_locator}
    END

List detail display product with price 
    [Arguments]     ${productname}      ${productprice}
    IF   "${platform}" == "${platform_list['android']}"
        favourite_detail_page.Get product row on list detail from product name      ${productname}
        ${productcontent_locator}    String.Replace string    ${favourite_detail.txt_product_price}    {{productcontent}}    ${productcontent}
        ${txt_product_price_locator}    String.Replace string    ${productcontent_locator}    {{productprice}}    ${productprice}
        DobbyAppCommon.Wait until element is visible except stale   ${txt_product_price_locator}
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        ${productname_locator}    String.Replace string    ${favourite_detail.txt_product_price}    {{productname}}    ${productname}
        ${txt_product_price_locator}    String.Replace string    ${productcontent_locator}    {{productprice}}    ${productprice}
        DobbyAppCommon.Wait until element is visible except stale   ${txt_product_price_locator}
    END

List detail display product shipment on product
    [Arguments]     ${productname}   ${shipment}
    IF   "${platform}" == "${platform_list['android']}"
        Get product row on list detail from product name  ${productname}
        ${productcontent_locator}    String.Replace string    ${favourite_detail.shipment_productname}    {{productcontent}}    ${productcontent}
        ${shipment_productname_locator}    String.Replace string    ${productcontent_locator}    {{shipment}}    ${shipment}
        DobbyAppCommon.Wait until element is visible except stale   ${shipment_productname_locator}
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        ${shipment_locator}    String.Replace string    ${favourite_detail.shipment_productname}    {{shipment}}    ${shipment}
        ${shipment_productname_locator}    String.Replace string    ${shipment_locator}    {{productname}}    ${productname}
        DobbyAppCommon.Wait until element is visible except stale   ${shipment_productname_locator}
    END

Click add all product to basket button
    IF   "${platform}" == "${platform_list['android']}"
        favourite_detail_page.Verify add all product to basket button should enable
        DobbyAppCommon.Tap element when ready     ${favourite_detail.txt_add_all_product_to_basket}
        basket_page.Toast message should display add all product to basket successful	
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        DobbyAppCommon.Tap element when ready      ${favourite_detail.txt_back_add_all_product_to_basket}
    END

Verify add all product to basket button should disable
    IF   "${platform}" == "${platform_list['android']}"
        Element attribute should match      ${favourite_detail.txt_back_add_all_product_to_basket}    clickable   True
        Element attribute should match      ${favourite_detail.txt_back_add_all_product_to_basket}    enabled     False
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        Element attribute should match      ${favourite_detail.txt_back_add_all_product_to_basket}    enabled     False
    END

Verify product in non support zipcode area
    [Arguments]     ${product}
    IF   "${platform}" == "${platform_list['android']}"
        ${out_of_area_locator}    String.Replace string    ${favourite_detail.out_of_area}    {{product}}    ${product}
        DobbyAppCommon.Wait until element is visible except stale       ${out_of_area_locator}
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        ${favourite_item_list_item_gid_locator}    String.Replace string    ${favourite_detail.favourite_item_list_item_gid}    {{product}}    ${product}
        DobbyAppCommon.Wait until element is visible except stale       ${favourite_item_list_item_gid_locator}
    END

Verify product not in non support zipcode area
    [Arguments]     ${product}
    IF   "${platform}" == "${platform_list['android']}"
        ${out_of_area_locator}    String.Replace string    ${favourite_detail.out_of_area}    {{product}}    ${product}
        AppiumLibrary.Page should not contain element       ${out_of_area_locator}
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        ${favourite_item_list_item_gid_locator}    String.Replace string    ${favourite_detail.favourite_item_list_item_gid}    {{product}}    ${product}
        AppiumLibrary.Page should not contain element       ${favourite_item_list_item_gid_locator}
    END

# Android

List display list name on list detail
    [Arguments]     ${listname}     
    ${txt_listname_locator}    String.Replace string    ${favourite_detail.txt_listname}    {{listname}}    ${listname}
    DobbyAppCommon.Wait until element is visible except stale   ${txt_listname_locator}  

Click back from detail page
    DobbyAppCommon.Tap element when ready   ${favourite_detail.my_favourite_viewgroup}   ## back button

Click edit list name button on detail page
    [Arguments]     ${listname}
    ${txt_listname_viewgroup_locator}    String.Replace string    ${favourite_detail.txt_listname_viewgroup}    {{listname}}    ${listname}
    DobbyAppCommon.Tap element when ready     ${txt_listname_viewgroup_locator}

Modal edit favourite list should display
    [Arguments]     ${originalname}
    DobbyAppCommon.Wait until element is visible except stale   ${favourite_detail.edit_listname}
    ${listname_header_locator}    String.Replace string    ${favourite_detail.listname_header}    {{originalname}}    ${originalname}
    Element should be visible   ${listname_header_locator}
    Element should be visible   ${favourite_detail.specify_up_characters}
    Element should be visible   ${favourite_detail.txt_update}      

Verify update button on modal edit favourite list should disable
    Element attribute should match   ${favourite_detail.back_txt_update}      clickable   True
    Element attribute should match   ${favourite_detail.back_txt_update}      enabled     False

Click update button on on modal edit favourite list
    DobbyAppCommon.Tap element when ready   ${favourite_detail.txt_update}  

Click exit button on modal edit favourite list
    DobbyAppCommon.Tap element when ready   ${favourite_detail.edit_listname_viewgroup}

Toast message should display update list successful
    mobile_common.Toast message should display and close   ${favourite_detail.list_has_been_updated}

Click delete list button on detail page
    [Arguments]     ${listname}
    ${listname_viewgroup_locator}    String.Replace string    ${favourite_detail.listname_viewgroup}    {{listname}}    ${listname}
    DobbyAppCommon.Tap element when ready     ${listname_viewgroup_locator}

Get product row on list detail from product name
    [Arguments]     ${productname}
    favourite_detail_page.List detail display product     ${productname}
    ${favourite_item_list_item_locator}    String.Replace string    ${favourite_detail.favourite_item_list_item_}    {{productname}}    ${productname}
    ${productcontent}=  AppiumLibrary.Get Element Attribute      ${favourite_item_list_item__locator}     content-desc
    log     ${productcontent}
    Set test variable    ${productcontent}    

Click trash button on list
    [Arguments]     ${productname}
    ${trash_btn_icon_locator}    String.Replace string    ${favourite_detail.trash_btn_icon}    {{productname}}    ${productname}
    DobbyAppCommon.Tap element when ready     ${trash_btn_icon_locator}
    mobile_common.Wait until loading complete

Verify add all product to basket button should enable
    Element attribute should match      ${favourite_detail.txt_back_add_all_product_to_basket}    clickable   True
    Element attribute should match      ${favourite_detail.txt_back_add_all_product_to_basket}    enabled     True

Verify blank list state
    DobbyAppCommon.Wait until element is visible except stale       ${favourite_detail.noItems}
    DobbyAppCommon.Wait until element is visible except stale       ${favourite_detail.noItemInList}

Verify find product from category button should display
    DobbyAppCommon.Wait until element is visible except stale  ${favourite_detail.txt_search_form_category}

# iOS

Tap delete list button on detail page
    [Arguments]     ${listname}
    ${last_listname_locator}    String.Replace string    ${favourite_detail.last_listname}    {{listname}}    ${listname}
    DobbyAppCommon.Tap element when ready      ${last_listname_locator}
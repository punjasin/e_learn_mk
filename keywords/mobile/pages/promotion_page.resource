*** Settings ***
Resource        ../../../resources/locators/${platform}/promotion_locator.resource
Resource        ../../../resources/locators/${platform}/common_locator.resource
Resource        ../../../common/mobile/mobile_common.resource

*** Keywords ***
Scroll to promotion section
    IF   "${platform}" == "${platform_list['android']}"
        ${pos}=    Run keyword and return status        DobbyAppCommon.Wait until element is visible except stale       ${promotion.promotion_list_container}        timeout=${short_timeout}
        IF  '${pos}'=='False'
            ${pos2}=    Run keyword and return status        DobbyAppCommon.Wait until element is visible except stale       ${promotion.fresh_list_container}        timeout=${short_timeout}
            IF  ${pos2}
                mobile_common.Find element  ${promotion.ourassortment}  Top  True
            ELSE
                mobile_common.Find element  ${promotion.promotion_list_title}  Bottom  True
            END
        END
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        ${pos}=    Run keyword and return status        DobbyAppCommon.Wait until element is visible except stale       ${promotion.icon_button}        timeout=${short_timeout}
        IF  '${pos}'=='False'
            ${pos2}=    Run keyword and return status        DobbyAppCommon.Wait until element is visible except stale       ${promotion.fresh_list_container}        timeout=${short_timeout}
            IF  ${pos2}
                mobile_common.Find element  ${promotion.icon_button}  Top  True
            ELSE
                mobile_common.Find element  ${promotion.latest_promotion}  Bottom  True
            END
        END   
    END

Select first product in promotion module to enable recommendation
    IF   "${platform}" == "${platform_list['android']}"
        Select product in promotion module      ${product_data['promotion']['product_nodiscount']}
        mobile_common.Tap shopping menu
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        DobbyAppCommon.Wait until element is visible except stale  ${promotion.promotion_typeother}
        DobbyAppCommon.Tap element when ready  ${promotion.promotion_typeother}
        mobile_common.Tap shopping menu    
    END

Swipe right in promotion module until find product
    [Arguments]     ${product}
    IF   "${platform}" == "${platform_list['android']}"
        ${add_to_cart_gid_locator}    String.Replace string    ${promotion.add_to_cart_gid}    {{product}}    ${product}
        ${1pos}=    Get Element Location    ${promotion.latest_promotion}
        FOR     ${i}    IN RANGE    15
            ${status}       Run keyword and return status       DobbyAppCommon.Wait until element is visible except stale   ${add_to_cart_gid_locator}      timeout=${short_timeout}
            Exit for loop if    ${status}
            Swipe   500      ${1pos}[y]      ${1pos}[x]     ${1pos}[y]     #swipe left
        END
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        ${1pos}=    Get Element Location    ${promotion.promotion_scrollview}
        FOR     ${i}    IN RANGE    15
            # ${getsize_basket} =   AppiumLibrary.Get Element Size          chain=**/XCUIElementTypeOther[`name=="promotion_list_container"`]/**/XCUIElementTypeScrollView     #not ready to implement due to makroclick migration
            # ${getcoor_basket} =   Get element location      chain=**/XCUIElementTypeOther[`name=="promotion_list_container"`]/**/XCUIElementTypeScrollView
            # ${center_x}   Evaluate    ${getcoor_basket['x']}+${getsize_basket['width']}/2
            # ${center_y}   Evaluate    ${getcoor_basket['y']}+${getsize_basket['height']}/2
            # ${new_y}      Evaluate    ${center_y}/1.5
            # Swipe         ${center_x}  ${center_y}  ${center_x}  ${new_y}
            ${product_item_gid_locator}    String.Replace string    ${promotion.product_item_gid}    {{productname}}    ${productname}
            ${status}       Run keyword and return status       DobbyAppCommon.Wait until element is visible except stale   ${product_item_gid_locator}      timeout=${short_timeout}
            Exit for loop if    ${status}
            Swipe   500      ${1pos}[y]      ${1pos}[x]     ${1pos}[y]     #swipe left
        END
    END    

Swipe left in promotion module until find product
    [Arguments]     ${product}
    IF   "${platform}" == "${platform_list['android']}"
        ${1pos}=    Get Element Location    ${promotion.latest_promotion}
        ${add_to_cart_gid_locator}    String.Replace string    ${promotion.add_to_cart_gid}    {{product}}    ${product}
        FOR     ${i}    IN RANGE    15
            ${status}       Run keyword and return status       DobbyAppCommon.Wait until element is visible except stale   ${add_to_cart_gid_locator}      timeout=${short_timeout}
            Exit for loop if    ${status}
            Swipe   ${1pos}[x]      ${1pos}[y]      500     ${1pos}[y]     #swipe left
        END
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        ${1pos}=    Get Element Location    ${promotion.promotion_scrollview}
        ${product_item_gid_locator}    String.Replace string    ${promotion.product_item_gid}    {{productname}}    ${productname}
        FOR     ${i}    IN RANGE    15
            # ${getsize_basket} =   AppiumLibrary.Get Element Size          chain=**/XCUIElementTypeOther[`name=="promotion_list_container"`]/**/XCUIElementTypeScrollView     #not ready to implement due to makroclick migration
            # ${getcoor_basket} =   Get element location      chain=**/XCUIElementTypeOther[`name=="promotion_list_container"`]/**/XCUIElementTypeScrollView
            # ${center_x}   Evaluate    ${getcoor_basket['x']}+${getsize_basket['width']}/2
            # ${center_y}   Evaluate    ${getcoor_basket['y']}+${getsize_basket['height']}/2
            # ${new_y}      Evaluate    ${center_y}/1.5
            # Swipe         ${center_x}  ${center_y}  ${center_x}  ${new_y}
            ${status}       Run keyword and return status       DobbyAppCommon.Wait until element is visible except stale   ${product_item_gid_locator}      timeout=${short_timeout}
            Exit for loop if    ${status}
            Swipe   ${1pos}[x]      ${1pos}[y]      500     ${1pos}[y]     #swipe left
        END    
    END
    
Select product in promotion module
    [Arguments]     ${productname}
    IF   "${platform}" == "${platform_list['android']}"
        ${latest_promotion_productname_locator}    String.Replace string    ${promotion.latest_promotion_productname}    {{productname}}    ${productname}
        DobbyAppCommon.Tap element when ready         ${latest_promotion_productname_locator}
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        ${product_item_gid_locator}    String.Replace string    ${promotion.product_item_gid}    {{productname}}    ${productname}
        DobbyAppCommon.Tap element when ready   ${product_item_gid_locator}
    END

Click add to basket at promotion module
    [Arguments]     ${productname}
    IF   "${platform}" == "${platform_list['android']}"
        ${icon_button_locator}    String.Replace string    ${promotion.icon_button}    {{productname}}    ${productname}
        DobbyAppCommon.Tap element when ready    ${icon_button_locator}
        mobile_common.Wait until loading complete
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        ${add_to_cart_gid_locator}    String.Replace string    ${promotion.add_to_cart_gid}    {{productname}}    ${productname}
        DobbyAppCommon.Tap element when ready    ${add_to_cart_gid_locator}
        mobile_common.Wait until loading complete
    END

Verify promotion section display
    IF   "${platform}" == "${platform_list['android']}"
        DobbyAppCommon.Wait until element is visible except stale   ${promotion.promotion_list_container}
        DobbyAppCommon.Wait until element is visible except stale   ${promotion.promotion_list_title}
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        DobbyAppCommon.Wait until element is visible except stale   ${promotion.promotion_list_container}
        DobbyAppCommon.Wait until element is visible except stale   ${promotion.latest_promotion}
    END

Click see all button
    DobbyAppCommon.Tap element when ready   ${promotion.view_all}
    mobile_common.Wait until loading complete
    DobbyAppCommon.Wait until element is visible except stale   ${promotion.txt_latest_promotion}

Click back icon to homepage
    IF   "${platform}" == "${platform_list['android']}"
        DobbyAppCommon.Tap element when ready   ${promotion.searchinput}
        mobile_common.Wait until loading complete
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        DobbyAppCommon.Tap element when ready   ${promotion.search_cancel}
        mobile_common.Wait until loading complete
    END

Product position on promotion should be
    [Arguments]     ${productname}     ${position}
    IF   "${platform}" == "${platform_list['android']}"
        ${product_item_gid_1_locator}    String.Replace string    ${promotion.product_item_gid_1}    {{position}}    ${position}
        ${product_item_gid_2_locator}    String.Replace string    ${promotion.product_item_gid_2}    {{position}}    ${position}
        DobbyAppCommon.Wait until element is visible except stale       ${product_item_gid_2_locator}
        Element Attribute Should Match      ${product_item_gid_1_locator}     text    ${productname} 
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        DobbyAppCommon.Wait until element is visible except stale  ${promotion.product_item_gid_1}
        ${product_item_gid_2_locator}    String.Replace string    ${promotion.product_item_gid_2}    {{position}}    ${position}
        ${valid_position}=    Run keyword and return status     Element Attribute Should Match  ${product_item_gid_2_locator}     label    ${productname}     
    END

# Android

Swipe right in promotion module
    ${1pos}=    Get Element Location    ${promotion.latest_promotion}
    Swipe   500      ${1pos}[y]      ${1pos}[x]     ${1pos}[y]     #swipe left

Verify product should be display on last promotion
    [Arguments]     ${productname}
    ${product}    String.Replace string    ${promotion.latest_promotion_productname}    {{productname}}    ${productname}
    mobile_common.Find element       ${product}

Tap product in last promotion by sequent
    [Arguments]     ${sequent}
    ${product_sequent}    String.Replace string    ${promotion.product_item_gid}    {{sequent}}    ${sequent}
    DobbyAppCommon.Find element      ${product_sequent}   scroll_panel=${promotion.promotion_list}    moveto=Left    percent=${swipeLongScroll}      timeout=${shortTimeout}
    DobbyAppCommon.Tap element when ready   ${product_sequent}
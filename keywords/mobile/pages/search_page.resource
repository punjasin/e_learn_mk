*** Settings ***
Resource        ../../../resources/locators/${platform}/search_locator.resource
Resource        ../../../resources/locators/${platform}/common_locator.resource
Resource        ../../../resources/locators/${platform}/banner_locator.resource
Resource        ../../../common/mobile/mobile_common.resource

*** Keywords ***
Click to interact with searchbar
    search_page.Activate searchbar
    IF   "${platform}" == "${platform_list['android']}"
        DobbyAppCommon.Wait until element is visible except stale     ${search_page.input_search}
        DobbyAppCommon.Clear text when ready          ${search_page.input_search}
        AppiumLibrary.Click element       ${search_page.input_search_placeholder}
    ELSE IF   "${platform}" == "${platform_list['ios']}"
        Sleep  2s   # wait for animation  
        DobbyAppCommon.Clear text when ready        ${search_advance.input_search}
        DobbyAppCommon.Tap element when ready               ${search_advance.input_search}  
    END

Search for product with searchbar
    [Arguments]    ${wording}
    Wait until keyword succeeds   3x  1s        search_page.Activate searchbar
    DobbyAppCommon.Input text to element when ready     ${search_advance.input_search}    ${wording}
    mobile_common.Press enter on keyboard

Activate searchbar
    [Documentation]    use with home page because appium can't interact with search input and need to use banner locator
    ${found_banner_carousel}    Run keyword and return status     DobbyAppCommon.Wait until element is visible except stale     ${banner.content_carousel_item_}    timeout=${short_timeout}
    IF    ${found_banner_carousel}==${True}
        ${carousel_size}    AppiumLibrary.Get element size    ${banner.content_carousel_item_}
        ${searchbar_height}      Evaluate    int(0.225*${carousel_size['height']})
        ${searchbar_width}       Evaluate    int(0.5*${carousel_size['width']})
        @{searchbar_position}    Create list    ${searchbar_width}    ${searchbar_height}
        @{click_position}	     Create list	${searchbar_position}	${searchbar_position}	
        AppiumLibrary.Tap with positions    ${1000}    @{click_position}
    END
    DobbyAppCommon.Wait until element is visible except stale    ${search_page.input_search}

Increase quantity at search results
    [Arguments]     ${product}      ${number}=1
    ${increment_btn_wrapper_locator}    String.Replace string    ${search_page.increment_btn_wrapper}    {{product}}    ${product}
    IF   "${platform}" == "${platform_list['android']}"
        FOR     ${round}    IN RANGE    ${number}    
            DobbyAppCommon.Tap element when ready    ${increment_btn_wrapper_locator}
            mobile_common.Wait until loading complete
        END
    ELSE IF   "${platform}" == "${platform_list['ios']}"
        FOR    ${i}    IN RANGE    ${number}
            DobbyAppCommon.Tap element when ready    ${increment_btn_wrapper_locator}
        END    
    END

Adjust quantity by typing quantity at search results
    [Arguments]     ${product}      ${quantity}  
    IF   "${platform}" == "${platform_list['android']}"
        DobbyAppCommon.Wait until element is visible except stale       ${search_page.qty_input}
        Sleep       2s
        DobbyAppCommon.Tap element when ready    ${search_page.qty_input}
        Typing product quantity     ${product}      ${quantity} 
    ELSE IF   "${platform}" == "${platform_list['ios']}"
        ${product_item_gid_qty_input_locator}    String.Replace string    ${search_page.product_item_gid_qty_input}    {{product}}    ${product}
        DobbyAppCommon.Tap element when ready    ${product_item_gid_qty_input_locator}
        DobbyAppCommon.Clear text when ready       ${product_item_gid_qty_input_locator}
        DobbyAppCommon.Input text to element when ready     ${product_item_gid_qty_input_locator}    ${quantity}
        DobbyAppCommon.Tap element when ready      ${search_page.success}
    END

Verify product out of stock alert display
    IF   "${platform}" == "${platform_list['android']}"
        Wait until page contains      ${search_additional['label']['replenished_soon']}
    ELSE IF   "${platform}" == "${platform_list['ios']}"
        DobbyAppCommon.Wait until element is visible except stale      ${search_page.replenished_soon}   ${global_timeout}
    END

Verify product not appear
    AppiumLibrary.Page should not contain element        ${search_page.product_from_suspended_shop}

Search page display searching not found
    [Arguments]     ${searching}
    ${no_result_locator}    String.Replace string    ${search_page.no_result}    {{searching}}    ${searching}
    IF   "${platform}" == "${platform_list['android']}"
        mobile_common.wait until loading complete
        DobbyAppCommon.Wait until element is visible except stale   ${no_result_locator}
    ELSE IF   "${platform}" == "${platform_list['ios']}"
        DobbyAppCommon.Wait until element is visible except stale  ${no_result_locator}
    END

Click search from category button
    IF   "${platform}" == "${platform_list['android']}"
        DobbyAppCommon.Hide keyboard until success
        DobbyAppCommon.Tap element when ready  ${search_page.txt_search_from_product_category}
    ELSE IF   "${platform}" == "${platform_list['ios']}"
        DobbyAppCommon.Tap element when ready  ${search_page.txt_search_from_product_category}
    END

Click try to search different button
    IF   "${platform}" == "${platform_list['android']}"
        DobbyAppCommon.Hide keyboard until success
        DobbyAppCommon.Tap element when ready  ${search_page.txt_please_search_agin_by_new_keyword}
    ELSE IF   "${platform}" == "${platform_list['ios']}"
        DobbyAppCommon.Tap element when ready  ${search_page.txt_please_search_agin_by_new_keyword}
    END

Verify keyboard show up
    IF   "${platform}" == "${platform_list['android']}"
        ${status_keyboard}=   Run Keyword And Return Status   Is keyboard shown
        Should be equal     ${status_keyboard}      ${true}
    ELSE IF   "${platform}" == "${platform_list['ios']}"
        ${status_keyboard}=   Run Keyword And Return Status   Is keyboard shown
        Should be equal     ${status_keyboard}      ${true}
    END

Adjust quantity by typing quantity after search
    [Arguments]     ${product}      ${quantity}  
    IF   "${platform}" == "${platform_list['android']}"
        ${qty_input_locator}    String.Replace string    ${search_page.qty_input}    {{product}}    ${product}
        DobbyAppCommon.Wait until element is visible except stale       ${qty_input_locator}
        Sleep       2s    #wait animation
        search_page.Typing product quantity     ${product}      ${quantity} 
    ELSE IF   "${platform}" == "${platform_list['ios']}"
        ${product_item_gid_qty_input_locator}    String.Replace string    ${search_page.qty_input_after_search}    {{product}}    ${product}
        DobbyAppCommon.Tap element when ready    ${product_item_gid_qty_input_locator}
        DobbyAppCommon.Clear text when ready       ${product_item_gid_qty_input_locator}
        DobbyAppCommon.Input text to element when ready     ${product_item_gid_qty_input_locator}    ${quantity}
        DobbyAppCommon.Tap element when ready      ${search_page.success}
    END
    
# Android

Typing product quantity
    [Arguments]     ${product}      ${quantity} 
    ${qty_input_locator}    String.Replace string    ${search_page.qty_input}    {{product}}    ${product}
    DobbyAppCommon.Input text to element when ready      ${qty_input_locator}      ${quantity}

Lower quantity at search results
    [Arguments]    ${product}
    ${decrement_btn_wrapper_locator}    String.Replace string    ${search_page.decrement_btn_wrapper}    {{product}}    ${product}
    DobbyAppCommon.Tap element when ready    ${decrement_btn_wrapper_locator}
    mobile_common.Wait until loading complete

Click product image
    [Arguments]    ${product}
    ${product_image_locator}    String.Replace string    ${search_page.product_image}    {{product}}    ${product}
    DobbyAppCommon.Tap element when ready    ${product_image_locator}

Post search dynamic data
    [Arguments]    ${payload_key}
    ${resp}     RequestsLibrary.Post    ${search_api['endpoint']}      json=${search_api['payload']['${payload_key}']} 
    [Return]    ${resp.json()['hits'][0]['document']['title']}

# iOS
Typing product quantity ios
    [Arguments]     ${quantity}
    FOR    ${i}    IN RANGE    10
        ${element_status}=      Run keyword and return status    DobbyAppCommon.Wait until element is visible except stale      ${search_page.qty_input}      timeout=2s
        IF  '${element_status}'=='False'     
            DobbyAppCommon.Swipe down
        ELSE
            Exit for loop
        END
    END
    DobbyAppCommon.Input text to element when ready      ${search_page.qty_input}     ${quantity}

Select main category
    [Arguments]    ${category}
    ${category_last_locator}    String.Replace string    ${search_page.category_last}    {{category}}    ${category}
    ${Top_status}=      Run keyword and return status    DobbyAppCommon.Wait until element is visible except stale     ${category_last_locator}      timeout=5s
    IF  '${Top_status}'=='False'     DobbyAppCommon.Swipe up
    FOR    ${i}    IN RANGE    5
        ${element_status}=      Run keyword and return status    DobbyAppCommon.Wait until element is visible except stale      ${category_last_locator}     timeout=2s
        IF  '${element_status}'=='False'
            DobbyAppCommon.Swipe down
        ELSE
            Exit for loop
        END
    END
    DobbyAppCommon.Tap element when ready   ${category_last_locator}

Verify access main category
    [Arguments]    ${category}
    ${category_locator}    String.Replace string    ${search_page.category}     {{category}}    ${category}
    DobbyAppCommon.Wait until element is visible except stale   ${category_locator}

Select sub category
    [Arguments]    ${category}
    ${category_locator}    String.Replace string    ${search_page.category_1}     {{category}}    ${category}
    FOR    ${i}    IN RANGE    5
        ${element_status}=      Run keyword and return status    DobbyAppCommon.Wait until element is visible except stale      ${category_locator}      timeout=3s
        IF  '${element_status}'=='False'
            DobbyAppCommon.Swipe down
        ELSE
            Exit for loop
        END
    END
    DobbyAppCommon.Tap element when ready  ${category_locator}

Go back to main category
    DobbyAppCommon.Tap element when ready  ${search_page.cancel_last}

Select product
    [Arguments]    ${product}
    Sleep   2s
    DobbyAppCommon.Wait until element is visible except stale        ${search_page.scrollview}     #Wait for content to load   
    ${product_locator}    String.Replace string    ${search_page.product}     {{product}}    ${product}
    FOR    ${i}    IN RANGE    10
        ${element_status}=      Run keyword and return status    DobbyAppCommon.Wait until element is visible except stale      ${product_locator}      timeout=2s
        IF  '${element_status}'=='False'     DobbyAppCommon.Swipe down
        Exit for loop if    '${element_status}'=='True'
    END
    DobbyAppCommon.Tap element when ready  ${product_locator}
    DobbyAppCommon.Wait until element is visible except stale        ${search_page.bonus_plam_oil}

Tap product quantity
    DobbyAppCommon.Tap element when ready    ${search_page.qty_input}

Verify product quantity at PLP
    [Arguments]     ${quantity}
    ${att}=  mobile_common.Get element attribute when ready  ${search_page.qty_input}  value
    Should Be Equal   '${quantity}'   '${att}'

Decrease quantity at search results
    [Arguments]     ${product}      ${round}=1
    ${decrement_btn_wrapper_locator}    String.Replace string    ${search_page.decrement_btn_wrapper}     {{product}}    ${product}
    FOR    ${i}    IN RANGE    ${round}
        DobbyAppCommon.Tap element when ready    ${decrement_btn_wrapper_locator}
    END

Tap back button
    DobbyAppCommon.Tap element when ready   ${search_page.cancel_typeother}
    
Tap cancel label
    DobbyAppCommon.Tap element when ready    ${search_page.cancel}

Verify product out of stock tag display on PLP
    [Arguments]     ${product}
    ${out_of_stock_locator}    String.Replace string    ${search_page.out_of_stock}     {{product}}    ${product}
    DobbyAppCommon.Wait until element is visible except stale      ${out_of_stock_locator}

Scroll to top of search page
    mobile_common.Find element  ${search_page.type_image}  Bottom

Get product price at search page
    [Arguments]    ${product}
    ${product_price_locator}    String.Replace string    ${search_page.product_price}     {{product}}    ${product}
    ${price}    AppiumLibrary.Get text    ${product_price_locator}
    [Return]    ${price}

Verify product show on search result page
    [Arguments]    ${product}
    ${product_locator}    String.Replace string    ${search_page.product_card}     {{product}}    ${product}
    DobbyAppCommon.Find element    ${product_locator}   scroll_panel=${default_scroll_view}    moveto=Top    percent=${swipeLongScroll}  timeout=${shortTimeout}


*** Settings ***
Resource        ../../../resources/locators/${platform}/basket_locator.resource
Resource        ../../../resources/locators/${platform}/common_locator.resource
Resource        ../../../common/mobile/mobile_common.resource
Resource        debug_page.resource

*** Keywords ***
Current page should be basket page
    DobbyAppCommon.Wait until element is visible except stale       ${basket.btn_basket}

Increase quantity by clicking at basket
    [Arguments]     ${productname}      ${number}=1
    IF   "${platform}" == "${platform_list['android']}"
        ${product_qty_locator}    String.Replace string    ${basket.product_qty}    {{productname}}    ${productname}
        ${product_increment_qty_locator}    String.Replace string    ${basket.product_increment_qty}    {{productname}}    ${productname}
        DobbyAppCommon.Find element      ${product_increment_qty_locator}   scroll_panel=${default_scroll_view}    moveto=Top    percent=${swipeShortScroll}      timeout=${shortTimeout}       
        ${original} =       DobbyAppCommon.Get text from element when ready    ${product_qty_locator}
        ${newqty}=    Evaluate   ${original}+${number}
        FOR     ${round}    IN RANGE    ${number}    
            Run keyword     DobbyAppCommon.Tap element when ready    ${product_increment_qty_locator}
            Run keyword     mobile_common.Wait until loading complete
        END 
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        # can’t inspec locator increase quantity button on ios
        ${increment_btn_wrapper_locator}    String.Replace string    ${basket.increment_btn_wrapper}    {{productname}}    ${productname}
        DobbyAppCommon.Find element      ${increment_btn_wrapper_locator}   scroll_panel=${default_scroll_view}    moveto=Top    percent=${swipeShortScroll}      timeout=${shortTimeout}
        FOR    ${i}    IN RANGE    ${number}
            DobbyAppCommon.Tap element when ready    ${increment_btn_wrapper_locator}
            mobile_common.Wait until loading complete
        END
    END

Get current qty amount
    [Arguments]     ${productname}
    ${product_qty_locator}    String.Replace string    ${basket.product_qty}    {{productname}}    ${productname}
    ${qty_amount}       DobbyAppCommon.Get text from element when ready    ${product_qty_locator}
    [Return]            ${qty_amount}

Decrease quantity by clicking at basket
    [Arguments]     ${productname}      ${number}=1
    IF   "${platform}" == "${platform_list['android']}"
        ${product_qty_locator}    String.Replace string    ${basket.product_qty}    {{productname}}    ${productname}
        ${product_decrement_qty_locator}    String.Replace string    ${basket.product_decrement_qty}    {{productname}}    ${productname}
        DobbyAppCommon.Find element      ${product_decrement_qty_locator}   scroll_panel=${default_scroll_view}    moveto=Top    percent=${swipeShortScroll}      timeout=${shortTimeout}
        ${original} =       DobbyAppCommon.Get text from element when ready    ${product_qty_locator}
        ${newqty}=       Evaluate    ${original}-${number}      
        FOR     ${round}    IN RANGE    ${number}    
            Run keyword     DobbyAppCommon.Tap element when ready    ${product_decrement_qty_locator}
            Run keyword     mobile_common.Wait until loading complete
        END
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        # can’t inspec locator decrement quantity button on ios and can't clear text on locator
        ${decrement_btn_wrapper_locator}    String.Replace string    ${basket.decrement_btn_wrapper}    {{productname}}    ${productname}
        DobbyAppCommon.Find element      ${decrement_btn_wrapper_locator}   scroll_panel=${default_scroll_view}    moveto=Top    percent=${swipeShortScroll}      timeout=${shortTimeout}
        FOR    ${i}    IN RANGE    ${number}
            DobbyAppCommon.Tap element when ready    ${decrement_btn_wrapper_locator}
            mobile_common.Wait until loading complete
        END
    END

Adjust quantity by typing at basket
    [Documentation]  type text infront of exist text in text field in iOS
    [Arguments]     ${productname}      ${qty}      
    IF   "${platform}" == "${platform_list['android']}"
        ${product_qty_input_locator}    String.Replace string    ${basket.txt_product_qty_input}    {{product}}    ${productname} 
        DobbyAppCommon.Tap element when ready        ${product_qty_input_locator}
        DobbyAppCommon.Input text to element when ready       ${product_qty_input_locator}        ${qty}
        Press keycode   66   #Enter key
        mobile_common.Wait until loading complete
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        ${increment_btn_wrapper_locator}    String.Replace string    ${basket.txt_product_qty_input}    {{product}}    ${productname}
        DobbyAppCommon.Tap element when ready           ${increment_btn_wrapper_locator}
        DobbyAppCommon.Clear text when ready    ${increment_btn_wrapper_locator}    
        DobbyAppCommon.Input text to element when ready         ${increment_btn_wrapper_locator}    ${qty}    
        DobbyAppCommon.Tap element when ready           ${basket.success}
        mobile_common.Wait until loading complete
    END

Close onboarding swipe to remove from basket
    [Documentation]  first time incart popup message
    DobbyAppCommon.Tap element when ready           ${basket.btn_close_popup_swipe_delete}

Verify product name is display
    [Arguments]     ${product_name}
    ${basket_name_locator}    String.Replace string    ${basket.txt_product_list}    {{productname}}    ${productname}
    DobbyAppCommon.Find element      ${basket_name_locator}   scroll_panel=${default_scroll_view}    moveto=Top    percent=${swipeShortScroll}      timeout=${shortTimeout}

Tap at product name
    [Arguments]     ${product_name}
    ${basket_name_locator}    String.Replace string    ${basket.txt_product_list}    {{productname}}    ${productname}
    DobbyAppCommon.Tap element when ready              ${basket_name_locator}

Verify product and quantity display in basket
    [Arguments]     ${productname}      ${expected_qty}=1
    ${basket_qty_locator}     String.Replace string    ${basket.txt_basket_qty}      {{productname}}    ${productname}
    DobbyAppCommon.Find element    ${basket_qty_locator}   scroll_panel=${default_scroll_view}    moveto=Top    percent=${swipeLongScroll}  timeout=${shortTimeout}
    basket_page.Verify product name is display         ${productname}
    IF   "${platform}" == "${platform_list['android']}"
        ${basket_qty}       DobbyAppCommon.Get text from element when ready     ${basket_qty_locator}
        Should be equal     '${basket_qty}'     '${expected_qty}'
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        ${basket_qty}       AppiumLibrary.Get element attribute     ${basket_qty_locator}   name
        Should be equal     '${basket_qty}'     '${expected_qty}'
    END

Verify product price in basket
    [Documentation]     Don't send ฿ in price for iOS
    [Arguments]     ${productname}      ${orignalprice}     ${discountprice}=${empty}       ${discountpercent}=${empty}
    IF   "${platform}" == "${platform_list['android']}"
        ${product_locator_1}    String.Replace string    ${basket.txt_orignal_price}    {{productname}}    ${productname}
        ${txt_orignal_price_locator}    String.Replace string    ${product_locator}    {{orignalprice}}    ${orignalprice}
        IF      '${discountprice}'=='${empty}'     
            AppiumLibrary.Wait Until Element Is Visible   ${txt_orignal_price_locator}
        END
        ${product_locator_2}    String.Replace string    ${basket.txt_productname_orignal_price}    {{productname}}    ${productname}
        ${txt_productname_orignal_price_locator}    String.Replace string    ${product_locator_2}    {{orignalprice}}    ${orignalprice}

        ${product_locator_3}    String.Replace string    ${basket.txt_discount_price}    {{productname}}    ${productname}
        ${txt_discount_price_locator}    String.Replace string    ${product_locator_3}    {{discountprice}}    ${discountprice}
        IF      '${discountprice}'!='${empty}'
            AppiumLibrary.Wait Until Element Is Visible      ${txt_productname_orignal_price_locator}
            AppiumLibrary.Wait Until Element Is Visible      ${txt_discount_price_locator}
        END
        ${product_locator_4}    String.Replace string    ${basket.txt_discount_percent}    {{productname}}    ${productname}
        ${txt_discount_percent_locator}    String.Replace string    ${product_locator_4}    {{discountpercent}}    ${discountpercent}
        IF      '${discountpercent}'!='${empty}'
            AppiumLibrary.Wait Until Element Is Visible      ${txt_discount_percent_locator}
        END
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        ${product_locator_1}    String.Replace string    ${basket.orignalprice}    {{productname}}    ${productname}
        ${orignalprice_locator}    String.Replace string    ${product_locator_1}    {{orignalprice}}    ${orignalprice}
        ${product_locator_2}    String.Replace string    ${basket.discountprice_and_orignalprice}    {{productname}}    ${productname}
        ${discountprice_locator}    String.Replace string    ${product_locator_2}    {{discountprice}}    ${discountprice}
        ${discountprice_and_orignalprice_locator}    String.Replace string    ${discountprice_locator}    {{orignalprice}}    ${orignalprice}
        IF      '${discountprice}'=='${empty}'      
            AppiumLibrary.Wait Until Element Is Visible   ${orignalprice_locator}
        ELSE IF     '${discountprice}'!='${empty}'
            AppiumLibrary.Wait Until Element Is Visible   ${discountprice_and_orignalprice_locator} 
        END
    END

Verify total price is correct
    [Documentation]     Pass with .00 (ex. 100.00)
    [Arguments]     ${total}
    ${total_locator}    String.Replace string    ${basket.txt_total}    {{total}}    ${total}
    DobbyAppCommon.Find element      ${total_locator}   scroll_panel=${default_scroll_view}    moveto=Top    percent=${swipeLongScroll}      timeout=${shortTimeout}

Verify sub total price is correct
    [Documentation]     Pass with .00 (ex. 100.00)
    [Arguments]     ${total}
    ${txt_subtotal_locator}    String.Replace string    ${basket.txt_subtotal}    {{total}}    ${total}
    DobbyAppCommon.Find element      ${txt_subtotal_locator}   scroll_panel=${default_scroll_view}    moveto=Top    percent=${swipeLongScroll}      timeout=${shortTimeout}

Tap checkout button
    IF   "${platform}" == "${platform_list['android']}"
        AppiumLibrary.Wait Until Element Is Visible   ${basket.btn_basket}     timeout=10s
        DobbyAppCommon.Tap element when ready   ${basket.btn_checkout}
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        ${a_result}=    Run keyword and return status   DobbyAppCommon.Wait Until Element Is Visible except stale  ${basket.last_checkout}      timeout=5s
        ${b_result}=    Run keyword and return status   DobbyAppCommon.Wait Until Element Is Visible except stale  ${basket.btn_checkout}          timeout=5s
    
        IF     ${a_result}
            DobbyAppCommon.Tap element when ready   ${basket.last_checkout} 
        ELSE IF     ${b_result}
            DobbyAppCommon.Tap element when ready   ${basket.btn_checkout}
        END
    END

Verify product in basket not able to checkout display
    [Arguments]     ${minimum}      ${price_unit}
    ${btn_checkout_status}    Run keyword and return status     basket_page.Verify product in basket able to checkout
    ${min_price_warning_locator}    String.Replace string       ${basket.txt_minimum_order_warning}     {{minimumSpend}}    ${minimum}
    ${min_price_warning_locator}    String.Replace string       ${min_price_warning_locator}            {{priceUnit}}       ${price_unit}
    DobbyAppCommon.Wait until element is visible except stale   ${min_price_warning_locator}

Verify product in basket able to checkout
   AppiumLibrary.Element should be enabled    ${basket.btn_checkout}

Remove item from basket
    [Arguments]     ${productname}
    IF   "${platform}" == "${platform_list['android']}"
        ${input_product_qty_locator}    String.Replace string    ${basket.input_product_qty}    {{productname}}    ${productname}
        ${txt_product_list_locator}    String.Replace string    ${basket.txt_product_list}    {{productname}}    ${productname}
        Sleep       0.5s
        ${1pos}=    Get Element Location    ${input_product_qty_locator}      #quantity
        ${2pos}=    Get Element Location    ${txt_product_list_locator}
        Swipe   ${1pos}[x]      ${1pos}[y]      ${2pos}[x]     ${2pos}[y]     #swipe left
        DobbyAppCommon.Tap element when ready   ${basket.txt_global_delete} 
        mobile_common.Wait until loading complete
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        ${productname_locator}    String.Replace string    ${basket.productname}    {{productname}}    ${productname}
        ${quantity_counter_container_locator}    String.Replace string    ${basket.quantity_counter_container}    {{productname}}    ${productname}
        ${delete_locator}    String.Replace string    ${basket.delete}    {{productname}}    ${productname}
        AppiumLibrary.Wait Until Element Is Visible       ${productname_locator}
        ${1pos}=    Get Element Location    ${quantity_counter_container_locator}      #quantity
        ${2pos}=    Get Element Location    ${productname_locator}       #productname
        Swipe   ${1pos}[x]      ${1pos}[y]      ${2pos}[x]     ${2pos}[y]     #swipe left
        Tap     ${delete_locator}
        Verify alert removed product display
    END

Verify alert removed product display
    IF   "${platform}" == "${platform_list['android']}"
        AppiumLibrary.Wait Until Element Is Visible   ${basket.txt_remove_product}
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        AppiumLibrary.Wait Until Element Is Visible   ${basket.product_remove_form_basket}
    END

Verify product is deleted
    [Arguments]     ${productname}
    ${txt_product_list_locator}    String.Replace string    ${basket.txt_product_list}    {{productname}}    ${productname}
    AppiumLibrary.Wait until page does not contain    ${txt_product_list_locator}

Verify 1P product delivery by brand name
    [Arguments]     ${seller_name}
    ${brand_name_locator}       String.Replace string     ${basket.delivery_by_1P_brand_title}     {{shopName}}        ${seller_name}
    DobbyAppCommon.Find element      ${brand_name_locator}   scroll_panel=${default_scroll_view}    moveto=Top    percent=${swipeShortScroll}      timeout=${shortTimeout}

Verify 3P product delivery by brand name
    [Arguments]     ${seller_name}
    ${brand_name_locator}       String.Replace string     ${basket.delivery_by_3P_brand_title}     {{shopName}}     ${seller_name}
    DobbyAppCommon.Find element      ${brand_name_locator}   scroll_panel=${default_scroll_view}    moveto=Top    percent=${swipeShortScroll}      timeout=${shortTimeout}

Verify product 1P header contain choose delivery date and time at checkout
    DobbyAppCommon.Wait until element is visible except stale           ${basket.choose_delivery_date}

Tap at 1P information tooltip icon
    [Arguments]    ${seller_name}
    ${info_icon_locator}       String.Replace string     ${basket.info_tooltip_icon}     {{shopName}}        ${seller_name}
    DobbyAppCommon.Tap element when ready           ${info_icon_locator}

Tap at 3P information tooltip icon
    [Arguments]    ${seller_name}
    ${info_icon_locator}       String.Replace string     ${basket.info_3P_tooltip_icon}     {{shopName}}        ${seller_name}
    DobbyAppCommon.Tap element when ready           ${info_icon_locator}

Close tooltip popup by swipe down
    [Arguments]    ${seller_name}
    IF   "${platform}" == "${platform_list['android']}"  
        ${basket_btn_locator}   String.Replace string     ${basket.btn_close_tooltip}     {{appName}}        ${seller_name}
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        ${basket_btn_locator}       String.Replace string     ${basket.delivery_handle_by_1P_brand_title}     {{appName}}        ${seller_name}
    END    
    ${1pos}         AppiumLibrary.Get element location    ${basket_btn_locator}
    AppiumLibrary.Swipe   ${1pos}[x]      ${1pos}[y]      ${1pos}[x]     2000
    AppiumLibrary.Wait until page does not contain element    ${basket.delivery_brand_description}

Close tooltip 3P popup by swipe down
    IF   "${platform}" == "${platform_list['android']}"  
        ${basket_btn_locator}   Set variable    ${basket.btn_close_3P_tooltip}
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        ${basket_btn_locator}    Set variable   ${basket.delivery_partner_title}
    END  
    ${1pos}         AppiumLibrary.Get element location    ${basket_btn_locator}
    AppiumLibrary.Swipe   ${1pos}[x]      ${1pos}[y]      ${1pos}[x]     2000
    AppiumLibrary.Wait until page does not contain element    ${basket_btn_locator}

Verify delivery handle by seller header display
    [Arguments]     ${seller_name}
    ${brand_name_locator}       String.Replace string     ${basket.delivery_handle_by_1P_brand_title}     {{appName}}        ${seller_name}
    DobbyAppCommon.Wait until element is visible except stale       ${brand_name_locator}

Verify 1P product tooltip popup display detail
    [Arguments]     ${seller_name}
    basket_page.Tap at 1P information tooltip icon                  ${seller_name}
    basket_page.Verify delivery handle by seller header display     ${seller_name}
    DobbyAppCommon.Wait until element is visible except stale       ${basket.delivery_brand_description}
    basket_page.Close tooltip popup by swipe down         ${seller_name}

Verify delivery by partner header display
    DobbyAppCommon.Wait until element is visible except stale       ${basket.delivery_partner_title}

Verify partner delivery description on tooltip popup display
    ${sentence1}    ${sentence2}    mobile_common.Get separate sentente that has new line from language file  ${mobile['basket']['message']['deliveryHandledByPartnerDescription']}
    mobile_common.Verify message in textview       ${sentence1}
    mobile_common.Verify message in textview       ${sentence2}

Verify 3P product tooltip popup display detail
    [Arguments]     ${seller_name}
    basket_page.Tap at 3P information tooltip icon        ${seller_name}
    basket_page.Verify delivery by partner header display
    basket_page.Verify partner delivery description on tooltip popup display
    basket_page.Close tooltip 3P popup by swipe down

Verify unit size is correct
    [Arguments]     ${seller_name}      ${expected_unit}
    ${product_unit_locator}    String.Replace string    ${basket.txt_product_unit}    {{productname}}    ${seller_name}
    ${product_unit_locator}    String.Replace string    ${product_unit_locator}       {{unit}}           ${expected_unit}
    DobbyAppCommon.Find element      ${product_unit_locator}   scroll_panel=${default_scroll_view}    moveto=Top    percent=${swipeShortScroll}      timeout=${shortTimeout}

Verify product display original price correct
    [Arguments]     ${product_name}     ${orignalprice}
    ${product_locator}      String.Replace string    ${basket.txt_productname_orignal_price}    {{productname}}    ${product_name}
    ${txt_orignal_price_locator}    String.Replace string    ${product_locator}    {{orignalprice}}    ${orignalprice}
    DobbyAppCommon.Wait until element is visible except stale   ${txt_orignal_price_locator}

Verify product display discount price correct
    [Arguments]     ${product_name}     ${discount}
    ${product_locator}      String.Replace string    ${basket.txt_discount_price}    {{productname}}    ${product_name}
    ${txt_discount_price_locator}    String.Replace string    ${product_locator}    {{discountprice}}    ${discount}
    DobbyAppCommon.Find element      ${txt_discount_price_locator}   scroll_panel=${default_scroll_view}    moveto=Top    percent=${swipeShortScroll}      timeout=${shortTimeout}

Verify product display all prices correct
    [Arguments]     ${product_name}     ${original}     ${discount}
    ${original}     Convert to string   ${original}
    ${original}     Evaluate      "{:,.2f}".format(${original})
    ${discount}     Convert to string   ${discount}
    ${discount}     Evaluate      "{:,.2f}".format(${discount})
    IF  "${original}"!="${discount}"
        basket_page.Verify product display original price correct   ${product_name}     ${original}
    END
    basket_page.Verify product display discount price correct   ${product_name}     ${discount}

Verify delivery date start and end date is shown at basket
    [Arguments]     ${seller_name}
    [Documentation]     check pattern match 31 Mar - 01 Apr or 29 มี.ค. - 30 มี.ค.
    ${delivery_date_locator}      String.Replace string    ${basket.delivery_range_date}    {{shopName}}     ${seller_name}
    DobbyAppCommon.Find element      ${delivery_date_locator}   scroll_panel=${default_scroll_view}    moveto=Top    percent=${swipeLongScroll}      timeout=${shortTimeout}
    ${date_month}  DobbyAppCommon.Get text from element when ready  ${delivery_date_locator}
    IF  "${lang}"=="th"
        ${date_month}  String.Get regexp matches  ${date_month}   \\d{2} [ก-โ]{1,2}[.][ก-ฮ][.] - \\d{2} [ก-โ]{1,2}[.][ก-ฮ][.]
    ELSE
        ${date_month}  String.Get regexp matches  ${date_month}   \\d{2} [A-Za-z]{1,3} - \\d{2} [A-Za-z]{1,3}
    END
    ${amount_date_month}  Get length  ${date_month}
    Should be true  ${amount_date_month}==1

Toast message should display add all product to basket successful
    mobile_common.Toast message should display and close   ${basket.add_to_basket_success}

Verify basket display all items from my previous order
    [Arguments]     @{product_name_list}
    ${product_name_list_locator}    String.Replace string    ${basket.product_name_list}    {{product_name_list}}    ${productname}
    ${amount_of_product}=  Get length  ${product_name_list}
    FOR    ${i}  IN RANGE   1   ${amount_of_product}
        ${index}=    Convert To String    ${i}
        ${product_list_locator}    String.Replace string    ${product_name_list_locator}    {{i}}    ${index}
        mobile_common.Find element     ${product_list_locator}       
    END
    

Swipe to delete product by product name
    [Arguments]    ${productname}
    ${txt_product_list_locator}    String.Replace string    ${basket.txt_product_list}    {{productname}}    ${productname}
    DobbyAppCommon.Wait until element is visible except stale   ${txt_product_list_locator}
    IF   "${platform}" == "${platform_list['android']}"
        ${getsize} =   AppiumLibrary.Get element size        ${txt_product_list_locator}
        ${getcoor} =   Get element location    ${txt_product_list_locator}
        ${center_x1}   Evaluate    ${getcoor['x']}-${getsize['width']}/2
        ${center_x2}   Evaluate    ${getcoor['x']}+${getsize['width']}/2
        FOR     ${i}    IN RANGE    0   2
            ${is_found}=    Run keyword and return status   DobbyAppCommon.Wait until page contain element except stale    ${txt_product_list_locator}     timeout=${short_timeout}
            IF  ${is_found}
                Swipe         ${center_x2}  ${getcoor['y']}  ${center_x1}  ${getcoor['y']}
                DobbyAppCommon.Tap element when ready    ${basket.txt_global_delete}
                basket_page.Verify alert removed product display
            END
        Exit for loop if    '${is_found}'=='False'
        Basket swipe down
        END
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        mobile_common.Swipe left to right  ${txt_product_list_locator}
        DobbyAppCommon.Tap element when ready    ${basket.txt_global_delete}
        basket_page.Verify alert removed product display
    END

Basket swipe down
    DobbyAppCommon.Wait until element is visible except stale   ${basket.basket_list}
    ${getsize_basket} =   AppiumLibrary.Get element size          ${basket.basket_list}
    ${getcoor_basket} =   Get element location      ${basket.basket_list}
    ${center_x}   Evaluate    ${getcoor_basket['x']}+${getsize_basket['width']}/2
    ${center_y}   Evaluate    ${getcoor_basket['y']}+${getsize_basket['height']}/2
    ${new_y}      Evaluate    ${center_y}/1.5
    Swipe         ${center_x}  ${center_y}  ${center_x}  ${new_y}

Verify product discount label display
    DobbyAppCommon.Find element      ${basket.txt_product_discount_label}   scroll_panel=${default_scroll_view}    moveto=Top    percent=${swipeLongScroll}      timeout=${shortTimeout}

Get total product price with product promotion discount
    [Arguments]     ${total_price}
    [Documentation]     This discount field not from voucher, it from some product like มะพร้าว FBM that has fix discount 200 ฿
    ${product_discount}      DobbyAppCommon.Get text from element when ready     ${basket.txt_product_discount}
    ${product_discount}      String.Remove string        ${product_discount}      .00 ฿
    ${found_comma}    Run keyword and return status      Should contain     ${product_discount}    ,
    IF  "${found_comma}"=="${True}"
        ${product_discount}      String.Replace string         ${product_discount}      ,       ${empty}
    END
    ${total_with_discount}   Evaluate      ${total_price}-${product_discount}
    [Return]        ${total_with_discount}

Verify total product promotion discount
    [Arguments]     ${total}
    ${txt_discount_total_locator}    String.Replace string    ${basket.txt_discount_total}    {{total}}    ${total}
    DobbyAppCommon.Wait until element is visible except stale   ${txt_discount_total_locator}

Verify total voucher discount
    [Arguments]     ${total}    ${code}
    ${txt_summary_voucher_badge_locator}    String.Replace string    ${basket.txt_summary_voucher_badge}    {{code}}    ${code}
    ${txt_summary_voucher_field_locator}    String.Replace string    ${basket.txt_summary_voucher_field}    {{total}}    ${total}
    DobbyAppCommon.Wait until element is visible except stale   ${txt_summary_voucher_badge_locator}
    DobbyAppCommon.Wait until element is visible except stale   ${txt_summary_voucher_field_locator}

Verify basket cleared
    DobbyAppCommon.Wait until element is visible except stale   ${basket.txt_empty_basket}

User location should be basket page
    AppiumLibrary.Wait Until Element Is Visible   ${basket.view_basket}

Clear basket via debug menu
    [Arguments]     ${Invalidate}=${False}
    debug_page.Open debug menu
    mobile_common.Find element and tap     ${debug.clear_basket}       percent=${minNumberScroll}
    IF  "${platform}" == "${platform_list['android']}"
        DobbyAppCommon.Tap element when ready     ${debug.btn_confirm_clear}
    END
    mobile_common.tap basket menu    
    DobbyAppCommon.Wait until element is visible except stale   ${basket.txt_empty_basket}

Basket swipe up
    DobbyAppCommon.Wait until element is visible except stale   ${basket.basket_list}
    ${getsize_basket} =   AppiumLibrary.Get element size          ${basket.basket_list}
    ${getcoor_basket} =   Get element location      ${basket.basket_list}
    ${center_x}   Evaluate    ${getcoor_basket['x']}+${getsize_basket['width']}/2
    ${center_y}   Evaluate    ${getcoor_basket['y']}+${getsize_basket['height']}/2
    ${new_y}      Evaluate    ${center_y}/1.5
    Swipe         ${center_x}  ${new_y}  ${center_x}  ${center_y}

Verify delivery type and delivery fee display 
    [Arguments]    ${fee}
    ${fee_locator}    String.Replace string    ${basket.fee}    {{fee}}    ${fee}
    DobbyAppCommon.Wait until element is visible except stale   ${fee_locator}

Verify toast message decrease quantity display
    DobbyAppCommon.Wait until element is visible except stale       ${basket.txt_toast_warning}
    AppiumLibrary.Wait until page does not contain element       ${basket.toast_warning}     timeout=10s

Get delivery date on basket page
    [Arguments]    ${seller_name}
    ${basket_section_locator}    String.Replace string    ${basket.basket_section}    {{seller_name}}    ${seller_name}
    ${text}    DobbyAppCommon.Get text from element when ready    ${basket_section_locator}
    ${text}    Fetch From Right    ${text}  ${SPACE}
    [Return]    ${text}

Verify the number of sections at basket page 
    [Arguments]    ${seller_name}
    FOR    ${name}    IN    @{seller_name}
        mobile_common.Verify message in textview       ${name}
    END

Get total price
    ${price}      DobbyAppCommon.Get text from element when ready     ${basket.basket_summary_section_subtotal_field}
    ${total_price}        String.Remove string        ${fee}      .00 ฿
    [Return]        ${total_price}

Get total delivery fee
    DobbyAppCommon.Find element      ${basket.basket_summary_section_shipping_fee_field}   scroll_panel=${default_scroll_view}    moveto=Top    percent=${swipeShortScroll}      timeout=${shortTimeout}
    ${fee}      DobbyAppCommon.Get text from element when ready     ${basket.basket_summary_section_shipping_fee_field}
    IF   "${fee}"!="${mobile['basket']['label']['free']}"
        ${total_fee}        String.Remove string        ${fee}      .00 ฿
    ELSE
        ${total_fee}        Set variable        0
    END
    [Return]        ${total_fee}

Verify product is not available in basket
    [Arguments]     ${productname}      ${qty}=1
    ${txt_product_list_locator}    String.Replace string    ${basket.txt_product_list}    {{productname}}    ${productname}
    FOR     ${i}    IN RANGE    1       4
        ${is_found}=    Run keyword and return status   DobbyAppCommon.Wait until page contain element except stale    ${txt_product_list_locator}     timeout=${short_timeout}
        IF  ${is_found}=='False'
            Basket swipe down
        END
        Exit for loop if    ${is_found}
    END
    ${is_found}=    Run keyword and return status   DobbyAppCommon.Wait until page contain element except stale    ${txt_product_list_locator}     timeout=${short_timeout}
    Should Not Be True    ${is_found}    msg='product found'

Verify warning popup msgs  
    AppiumLibrary.Wait Until Element Is Visible          ${basket.choosing_different_address}
    AppiumLibrary.Wait Until Element Is Visible          ${basket.warningChangeLocationPopupDescription}

Verify msg shows products that can not be purchased 
    AppiumLibrary.Wait Until Element Is Visible        ${basket.unavailableItems}

Scroll to top product list
    [Arguments]    ${name}
    FOR    ${i}  IN RANGE   1   10
        ${name_contains_locator}    String.Replace string    ${basket.name_contains}    {{name}}    ${name}
        ${result}=     Run keyword and return status   AppiumLibrary.Wait Until Element Is Visible   ${name_contains_locator}      timeout=3s
        Exit for loop if        '${result}'=='True'
        basket_page.Basket swipe up
    END

Click trash icon on basket page
    [Arguments]    @{products_name}
    FOR    ${name}    IN    @{products_name}
        ${trash_btn_icon_locator}    String.Replace string    ${basket.trash_btn_icon}    {{name}}    ${name}
        mobile_common.Find element  ${trash_btn_icon_locator}
        DobbyAppCommon.Tap element when ready    ${trash_btn_icon_locator}
        basket_page.Verify alert removed product display
    END

Verify checkout button disabled
    AppiumLibrary.Element Should Be Disabled    ${basket.checkout_viewgroup}

Verify browse categories button enabled
    AppiumLibrary.Wait Until Element Is Visible   ${basket.ctaBrowseCategory}
    AppiumLibrary.Element Should Be Enabled    ${basket.ctaBrowseCategory}

Verify products not available in basket
    [Arguments]    @{products_name}
    FOR    ${name}     IN      @{products_name}
        ${txt_productname_locator}    String.Replace string    ${basket.txt_productname}    {{name}}    ${name}
        AppiumLibrary.Page should not contain element           ${txt_productname_locator}
    END

Verify unable to add product to basket popup
    DobbyAppCommon.Wait until page contain element except stale   ${basket.addedUnavailablePopupTitle}

Click ok on popup
    DobbyAppCommon.Tap element when ready     ${basket.okay}

Click add to basket at product detail page
    DobbyAppCommon.Tap element when ready       ${basket.add_to_basket}
    
Get total price with delivery fee
    [Documentation]     Pass subtotal with .00 included
    [Arguments]     ${subtotal}
    ${total_fee}      basket_page.Get total delivery fee
    ${subtotal_string}      Convert to string       ${subtotal}
    ${total}                Evaluate        ${total_fee}+${subtotal_string}
    ${total_decimal}        Evaluate        "{:,.2f}".format(${total})
    [Return]        ${total_decimal}

Get total price with discount code
    [Arguments]     ${total_price}      ${discount}
    ${total_price_with_fee}     basket_page.Get total price with delivery fee       ${total_price}
    ${total_price_with_fee}     String.Remove string       ${total_price_with_fee}     ,     .00 
    ${discount}                 String.Remove string       ${discount}                 .00
    ${total_with_discount}      Evaluate            ${total_price_with_fee}-${discount}
    ${price_number}             Evaluate            "{:,.2f}".format(${total_with_discount})
    [Return]                    ${price_number}

Get total price with fee and discount
    [Documentation]     Pass subtota and discount with .00 included
    [Arguments]     ${subtotal}     ${discount}=0
    ${fee}      DobbyAppCommon.Get text from element when ready     ${basket.basket_summary_section_shipping_fee_field}
    IF  '${discount}'=='0'
        ${discount}     DobbyAppCommon.Get text from element when ready     ${basket.basket_summary_section_discount_field}
        ${total_discount}        String.Remove string        ${discount}        -       ,      .00 ฿
        ${total_fee}        String.Remove string        ${fee}      .00 ฿
        ${subtotal_string}       Convert to string        ${subtotal}
        ${subtotal_no_comma}       String.Remove string        ${subtotal_string}       ,
        ${discount_string}       Convert to string        ${total_discount}
        ${total}        Evaluate       ${subtotal_no_comma}-${discount_string}+${total_fee}
        ${total_decimal}        Evaluate        "{:.2f}".format(${total})
    ELSE
        ${total_fee}        String.Remove string        ${fee}      .00 ฿
        ${subtotal_string}       Convert to string        ${subtotal}
        ${subtotal_no_comma}       String.Remove string        ${subtotal_string}       ,
        ${discount_old}       Convert to string        ${discount}
        ${discount_new}       String.Remove string        ${discount_old}       ,
        ${total}        Evaluate        ${subtotal_no_comma}-${discount_new}+${total_fee}
        ${total_decimal}        Evaluate        "{:.2f}".format(${total})
    END
    [Return]        ${total_decimal}

Verify target badge display on product in basket
    [Arguments]     ${badge_name}   ${product_name}
    ${badge_locator}     String.Replace string      ${basket.txt_badge_product}   {{badge_name}}    ${badge_name}
    ${product_with_badge_locator}   String.Replace string       ${badge_locator}   {{product_name}}   ${product_name}
    DobbyAppCommon.Wait until element is visible except stale   ${product_with_badge_locator}

Tap expand makro point button
    DobbyAppCommon.Find element      ${basket.btn_makro_point_expand}   scroll_panel=${default_scroll_view}    moveto=Top    percent=${swipeLongScroll}      timeout=${shortTimeout}
    DobbyAppCommon.Tap element when ready          ${basket.btn_makro_point_expand}

Verify total point on basket page is correct
    [Arguments]     ${total_point}
    ${total_point_locator}     String.Replace string      ${basket.txt_total_point}   {{total}}    ${total_point}
    DobbyAppCommon.Wait until element is visible except stale   ${total_point_locator}

Verify pay by point label with arrow symbol display
    DobbyAppCommon.Wait until element is visible except stale   ${basket.arrow_point_symbol}

Verify confirm pay by point button is enabled
    AppiumLibrary.Element should be enabled               ${basket.btn_makro_point_confirm}

Verify confirm pay by point button is not display
    ${is_visibled}     Run keyword and return status       DobbyAppCommon.Wait until element is visible except stale    ${basket.btn_makro_point_confirm}   timeout=${shortTimeout}
    Should be equal     ${is_visibled}   ${False}

Verify confirm pay by point button is disabled
    ${is_enabled}     Run keyword and return status       basket_page.Verify confirm pay by point button is enabled
    Should be equal     ${is_enabled}   ${False}

Verify toast message add point successfully
    AppiumLibrary.Wait until page does not contain element          ${basket.txt_point_add_success}

Verify toast message delete point successfully
    AppiumLibrary.Wait until page does not contain element          ${basket.txt_point_delete_success}

Input point for discount payment
    [Arguments]     ${point}
    DobbyAppCommon.Input text to element when ready      ${basket.txt_point_input}       ${point}

Tap confirm pay by point button
    DobbyAppCommon.Tap element when ready              ${basket.btn_makro_point_confirm}
    mobile_common.Wait until loading complete

Verify amount after apply point display correct
    [Arguments]     ${point}
    ${total_amount}        Evaluate        "{:.2f}".format(${point})
    ${total_amount}        Convert to string        ${total_amount}
    ${total_amount_locator}     String.Replace string      ${basket.txt_amount_thb_point}   {{total_amount}}    ${total_amount}
    DobbyAppCommon.Wait until element is visible except stale       ${total_amount_locator}

Verify remove point for use discount coupon display
    DobbyAppCommon.Wait until element is visible except stale       ${basket.txt_remove_point_for_use_coupon}

Verify input point disabled after confirmed
    ${is_enabled}     Run keyword and return status    AppiumLibrary.Element should be enabled     ${basket.txt_point_input}
    Should be equal     ${is_enabled}   ${False}

Tap delete point button
    DobbyAppCommon.Tap element when ready              ${basket.btn_delete_point}

Verify makro pro point tag display in discount
    DobbyAppCommon.Find element      ${basket.txt_makro_pro_point}   scroll_panel=${default_scroll_view}    moveto=Top    percent=${swipeLongScroll}      timeout=${shortTimeout}

Verify close button display inside input point
    DobbyAppCommon.Wait until element is visible except stale       ${basket.btn_close_icon_input}     timeout=${shortTimeout}

Verify close button not display inside input point
    ${is_visibled}     Run keyword and return status    basket_page.Verify close button display inside input point
    Should be equal     ${is_visibled}   ${False}

Verify point display in placeholder
    DobbyAppCommon.Wait until element is visible except stale       ${basket.txt_point_amount_placeholder}

Get product price
    [Arguments]     ${product_name}
    ${product_name_locator}     String.Replace string       ${basket.txt_product_price}     {{productname}}     ${product_name}
    DobbyAppCommon.Find element      ${product_name_locator}   scroll_panel=${default_scroll_view}    moveto=Top    percent=${swipeShortScroll}      timeout=${shortTimeout}
    ${product_price}    DobbyAppCommon.Get text from element when ready     ${product_name_locator}
    ${product_price}    String.Remove string        ${product_price}      .00 ฿
    [Return]        ${product_price}

Verify trash icon is display
    [Arguments]     ${product_name}
    ${trash_btn_icon_locator}    String.Replace string    ${basket.trash_btn_icon}    {{name}}    ${product_name}
    DobbyAppCommon.Find element      ${trash_btn_icon_locator}   scroll_panel=${default_scroll_view}    moveto=Top    percent=${swipeShortScroll}      timeout=${shortTimeout}

Verify product on basket should be product from order history
    [Arguments]      ${product_basket}        ${product_order}
    Collections.Lists should be equal       ${product_basket}        ${product_order}

Get all product name from basket
    DobbyAppCommon.Wait until element is visible except stale   ${basket.basket_list_item}
    @{product_name_list}  Create list
    ${count} 	AppiumLibrary.Get matching xpath count 	${basket.txt_basket_list_item}

    FOR     ${i}    IN RANGE    1       ${count}+1
        ${index}=    Convert to string    ${i}
        ${basket_list_item_textview_index_locator}    String.Replace string    ${basket.basket_list_item_textview_index}    {{i}}    ${index}
        ${product_name}  DobbyAppCommon.Get text from element when ready  ${basket_list_item_textview_index_locator}
        Collections.Append to list  ${product_name_list}  ${product_name}
    END
    [Return]  @{product_name_list}
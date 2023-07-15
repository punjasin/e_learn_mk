*** Settings ***
Resource        ../../../resources/locators/${platform}/product_locator.resource
Resource        ../../../resources/locators/${platform}/common_locator.resource
Resource        ../../../common/mobile/mobile_common.resource
Resource        search_page.resource

*** Keywords ***
Select main category
    [Arguments]    ${category}
    ${txt_category_locator}    String.Replace string    ${product_page.txt_category}    {{category}}    ${category}
    DobbyAppCommon.Find element    ${txt_category_locator}   scroll_panel=${default_scroll_view}    moveto=Left    percent=${swipeLongScroll}    number_of_scroll=${swipeMediumScroll}  timeout=${shortTimeout}
    DobbyAppCommon.Tap element when ready       ${txt_category_locator}

Select sub category
    [Arguments]    ${sub_category}
    ${txt_category_locator}    String.Replace string    ${product_page.txt_sub_category}    {{sub_category}}    ${sub_category}
    DobbyAppCommon.Find element    ${txt_category_locator}   scroll_panel=${default_scroll_view}    moveto=Top    percent=${swipeLongScroll}  timeout=${shortTimeout}
    DobbyAppCommon.Tap element when ready     ${txt_category_locator}

Verify target product is visible
    [Arguments]    ${product}
    ${txt_product_name_locator}    String.Replace string    ${product_page.txt_product_name}    {{product}}    ${product}
    DobbyAppCommon.Wait until element is visible except stale   ${txt_product_name_locator}

Select product
    [Arguments]    ${product}
    IF   "${platform}" == "${platform_list['android']}"
        ${txt_product_name_locator}    String.Replace string    ${product_page.txt_product_name}    {{product}}    ${product}
        Find product on list     ${product}
        DobbyAppCommon.Tap element when ready        ${txt_product_name_locator}
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        Find product on list     ${product}
        ${list_item_title_product_item_gid_locator}    String.Replace string    ${product_page.list_item_title_product_item_gid}    {{product}}    ${product}
        DobbyAppCommon.Tap element when ready      	${list_item_title_product_item_gid_locator}
    END

Find product on list 
    [Arguments]    ${product}       ${scroll_pane}=${default_scroll_view}
    ${txt_product_name_locator}            String.Replace string    ${product_page.txt_product_name}    {{product}}    ${product}
    DobbyAppCommon.Find element          ${txt_product_name_locator}          scroll_panel=${scroll_pane}    moveto=Top       percent=${swipeLongScroll}      timeout=${shortTimeout}

Find product at PLP
    [Arguments]    ${maincategory}  ${subcategory}  ${product}
    product_page.Select main category    ${maincategory}
    search_page.Select sub category     ${subcategory}
    product_page.Find product on list    ${product}

Tap back at product detail page
    DobbyAppCommon.Tap element when ready        ${product_page.back_button}
    
Click add to basket at product detail page
    mobile_common.Find element                     ${product_page.add_to_basket}
    DobbyAppCommon.Tap element when ready         ${product_page.add_to_basket}

Increase quantity by clicking on PDP
    [Arguments]      ${product}     ${number}=1
    FOR     ${round}    IN RANGE    ${number}
        ${increment_locator}        String.Replace string       ${productcard_page.increment_btn_wrapper}     {{product}}       ${product}  
        DobbyAppCommon.Tap element when ready    ${increment_locator}
    END

Decrease quantity by clicking on PDP
    [Arguments]     ${number}=1
    IF   "${platform}" == "${platform_list['android']}"
        FOR     ${round}    IN RANGE    ${number}    
            DobbyAppCommon.Tap element when ready    ${product_page.decrement_btn_icon}
            mobile_common.Wait until loading complete
        END
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        FOR     ${round}    IN RANGE    ${number}    
            DobbyAppCommon.Tap element when ready    ${product_page.decrement_btn_wrapper}
        END
    END

Adjust quantity by typing on PDP
    [Arguments]     ${qty}
    IF   "${platform}" == "${platform_list['android']}"
        DobbyAppCommon.Wait until element is visible except stale        ${product_page.qty_input}
        DobbyAppCommon.Input text to element when ready     ${product_page.qty_input}         ${qty}
        DobbyAppCommon.Tap element when ready        ${product_page.qty_input}
        Press keycode   66   # Enter key
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        DobbyAppCommon.Tap element when ready    ${product_page.qty_input}
        DobbyAppCommon.Clear text when ready       ${product_page.qty_input}
        DobbyAppCommon.Input text to element when ready     ${product_page.qty_input}    ${qty}
        DobbyAppCommon.Tap element when ready      ${product_page.success}
    END

Verify product out of stock tag display
    [Arguments]     ${product}
    IF   "${platform}" == "${platform_list['android']}"
        ${txt_all_product_locator}    String.Replace string    ${product_page.txt_all_product}    {{product}}    ${product}
        FOR    ${i}    IN RANGE    5
            ${element_status}=      Run keyword and return status    DobbyAppCommon.Wait until element is visible except stale      ${txt_all_product_locator}      timeout=${short_timeout}
            Run keyword if  '${element_status}'=='False'     DobbyAppCommon.Move to    Top      
            Exit for loop if    '${element_status}'=='True'
        END
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        ${txt_out_of_stock_locator}    String.Replace string    ${product_page.txt_out_of_stock}    {{product}}    ${product}
        ${txt_product_item_gid_out_of_stock_locator}    String.Replace string    ${product_page.txt_product_item_gid_out_of_stock}    {{product}}    ${product}
        ${a_result}=    Run keyword and return status   DobbyAppCommon.Wait until element is visible except stale  ${txt_out_of_stock_locator}     timeout=5s
        ${b_result}=    Run keyword and return status   DobbyAppCommon.Wait until element is visible except stale  ${txt_product_item_gid_out_of_stock_locator}          timeout=5s
        IF     ${a_result}
            DobbyAppCommon.Wait until element is visible except stale  ${product_page.out_of_stock}
        ELSE IF     ${b_result}
            DobbyAppCommon.Wait until element is visible except stale  ${product_page.txt_name_out_of_stock}
        END
    END

Verify product quantity at PDP
    [Arguments]     ${quantity}
    ${qty}=    Convert to string    ${quantity}
    ${txt_quantity_locator}    String.Replace string    ${product_page.txt_quantity}    {{quantity}}    ${qty}
    DobbyAppCommon.Wait until element is visible except stale        ${txt_quantity_locator}

Verify product brand at PDP
    [Arguments]     ${name}
    IF   "${platform}" == "${platform_list['android']}"
        ${scroll_to_product_locator}    String.Replace string    ${product_page.scroll_to_product}    {{name}}    ${name}
        DobbyAppCommon.Wait until element is visible except stale        ${scroll_to_product_locator}
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        ${product_name_locator}    String.Replace string    ${product_page.product_name}    {{name}}    ${name}
        DobbyAppCommon.Wait until element is visible except stale     ${product_name_locator}
    END

Verify product title at PDP
    [Arguments]     ${name}
    IF   "${platform}" == "${platform_list['android']}"
        ${scroll_to_product_locator}    String.Replace string    ${product_page.scroll_to_product}    {{name}}    ${name}
        DobbyAppCommon.Wait until element is visible except stale        ${scroll_to_product_locator}
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        ${product_name_locator}    String.Replace string    ${product_page.product_name}    {{name}}    ${name}
        DobbyAppCommon.Wait until element is visible except stale     ${product_name_locator}
    END

Verify product unit at PDP
    [Arguments]     ${name}
    IF   "${platform}" == "${platform_list['android']}"
        ${scroll_to_product_locator}    String.Replace string    ${product_page.scroll_to_product}    {{name}}    ${name}
        DobbyAppCommon.Wait until element is visible except stale        ${scroll_to_product_locator}
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        ${product_name_locator}    String.Replace string    ${product_page.product_name}    {{name}}    ${name}
        DobbyAppCommon.Wait until element is visible except stale     ${product_name_locator}
    END

Verify unit price at PDP
    [Arguments]     ${price}
    IF   "${platform}" == "${platform_list['android']}"
        ${txt_price_locator}    String.Replace string    ${product_page.txt_price}    {{price}}    ${price}
        DobbyAppCommon.Wait until element is visible except stale        ${txt_price_locator} 
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        ${txt_name_price_locator}    String.Replace string    ${product_page.txt_name_price}    {{price}}    ${price}
        DobbyAppCommon.Wait until element is visible except stale        ${txt_name_price_locator}
    END

Verify discounted price at PDP
    [Arguments]     ${price}
    IF   "${platform}" == "${platform_list['android']}"
        ${scroll_txt_price_locator}    String.Replace string    ${product_page.scroll_txt_price}    {{price}}    ${price}
        DobbyAppCommon.Wait until element is visible except stale        ${scroll_txt_price_locator}
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        ${txt_name_price_locator}    String.Replace string    ${product_page.txt_name_price}    {{price}}    ${price}
        DobbyAppCommon.Wait until element is visible except stale        ${txt_name_price_locator}
    END

Verify 1P delivery time at PDP
    mobile_common.Verify message in textview       ${mobile_additional['delivery time 1P']['title']}
    mobile_common.Verify message in textview       ${mobile_additional['delivery time 1P']['sub_title']}
    mobile_common.Verify message in textview       ${mobile_additional['delivery time 1P']['description1']}
    mobile_common.Verify message in textview       ${mobile_additional['delivery time 1P']['description2']}

Verify expected delivery date at PDP
    [Arguments]     ${mindate}      ${maxdate}
    ${current_date}     DateTime.Get current date       result_format=%d 
    ${current_date}     Convert to integer      ${current_date}
    ${min_delivery}     Evaluate    ${current_date}+${mindate}
    ${max_delivery}     Evaluate    ${current_date}+${maxdate}
    ${min_delivery}     ${minmonth}	    mobile_common.End of month date evaluation    ${min_delivery}
    ${max_delivery}     ${maxmonth}	    mobile_common.End of month date evaluation    ${max_delivery}
    ${min_delivery}     Convert to string   ${min_delivery}
    ${max_delivery}     Convert to string   ${max_delivery}
    ${min_delivery_locator}    String.Replace string    ${product_page.delivery_between}    {{min_delivery}}    ${min_delivery}
    ${minmonth_locator}        String.Replace string    ${min_delivery_locator}    {{minmonth}}    ${minmonth}
    ${max_delivery_locator}    String.Replace string    ${minmonth_locator}    {{max_delivery}}    ${max_delivery}
    ${delivery_between_locator}    String.Replace string    ${max_delivery_locator}    {{maxmonth}}    ${maxmonth}
    DobbyAppCommon.Wait until element is visible except stale        ${delivery_between_locator}

Verify description at PDP
    [Arguments]     ${name}
    ${txt_detail_productname_locator}    String.Replace string    ${product_page.txt_detail_productname}    {{name}}    ${name}
    mobile_common.Find element            ${txt_detail_productname_locator}

Verify total volume at PDP
    [Arguments]     ${name}
    ${txt_net_weight_locator}    String.Replace string    ${product_page.txt_net_weight}    {{name}}    ${name}
    mobile_common.Find element            ${txt_net_weight_locator}

Verify product code at PDP
    [Arguments]     ${code}
    ${code}     Convert to string      ${code} 
    ${txt_code_locator}    String.Replace string    ${product_page.txt_code}    {{name}}    ${code}
    mobile_common.Find element     ${txt_code_locator}

Verify seller name at PDP
    [Arguments]     ${name}
    ${txt_sell_by_locator}    String.Replace string    ${product_page.txt_sell_by}    {{name}}    ${name}
    mobile_common.Find element     ${txt_sell_by_locator}
   
Verify alert product exceed display
    IF   "${platform}" == "${platform_list['android']}"
        mobile_common.Find element    ${product_page.txt_morethan_stock}
        AppiumLibrary.Wait until page does not contain element     ${product_page.txt_morethan_stock}
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        AppiumLibrary.Wait until page contains    ${product_additional['message']['morethan_stock']}
    END
    
Verify product item count on sub category page display 0 item
    DobbyAppCommon.Wait until element is visible except stale   ${product_page.txt_zero_list}
    AppiumLibrary.Page should not contain element       ${product_page.product_item_gid}

Verify product item count on sub category page display X item
    [Arguments]     ${sub_category}     ${items}
    IF   "${platform}" == "${platform_list['android']}"
        ${sub_category_locator}    String.Replace string    ${product_page.sub_category_list}    {{sub_category}}    ${sub_category}
        ${sub_category_list_locator}    String.Replace string    ${sub_category_locator}    {{items}}    ${items}
        DobbyAppCommon.Wait until element is visible except stale   ${sub_category_list_locator}
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        ${sub_category_locator}    String.Replace string    ${product_page.txt_sub_category}    {{sub_category}}    ${sub_category}
        ${items_locator}    String.Replace string    ${product_page.items}    {{items}}    ${items}
        DobbyAppCommon.Wait until element is visible except stale   ${sub_category_locator}
        DobbyAppCommon.Wait until element is visible except stale   ${items_locator}
    END

Verify correct percentage of discount at PDP
    DobbyAppCommon.Wait until element is visible except stale        ${product_page.txt_discount_price}
    ${original_price}    DobbyAppCommon.Get text from element when ready    ${product_page.txt_original_price}
    ${discounted_price}  DobbyAppCommon.Get text from element when ready    ${product_page.txt_discount_price}
    ${original_price}    String.Split string  ${original_price}
    ${discounted_price}  String.Split string  ${discounted_price}
    ${percent_discount}  Evaluate     (${original_price}[0]-${discounted_price}[0])*100/${original_price}[0]
    ${percent_discount}  Convert to string  ${percent_discount}
    ${percent_discount}  String.Split string       ${percent_discount}  .
    ${txt_percent_discount_locator}    String.Replace string    ${product_page.txt_percent_discount}    {{percent_discount}}    ${percent_discount}[0]
    DobbyAppCommon.Wait until element is visible except stale  ${txt_percent_discount_locator}

Verify discount duration not shown at PDP
    AppiumLibrary.Page should not contain element  ${product_page.txt_discount}

Verify 1P delivery time at product card
    [Arguments]     ${name}
    ${1p_delivery_time_locator}    String.Replace string    ${product_page.1p_delivery_time}    {{name}}    ${name}
    DobbyAppCommon.Wait until element is visible except stale  ${1p_delivery_time_locator}

Verify 1P delivery time at product card in recommendation
    DobbyAppCommon.Wait until element is visible except stale  ${product_page.1P_sub_title} 

Verify discount starts date is shown at PDP
    DobbyAppCommon.Wait until element is visible except stale  ${product_page.txt_discount_from}
    ${date_month}  DobbyAppCommon.Get text from element when ready  ${product_page.txt_discount_from_txt}
    IF  "${lang}"=="en"
        ${date_month}  String.Get regexp matches  ${date_month}   \\d{2} [a-zA-Z]{1,3}
    ELSE
        ${date_month}  String.Get regexp matches  ${date_month}   \\d{2} [ก-โ]{1,2}[.][ก-ฮ][.]
    END
    ${amount_date_month}  Get length  ${date_month}
    Should be true  ${amount_date_month}==1

Verify discount end date is shown at PDP
    DobbyAppCommon.Wait until element is visible except stale  ${product_page.txt_discounted_to}
    ${date_month}  DobbyAppCommon.Get text from element when ready  ${product_page.txt_discounted_to_txt}
    IF  "${lang}"=="en"
        ${date_month}  String.Get regexp matches  ${date_month}   \\d{2} [a-zA-Z]{1,3}
    ELSE
        ${date_month}  String.Get regexp matches  ${date_month}   \\d{2} [ก-โ]{1,2}[.][ก-ฮ][.]
    END
    ${amount_date_month}  Get length  ${date_month}
    Should be true  ${amount_date_month}==1

Verify discount start and end date is shown at PDP
    DobbyAppCommon.Wait until element is visible except stale  ${product_page.txt_discounted_between}
    ${date_month}  DobbyAppCommon.Get text from element when ready  ${product_page.txt_discounted_between_txt}
    IF  "${lang}"=="en"
        ${date_month}  String.Get regexp matches  ${date_month}   \\d{1,2} [a-zA-Z]{1,3} - \\d{1,2} [a-zA-Z]{1,3}
    ELSE
        ${date_month}  String.Get regexp matches  ${date_month}   \\d{2} [ก-โ]{1,2}[.][ก-ฮ][.] - \\d{2} [ก-โ]{1,2}[.][ก-ฮ][.]
    END
    ${amount_date_month}  Get length  ${date_month}
    Should be true  ${amount_date_month}==1

Sub category should not be displayed    
    [Arguments]     ${sub_category}
    ${sub_category_locator}    String.Replace string    ${product_page.txt_sub_category}    {{sub_category}}    ${sub_category}
    AppiumLibrary.Page should not contain element     ${sub_category_locator}

Verify product display percent flat discout
    [Arguments]     ${productname}      ${percentdiscount}
    ${productname_locator}    String.Replace string    ${product_page.percentdiscount}    {{productname}}    ${productname}
    ${percentdiscount_locator}    String.Replace string    ${productname_locator}    {{percentdiscount}}    ${percentdiscount}
    DobbyAppCommon.Wait until element is visible except stale   ${percentdiscount_locator}
    
Click trash icon on product
    [Arguments]    ${productname}
    ${trash_btn_icon_locator}    String.Replace string    ${product_page.trash_btn_icon}    {{productname}}    ${productname}
    DobbyAppCommon.Tap element when ready   ${trash_btn_icon_locator}
    mobile_common.wait until loading complete

Veriy product display product brand on product card
    [Arguments]    ${productname}       ${brandname}
    ${productname_locator}    String.Replace string    ${product_page.txt_brandname}    {{product}}    ${productname}
    ${txt_brandname_locator}    String.Replace string    ${productname_locator}    {{brandname}}    ${brandname}
    DobbyAppCommon.Wait until element is visible except stale   ${txt_brandname_locator}
    
Scroll down to recommendation module from PDP
    IF   "${platform}" == "${platform_list['android']}"
        mobile_common.Scroll down to element  ${product_page.also_like_list} 
        DobbyAppCommon.Swipe down
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        mobile_common.Scroll down to element  ${product_page.recommended_product_list_title}
        DobbyAppCommon.Swipe down
    END

Get name of first product in recommendation module
    IF   "${platform}" == "${platform_list['android']}"
        ${name}    DobbyAppCommon.Get text from element when ready      ${product_page.list_item_title}
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        ${name}    AppiumLibrary.Get Element Attribute         ${product_page.recommended_product_list}    name
    END
    [Return]    ${name}

Tap product in recommendation
    [Arguments]     ${productname}
    IF   "${platform}" == "${platform_list['android']}"
        ${txt_productnamee_locator}    String.Replace string    ${product_page.txt_productname}    {{productname}}    ${productname}
        DobbyAppCommon.Tap element when ready         ${txt_productnamee_locator}
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        ${recommended_product_list_product_locator}    String.Replace string    ${product_page.recommended_product_list_product}    {{productname}}    ${productname}
        DobbyAppCommon.Tap element when ready         ${recommended_product_list_product_locator}
    END

Add product to basket in recommendation
    [Arguments]     ${productname}
    ${recommended_txt_add_to_basket_locator}    String.Replace string    ${product_page.txt_add_to_basket}    {{productname}}    ${productname}
    DobbyAppCommon.Tap element when ready       ${recommended_txt_add_to_basket_locator}

Increase quantity by clicking in recommendation
    [Documentation]   avoid to using loop click by number because loading not stable
    [Arguments]     ${productname}
    IF   "${platform}" == "${platform_list['android']}"
        ${increment_btn_wrapper_locator}    String.Replace string    ${product_page.recommended_increment_btn_wrapper}    {{productname}}    ${productname}
        DobbyAppCommon.Tap element when ready    ${increment_btn_wrapper_locator}
        mobile_common.Wait until loading complete
    ELSE IF    "${platform}" == "${platform_list['ios']}" 
        ${recommended_increment_btn_wrapper_locator}    String.Replace string    ${product_page.recommended_increment_btn_wrapper}    {{productname}}    ${productname}
        DobbyAppCommon.Tap element when ready    ${recommended_increment_btn_wrapper_locator}
        mobile_common.Wait until loading complete
    END
   
Decrease quantity by clicking in recommendation
    [Documentation]   avoid to using loop click by number because loading not stable
    [Arguments]     ${productname}
    IF   "${platform}" == "${platform_list['android']}"
        ${decrement_btn_wrapper_locator}    String.Replace string    ${product_page.decrement_btn_wrapper}    {{productname}}    ${productname}
        DobbyAppCommon.Tap element when ready    ${decrement_btn_wrapper_locator}
        mobile_common.Wait until loading complete
    ELSE IF    "${platform}" == "${platform_list['ios']}"    
        ${recommended_decrement_btn_wrapper_locator}    String.Replace string    ${product_page.recommended_decrement_btn_wrapper}    {{productname}}    ${productname}
        DobbyAppCommon.Tap element when ready    ${recommended_decrement_btn_wrapper_locator}
        mobile_common.Wait until loading complete
    END    
    
Adjust quantity by typing in recommendation
    [Arguments]     ${productname}      ${qty}
    ${also_like_qty_input_locator}    String.Replace string    ${product_page.also_like_qty_input}    {{productname}}    ${productname}
    IF   "${platform}" == "${platform_list['android']}"
        DobbyAppCommon.Wait until element is visible except stale           ${also_like_qty_input_locator}
        DobbyAppCommon.Input text to element when ready             ${also_like_qty_input_locator}         ${qty}
        DobbyAppCommon.Tap element when ready         ${also_like_qty_input_locator} 
        Press keycode   66   # Enter key
    ELSE IF    "${platform}" == "${platform_list['ios']}"   
        DobbyAppCommon.Tap element when ready    ${also_like_qty_input_locator}
        DobbyAppCommon.Clear text when ready       ${also_like_qty_input_locator}
        DobbyAppCommon.Input text to element when ready     ${also_like_qty_input_locator}    ${qty}
        DobbyAppCommon.Tap element when ready      ${product_page.succesess}
    END

Verify product quantity in recommendation
    [Arguments]     ${productname}      ${quantity}
    IF   "${platform}" == "${platform_list['android']}"
        ${productname_locator}    String.Replace string    ${product_page.also_like_quantity}    {{productname}}    ${productname}
        ${also_like_quantity_locator}    String.Replace string    ${productname_locator}    {{quantity}}    ${quantity}
        DobbyAppCommon.Wait until element is visible except stale        ${also_like_quantity_locator}
    ELSE IF    "${platform}" == "${platform_list['ios']}"   
        ${also_like_qty_input_locator}    String.Replace string    ${product_page.also_like_qty_input}    {{productname}}    ${productname}
        Element value should be        ${also_like_qty_input_locator}       ${quantity}
    END

Verify no out of stock product in shown in recommendation   
    IF   "${platform}" == "${platform_list['android']}"
        AppiumLibrary.Page should not contain element      ${product_page.also_like_out_of_stock}
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        AppiumLibrary.Page should not contain element      ${product_page.out_of_stock}
    END

Verify product can add to basket
    [Arguments]     ${product}
    ${product_add_to_basket_locator}    String.Replace string    ${product_page.product_add_to_basket}    {{product}}    ${product}
    ${txt_out_of_area_locator}    String.Replace string    ${product_page.txt_out_of_area}    {{product}}    ${product}
    DobbyAppCommon.Wait until element is visible except stale       ${product_add_to_basket_locator}
    AppiumLibrary.Page should not contain element     ${txt_out_of_area_locator}

Verify product out of delivery area
    [Arguments]    ${product}    ${3p_ownfleet}=${false}
    ${product_locator}    String.Replace string    ${search_page.product_card}     {{product}}    ${product}
    ${txt_out_of_area_locator}    String.Replace string    ${product_page.txt_out_of_area}    {{product}}    ${product}
    IF   '${3p_ownfleet}' == '${false}'
        mobile_common.Find element      ${product_locator}
    ELSE IF   '${3p_ownfleet}' == '${true}'
        DobbyAppCommon.Wait until element is visible except stale       ${txt_out_of_area_locator}
    END
    
Verify product discontinued
    DobbyAppCommon.Wait until element is visible except stale       ${product_page.txt_product_discontinued}
    DobbyAppCommon.Wait until element is visible except stale       ${product_page.txt_already_removed}

Verify product page is recommendation page
    DobbyAppCommon.Wait until element is visible except stale       ${product_page.txt_best_seller_this_month}
    
Verify product page is fresh page
    DobbyAppCommon.Wait until element is visible except stale       ${product_page.fresh_products}
    
Verify product quantity at PDP not equal
    [Arguments]     ${productname}          ${quantity}
    ${productname_qty_input_locator}    String.Replace string    ${product_page.productname_qty_input}    {{productname}}    ${productname}
    IF   "${platform}" == "${platform_list['android']}"
        ${qty_show}=    DobbyAppCommon.Get text from element when ready        ${productname_qty_input_locator}
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        ${qty_show}=    mobile_common.Get element attribute when ready        ${productname_qty_input_locator}       value
    END
    Should not be equal    ${qty_show}       ${quantity}

# Android

Verify sub category does not display
    [Arguments]     ${sub_category}
    ${txt_sub_category_locator}    String.Replace string    ${product_page.txt_sub_category}    {{sub_category}}    ${sub_category}
    AppiumLibrary.Wait until page does not contain element   ${txt_sub_category_locator}

Verify sub category display empty page
    AppiumLibrary.Wait until page does not contain element   ${product_page.scrollview}

Getting product price from order card
    [Arguments]     ${order_no}
    ${txt_order_no_locator}    String.Replace string    ${product_page.txt_order_no}    {{order_no}}    ${order_no}
    ${price}=    DobbyAppCommon.Get text from element when ready    ${txt_order_no_locator}
    [Return]    ${price}

Click expand detail button
    DobbyAppCommon.Tap element when ready    ${product_page.description}

# iOS

Verify product quantity at PLP
    [Arguments]     ${product}      ${quantity}
    DobbyAppCommon.Wait until element is visible except stale        ${product_page.txt_qty_input}
    ${quantity_counter_locator}    String.Replace string    ${product_page.quantity_counter}    {{product}}    ${product}
    Element value should be    ${quantity_counter_locator}    ${quantity}   

Check product price with discount at product card  
    [Arguments]     ${productname}  ${original}    ${discount}
    ${productname_locator}    String.Replace string    ${product_page.txt_discount}    {{productname}}    ${productname}
    ${txt_discount_locator}    String.Replace string    ${productname_locator}    {{original}}    ${original}
    DobbyAppCommon.Wait until element is visible except stale   ${txt_discount_locator}
    DobbyAppCommon.Wait until element is visible except stale   ${txt_discount_locator}
   
Verify product price at PDP
    [Arguments]     ${price}
    ${txt_price_locator}    String.Replace string    ${product_page.txt_price}    {{price}}    ${price}
    DobbyAppCommon.Wait until element is visible except stale       ${txt_price_locator}

Verify product item count many from 20+ on sub category page display X item
    [Arguments]     ${sub_category}     ${items}
    ${sub_category_locator}    String.Replace string    ${product_page.txt_sub_category}    {{sub_category}}    ${sub_category}
    ${items_locator}    String.Replace string    ${product_page.items}    {{items}}    ${items}
    DobbyAppCommon.Wait until element is visible except stale   ${sub_category_locator}
    DobbyAppCommon.Wait until element is visible except stale   ${items_locator}

Verify product quantity
    [Arguments]     ${product}      ${quantity}
    ${product_locator}    String.Replace string    ${product_page.qty_input_quantity}    {{product}}    ${product}
    ${qty_input_quantity_locator}    String.Replace string    ${product_locator}    {{quantity}}    ${quantity}
    DobbyAppCommon.Wait until element is visible except stale      ${qty_input_quantity_locator}

Click back button to PLP
    DobbyAppCommon.Tap element when ready   ${product_page.back_button}

Increase quantity at PDP
    [Arguments]     ${round}
    FOR    ${i}    IN RANGE    ${round}
        DobbyAppCommon.Tap element when ready    ${product_page.btn_increment_btn_icon}
        sleep  3s
    END

Verify product quantity at PDP on typing mode
    [Arguments]     ${quantity}
    IF   "${platform}" == "${platform_list['android']}"
        ${att}=  mobile_common.Get element attribute when ready    ${product_page.qty_input}  text
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        ${att}=  mobile_common.Get element attribute when ready    ${product_page.qty_input}  value
    END
    Should Be Equal   '${quantity}'   '${att}'

Verify product quantity at PLP after add product exceed
    [Arguments]     ${quantity}
    FOR    ${i}    IN RANGE    5
        ${element_status}=      Run keyword and return status    DobbyAppCommon.Wait until element is visible except stale      ${product_page.txt_qty_input}     timeout=3s
        IF  '${element_status}'=='False'     
            DobbyAppCommon.Swipe down
        END
        Exit for loop iF    '${element_status}'=='True'
    END 
    Element value should be    ${product_page.txt_qty_input}      ${quantity}

Click add to basket after select then back to shopping menu
    DobbyAppCommon.Tap element when ready         ${product_page.add_to_basket}
    mobile_common.Tap shopping menu

Click back button on shopping menu
    DobbyAppCommon.Tap element when ready    ${product_page.search_product}

Click expand detail at PDP
    mobile_common.Find element and tap     ${product_page.txt_detail}

Verify target badge display on product on PDP page
    [Arguments]     ${badge_name}   ${product_name}
    ${badge_locator}     String.Replace string      ${product_page.txt_badge_product}   {{badge_name}}    ${badge_name}
    ${product_with_badge_locator}   String.Replace string       ${badge_locator}   {{product_name}}   ${product_name}
    DobbyAppCommon.Wait until element is visible except stale   ${product_with_badge_locator}

Verify the product not sold by makro
    mobile_common.Find element    ${product_page.sold_by}
    AppiumLibrary.Page should not contain element   ${product_page.sold_by_makro}

Get discount price from product
    [Arguments]        ${product}
    ${price_locator}     String.Replace string      ${productcard_page.discount_price}   {{product}}    ${product}
    ${discount_price}  DobbyAppCommon.Get text from element when ready      ${price_locator}
    ${price}=       String.Remove string       ${discount_price}    ${SPACE}    ฿  
    [Return]    ${price}

Get original price from product
    [Arguments]        ${product}
    ${price_locator}     String.Replace string      ${productcard_page.original_price}   {{product}}    ${product}
    ${original_price}  DobbyAppCommon.Get text from element when ready      ${price_locator}
    ${price}=       String.Remove string       ${original_price}    ${SPACE}    ฿  
    [Return]    ${price}

Verify product show slab price at PLP
    [Arguments]   ${slab_price}
    ${slab_price_locator}    String.Replace string    ${product_page.slab_price}     {{slab_price}}    ${slab_price}
    DobbyAppCommon.Find element    ${slab_price_locator}   scroll_panel=${default_scroll_view}    moveto=Top    percent=${swipeLongScroll}  timeout=${shortTimeout}
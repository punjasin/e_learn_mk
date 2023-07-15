*** Settings ***
Resource        ../pages/search_page.resource
Resource        ../pages/search_advance_page.resource
Resource        ../pages/productcard_page.resource
Resource        ../pages/voucher_page.resource
Resource        ../pages/basket_page.resource
Resource        voucher_feature.resource
Resource        search_feature.resource
Resource        login_feature.resource

*** Keywords ***
Search and add multiple products to basket
    [Arguments]     ${product_name}     ${amount}=${empty}      ${product_keyword}=${empty}
    mobile_common.Tap shopping menu  accept_popup=False
    IF    '${product_keyword}' == '${empty}' or '${product_keyword}' == '*'            
        search_page.Search for product with searchbar           ${product_name}
    ELSE
        search_advance_page.Typing search                    ${product_keyword}
    END
    ${found_view_all_btn}   Run keyword and return status   DobbyAppCommon.Wait until element is visible except stale   ${search_advance.see_all}   timeout=${shortTimeout}
    IF   "${found_view_all_btn}"=="${True}"
        search_advance_page.Click view all button
    END
    basket_feature.Add to basket with product name and quantity     ${product_name}     ${amount}
    mobile_common.Tap basket menu
    
Add to basket with product name and quantity
    [Arguments]     ${product_name}     ${amount}=${empty}
    productcard_page.Tap add to basket button               ${product_name}
    IF  "${amount}"!="${empty}"
        product_page.Increase quantity by clicking on PDP     ${product_name}      ${amount}
    END
    productcard_page.Update basket    ${product_name}
    
Search and add all products name to basket
    [Arguments]    ${all_product_name_list}   ${increase_amount_list}   ${product_keyword_list}=${empty}
    ${len_add_list}     Evaluate    len(${all_product_name_list})
    FOR    ${index}     IN RANGE        ${len_add_list}
        basket_feature.Search and add multiple products to basket  ${all_product_name_list}[${index}]    ${increase_amount_list}[${index}]      ${product_keyword_list}[${index}]
    END

Search and get total price with qty from search page
    [Arguments]     ${product_name}     ${increase_amount}
    mobile_common.Tap shopping menu  accept_popup=${FALSE}
    search_feature.Search product from searchbar    ${product_name}
    ${unit_price}    search_page.Get product price at search page    ${product_name}
    productcard_page.Tap add to basket button       ${product_name}
    product_page.Increase quantity by clicking on PDP     ${product_name}   ${increase_amount}
    productcard_page.Update basket   ${product_name}
    ${total_qty}       mobile_common.Get new qty after click increase button      ${increase_amount}
    ${unit_price}      String.Remove string        ${unit_price}        .00 ฿
    ${total_price}     mobile_common.Get total price by qty        ${unit_price}        ${total_qty}
    [Return]           ${total_price}

Search and add all dynamic products to basket
    [Arguments]    ${seller_list}    ${qty_list}    ${discount}=${False}    ${total_product}=1    ${target_brand}=${empty}
    ...              ${upper_range}=${True}        ${price_range}=1
    ${total_product}    Convert to integer    ${total_product}
    ${seller_dict}      Create Dictionary
    FOR     ${index}  ${seller}     IN ENUMERATE     @{seller_list}
        ${key_index}        Set variable    seller_${index}
        ${product_detail}    search_api_feature.Search dynamic product from db    seller=${seller}    total_product=${total_product}    upper_range=${upper_range}    price_range=${price_range}    target_brand=${target_brand}
        ${product_detail}    search_api_feature.Set target qty product    ${product_detail}      ${qty_list}
        Collections.Set to dictionary    ${seller_dict}    ${key_index}    ${product_detail}
        FOR    ${item}    IN    @{product_detail}
            basket_feature.Search and add multiple products to basket  ${item['productname']}    ${item['qty']}
        END
    END
    ${new_qty_list}      mobile_common.Get new qty after click increase as array list  ${qty_list}
    ${seller_dict}       search_api_feature.Update target qty product        ${seller_dict}      ${new_qty_list}
    [Return]        ${seller_dict}

Verify total price should be
    [Documentation]     iOS, Pass with .00 as argument (ex. 100.00)
    [Arguments]     ${expected_price}
    IF   "${platform}" == "${platform_list['android']}"
        DobbyAppCommon.Find element      ${basket.txt_total_price}   scroll_panel=${default_scroll_view}    moveto=Top    percent=${swipeLongScroll}      timeout=${shortTimeout}
        ${total}       DobbyAppCommon.Get text from element when ready     ${basket.txt_total_price}
        ${total_all}        String.Remove string        ${total}      ${SPACE}฿
        Should be equal     ${expected_price}       ${total_all}
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        ${expected_price_locator}    String.Replace string    ${basket_feature.contains_expected_price}    {{expected_price}}    ${expected_price}
        AppiumLibrary.Wait Until Element Is Visible     ${expected_price_locator}
    END

Verify total price with voucher or point applied should be
    [Documentation]     iOS, Pass with .00 as argument (ex. 100.00)
    [Arguments]     ${expected_price}
    IF   "${platform}" == "${platform_list['android']}"
        DobbyAppCommon.Find element      ${basket_feature.txt_total_price}   scroll_panel=${default_scroll_view}    moveto=Top    percent=${swipeLongScroll}      timeout=${shortTimeout}
        ${total}       DobbyAppCommon.Get text from element when ready     ${basket_feature.txt_total_price}
        ${total_all}        String.Remove string        ${total}      ${SPACE}฿
        Should be equal     ${expected_price}           ${total_all}
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        ${contains_expected_price_locator}    String.Replace string    ${basket_feature.contains_expected_price}    {{expected_price}}    ${expected_price}
        DobbyAppCommon.Find element           ${contains_expected_price_locator}    scroll_panel=${default_scroll_view}    moveto=Top    percent=${swipeLongScroll}      timeout=${shortTimeout}
    END

# Android

Add product with discount to basket
    [Arguments]     ${product}       ${originalprice}        ${discountprice}
    mobile_common.Tap shopping menu  accept_popup=False
    search_feature.Search product from searchbar       ${product} 
    productcard_page.Click add to basket at product card      ${product} 
    productcard_page.Verify product price at product card  ${product}   ${originalprice}    ${discountprice}

Add 3P product that have discount
    [Arguments]     ${originalprice}        ${discountprice}
    mobile_common.Tap shopping menu  accept_popup=False
    search_feature.Search product from searchbar       ${product_data['3P']}
    productcard_page.Click add to basket at product card      ${product_data['3P']}
    productcard_page.Verify product price at product card  ${product_data['3P']}  ${originalprice}  ${discountprice}

Verify the detail of 1P products in the section
    [Arguments]    ${product_info}   ${qty}     ${product_name}
    mobile_common.Swipe to the top of page       ${shortNumberScroll}
    basket_page.Verify 1P product delivery by brand name        ${seller_name['1P_basket_seller']}
    basket_page.Verify product 1P header contain choose delivery date and time at checkout
    basket_page.Verify 1P product tooltip popup display detail  ${seller_name['1P_basket_seller']}
    basket_page.Verify product and quantity display in basket   ${product_name}    ${qty}
    basket_page.Verify unit size is correct                     ${product_name}    ${product_info['size']}
    basket_page.Verify product display all prices correct       ${product_name}    ${product_info['original_price']}     ${product_info['display_price']}

Verify the detail of 3P products in the section
    [Arguments]    ${product_info}   ${qty}     ${product_name}
    mobile_common.Swipe to the top of page      ${shortNumberScroll}
    basket_page.Verify 3P product delivery by brand name        ${product_info['seller']}
    basket_page.Verify delivery date start and end date is shown at basket      ${product_info['seller']}
    basket_page.Verify 3P product tooltip popup display detail  ${product_info['seller']}
    basket_page.Verify product and quantity display in basket   ${product_name}     ${qty}
    basket_page.Verify unit size is correct                     ${product_name}     ${product_info['size']}
    basket_page.Verify product display all prices correct       ${product_name}     ${product_info['original_price']}     ${product_info['display_price']}

Verify product quantity then increase quantity
    [Arguments]    ${product_name}    ${current_qty}    ${qty_to_increase}    ${increased_qty}
    basket_page.Verify product and quantity display in basket  ${product_name}  qty=${current_qty}
    basket_page.Increase quantity by clicking at basket    ${product_name}    ${qty_to_increase}
    basket_page.Verify product and quantity display in basket  ${product_name}  qty=${increased_qty}

Verify product quantity then decrease quantity
    [Arguments]    ${product_name}    ${current_qty}    ${qty_to_decrease}    ${decreased_qty}
    basket_page.Verify product and quantity display in basket  ${product_name}  qty=${current_qty}
    basket_page.Decrease quantity by clicking at basket    ${product_name}    ${qty_to_decrease}
    basket_page.Verify product and quantity display in basket  ${product_name}  qty=${decreased_qty}

Verify summary price in basket
    [Arguments]     ${all_product_price_list}   ${qty_list}
    ${total_all_price}     mobile_common.Calculate all total price with qty  ${all_product_price_list}   ${qty_list}
    ${found_promotion_discount}    Run keyword and return status    basket_page.Verify product discount label display
    IF   ${found_promotion_discount}==${True}
        ${sub_total_price}     basket_page.Get total product price with product promotion discount  ${total_all_price}
        ${sub_total_price}     Evaluate      "{:,.2f}".format(${sub_total_price})
        basket_page.Verify sub total price is correct   ${sub_total_price}
    END
    ${total_price_with_fee}       basket_page.Get total price with delivery fee     ${total_all_price}
    basket_feature.Verify total price should be               ${total_price_with_fee}
    [Return]        ${total_all_price}

Select product from dry food category on PLP
    [Arguments]     ${product}
    mobile_common.Tap shopping menu  accept_popup=False
    product_page.Select main category       ${mobile_additional['main_category']['dry food']}
    product_page.Select sub category        ${mobile_additional['sub_category']['vinegar and oils']}
    product_page.Find product on list       ${product}    
    product_page.Select product             ${product}

Verify total price with fee is correct after remove voucher
    [Arguments]     ${total_price}      ${voucher_name}
    voucher_page.Click x button to remove voucher code on basket page               ${voucher_name}
    ${total_price_with_fee}       basket_page.Get total price with delivery fee     ${total_price}
    basket_feature.Verify total price should be                              ${total_price_with_fee}

Verify total price with discount is correct after applied voucher
    [Arguments]     ${total_price}      ${voucher_data}
    voucher_feature.Apply voucher code on basket page       ${voucher_data['voucher_name']}
    voucher_page.Verify voucher code applied success        ${voucher_data['voucher_name']}   ${voucher_data['voucher_value']}
    ${total_price_with_discount}  basket_page.Get total price with discount code  ${total_price}  ${voucher_data['voucher_value']}
    basket_feature.Verify total price with voucher or point applied should be         ${total_price_with_discount}

Verify login after added basket have voucher applied and total price correct
    [Arguments]     ${total_price}      ${login_data}      ${voucher_data}
    login_feature.Login after click checkout button     ${login_data['email']}     ${login_data['password']}
    mobile_common.Tap X button to close webview
    voucher_page.Verify voucher code applied success    ${voucher_data['voucher_name']}   ${voucher_data['voucher_value']}
    ${total_price_with_discount}  basket_page.Get total price with discount code  ${total_price}  ${voucher_data['voucher_value']}
    basket_feature.Verify total price with voucher or point applied should be         ${total_price_with_discount}

Verify quantity in basket after click increase or decrease button
    [Arguments]     ${product_name}     ${increase_amount}      ${decrease_amount}
    [Documentation]  This kw can use verify product qty in search page, product page and cart page
    ${default_qty}          Set variable                1
    basket_page.Verify product and quantity display in basket         ${product_name}       ${default_qty}  

    basket_page.Increase quantity by clicking at basket   ${product_name}   ${increase_amount}
    ${qty_after_added}      mobile_common.Get new qty after click increase button      ${default_qty}       ${increase_amount}
    basket_page.Verify product and quantity display in basket         ${product_name}       ${qty_after_added}
    
    basket_page.Decrease quantity by clicking at basket   ${product_name}   ${decrease_amount}
    ${qty_after_del}        mobile_common.Get new qty after click decrease button  ${qty_after_added}     ${decrease_amount}
    basket_page.Verify product and quantity display in basket         ${product_name}      ${qty_after_del}
    [Return]                ${qty_after_del}

Delete product on basket
    [Arguments]     ${product_name}
    basket_page.Click trash icon on basket page    ${product_name}
    basket_page.Verify product is deleted      ${product_name}

Verify quantity in basket after adjust quantity
    [Arguments]     ${product_name}    ${adjust}
    basket_page.Adjust quantity by typing at basket  ${product_name}    ${adjust}
    basket_page.Verify product and quantity display in basket  ${product_name}    ${adjust}

Adjust product quantity to zero and verify product is deleted
    [Arguments]     ${product_name}
    basket_page.Adjust quantity by typing at basket  ${product_name}   ${0}           
    basket_page.Verify alert removed product display
    basket_page.Verify product is deleted      ${product_name}

Swipe to delete product and verify product is deleted
    [Arguments]     ${product_name}
    basket_page.Swipe to delete product by product name     ${product_name}
    basket_page.Verify product is deleted      ${product_name}

Verify empty basket
    basket_page.Verify basket cleared
    basket_page.Verify checkout button disabled
    basket_page.Verify browse categories button enabled

Verify product has been deleted successfully
    [Arguments]     ${product_name}
    mobile_common.tap basket menu
    basket_feature.Swipe to delete product and verify product is deleted    ${product_name}
    basket_feature.Verify empty basket

Verify total price after discount and original price correct
    [Arguments]     ${expected_total_price}     ${discount_value}
    ${total_price_with_discount}  basket_page.Get total price with discount code    ${expected_total_price}     ${discount_value}
    basket_feature.Verify total price with voucher or point applied should be       ${total_price_with_discount}
    ${total_price_with_fee}       basket_page.Get total price with delivery fee     ${expected_total_price}
    basket_feature.Verify total price should be                                     ${total_price_with_fee}

Verify point form display all fields correct before confirm
    [Arguments]     ${point_value}
    basket_page.Tap expand makro point button
    basket_page.Verify confirm pay by point button is disabled
    basket_page.Input point for discount payment              ${point_value}
    basket_page.Verify point display in placeholder
    basket_page.Verify close button display inside input point
    basket_page.Verify confirm pay by point button is enabled

Verify point form display all fields correct after confirm
    basket_page.Tap expand makro point button
    basket_page.Verify input point disabled after confirmed
    basket_page.Verify point display in placeholder
    basket_page.Verify close button not display inside input point
    basket_page.Verify confirm pay by point button is not display
    voucher_page.Verify voucher form is not display

Verify discount by point successfully
    [Arguments]     ${point_value}
    basket_page.Verify toast message add point successfully
    basket_page.Verify makro pro point tag display in discount
    basket_page.Verify remove point for use discount coupon display
    basket_page.Verify amount after apply point display correct  ${point_value}

Tap decrease quantity from expected qty amount
    [Arguments]     ${product_detail}     ${expected_minus_qty}
    ${target_qty_minus}     mobile_common.Get target qty to decrease from expected qty  ${expected_minus_qty}  ${product_detail['qty']}
    basket_page.Decrease quantity by clicking at basket  ${product_detail['productname']}  ${target_qty_minus}
    ${new_qty}      basket_page.Get current qty amount   ${product_detail['productname']}
    [Return]        ${new_qty}

Tap increase quantity from expected qty amount
    [Arguments]     ${product_detail}     ${expected_add_qty}
    ${target_qty_added}     mobile_common.Get target qty to add from expected qty  ${expected_add_qty}  ${product_detail['qty']}
    basket_page.Increase quantity by clicking at basket   ${product_detail['productname']}  ${target_qty_added} 
    ${new_qty}      basket_page.Get current qty amount   ${product_detail['productname']}
    [Return]       ${new_qty}

Verify summary price from product detail and move to top
    [Arguments]     ${product_detail}
    ${price_list}    Create list
    ${qty_list}      Create list
    FOR   ${index}    ${seller_key}    IN ENUMERATE      @{product_detail}
        FOR   ${record_index}    ${products}    IN ENUMERATE      @{product_detail['${seller_key}']}
            Collections.Append to list    ${price_list}    ${products['display_price']} 
            Collections.Append to list    ${qty_list}      ${products['qty']}
        END
    END
    basket_feature.Verify summary price in basket     ${price_list}  ${qty_list}
    mobile_common.Swipe to the top of page       ${shortNumberScroll}

Check all products price correct by increase and decrease qty follow odd and even order
    [Arguments]     ${product_detail}       ${increase_amount}      ${decrease_amount}
    [Documentation]     this kw test all product in basket, check if even order number will decrease qty amount
    ...     if odd order number will increase qty amount and then check summary price
    FOR   ${index}    ${seller_key}    IN ENUMERATE      @{product_detail}
        FOR   ${record_index}    ${products}    IN ENUMERATE      @{product_detail['${seller_key}']}
            ${index_order}    Evaluate    ${record_index}%2
            IF   "${index_order}"=="0"
                ${new_qty}  basket_feature.Tap decrease quantity from expected qty amount  ${products}   ${decrease_amount}
            ELSE
                ${new_qty}  basket_feature.Tap increase quantity from expected qty amount  ${products}   ${increase_amount}
            END
            Collections.Set to dictionary     ${products}    qty=${new_qty}
            basket_feature.Verify summary price from product detail and move to top    ${product_detail}
        END
    END

Decrease qty all products to left only one qty to verify trash icon
    [Arguments]         ${product_detail}   ${decrease_amount}=1
    FOR   ${index}    ${seller_key}    IN ENUMERATE      @{product_detail}
        FOR   ${record_index}    ${products}    IN ENUMERATE      @{product_detail['${seller_key}']}
            ${index_order}    Evaluate    ${record_index}%2
            IF   ${index_order}!=0
                ${new_qty}  basket_feature.Tap decrease quantity from expected qty amount  ${products}   ${decrease_amount}
                basket_page.Verify trash icon is display  ${products['productname']}
                Collections.Set to dictionary     ${products}    qty=${new_qty}
            END
            
        END
    END
    basket_feature.Verify summary price from product detail and move to top    ${product_detail}

Remove multiple products via swipe from basket
    [Arguments]    ${products_name}
    FOR    ${name}    IN    @{products_name}
        basket_page.Verify product name is display              ${name}
        basket_page.Swipe to delete product by product name     ${name}
        mobile_common.Swipe to the top of page       ${shortNumberScroll}
    END

Verify total point on home page were deducted after using point in basket
    [Arguments]        ${current_point}
    basket_feature.Verify point form display all fields correct before confirm  ${default['qty_basket']}
    basket_page.Tap confirm pay by point button
    basket_feature.Verify discount by point successfully      ${default['qty_basket']}
    ${new_point}            Evaluate    ${current_point}-1
    mobile_common.Tap shopping menu  accept_popup=${FALSE}
    home_page.Verify total point on home page is correct      ${new_point}

Verify total point on home page shows same like basket after delete point
    [Arguments]         ${current_point}    ${total_price}
    mobile_common.Tap basket menu
    basket_feature.Verify total price after discount and original price correct   ${total_price}  ${default['qty_basket']}
    basket_feature.Verify point form display all fields correct after confirm
    basket_page.Tap delete point button
    basket_page.Verify toast message delete point successfully
    basket_page.Verify total point on basket page is correct  ${current_point}
    
    mobile_common.Tap shopping menu  accept_popup=${FALSE}
    home_page.Verify total point on home page is correct      ${current_point}
    mobile_common.Tap basket menu
    basket_page.Tap expand makro point button

Verify quantity in basket after click increase or decrease button with product list
    [Arguments]     ${product_list}     ${increase_amount}=1      ${decrease_amount}=1
    FOR     ${product}    IN    @{product_list}
        basket_feature.Verify quantity in basket after click increase or decrease button  ${product}  ${increase_amount}  ${decrease_amount}
    END
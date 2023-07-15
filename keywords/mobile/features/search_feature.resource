*** Settings ***
Resource        ../pages/search_page.resource
Resource        ../pages/search_advance_page.resource
Resource        ../pages/productcard_page.resource
Resource        ../../api/search_typesense_api.resource

*** Keywords ***
Search product from searchbar
    [Arguments]    ${productname}
    search_page.Search for product with searchbar   ${productname}
    product_page.Find product on list    ${productname}

Search Keyword from searchbar
    [Arguments]    ${Keyword}
    search_page.Search for product with searchbar   ${Keyword}
    
Search product and go to PDP
    [Arguments]    ${productname}
    mobile_common.Tap shopping menu  accept_popup=False
    search_feature.Search product from searchbar     ${productname}
    product_page.Select product     ${productname}
    
Go to PLP of product
    [Arguments]     ${main_category}    ${sub_main_category}   ${product}   ${sub_category}=${empty}
    mobile_common.Tap shopping menu             accept_popup=${FALSE}
    product_page.Select main category    ${main_category}
    product_page.Select sub category     ${sub_main_category}
    IF  '${sub_category}' != '${empty}'
        product_page.Select sub category   ${sub_category}
    END
    product_page.Find product on list    ${product}

Go to PDP of product
    [Arguments]     ${main_category}    ${sub_category}     ${product}
    IF   "${platform}" == "${platform_list['android']}"
        Go to PLP of product    ${main_category}    ${sub_category}     ${product}
        product_page.Select product     ${product}
        ${txt_product_locator}    String.Replace string    ${search.txt_product}    {{product}}    ${product}
        AppiumLibrary.Wait Until Element Is Visible   ${txt_product_locator}  
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        Go to PLP of product    ${main_category}    ${sub_category}     ${product}
        product_page.Select product     ${product}
    END

Go to main category and should find product on list
    [Arguments]     ${main_category}    ${productname}
    mobile_common.Tap shopping menu  accept_popup=False
    product_page.Select main category    ${main_category}
    search_advance_page.Verify product display on product list   ${productname}  

Go to main category and should not find product on list
    [Arguments]     ${main_category}    ${productname}      ${empty_category}=${False}
    mobile_common.Tap shopping menu  accept_popup=False
    product_page.Select main category    ${main_category}
    search_advance_page.Verify product not display on product list   ${productname}     ${empty_category}

Go to sub category and should not find product on list
    [Arguments]     ${main_category}    ${sub_category}     ${productname}      ${empty_category}=${False}
    mobile_common.Tap shopping menu  accept_popup=False
    product_page.Select main category    ${main_category}
    product_page.Select sub category     ${sub_category}
    search_advance_page.Verify product not display on product list   ${productname}     ${empty_category}

Go to oz(3P) PDP
    IF   "${platform}" == "${platform_list['android']}"
        mobile_common.Tap shopping menu
        product_page.Select main category     ${mobile_additional['main_category']['kitchen utilities']}
        product_page.Select sub category     ${mobile_additional['sub_category']['one time use']}
        product_page.Select product     ${product_data['3P_3']}
        DobbyAppCommon.Wait until element is visible except stale   ${search.product_data_3P_3}
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        mobile_common.Tap shopping menu      accept_popup=False
        product_page.Select main category     ${mobile_additional['main_category']['kitchen utilities']}
        product_page.Select sub category      ${mobile_additional['sub_category']['one time use']}
        product_page.Select product           ${product_data['3P_3']}
    END

Add product to basket from search results
    [Arguments]    ${productname}
    mobile_common.Tap shopping menu  accept_popup=False
    search_feature.Search product from searchbar   ${productname}
    productcard_page.Click add to basket at product card   ${productname}
    productcard_page.Update basket    ${productname}

Search with keyword and select product
    [Arguments]    ${search phase}  ${productname}
    search_advance_page.Delete search from search bar
    search_feature.Search Keyword from searchbar    ${search phase}
    product_page.Select product    ${productname}

Search with synonym
    ${syn_result}   Run keyword and return status    search_feature.Search with keyword and select product    ${searching['synonym keyword']}     ${searching['synonym product']}
    mobile_common.Tap shopping menu  accept_popup=False
    [Return]     ${syn_result}

Search with mixed TH and EN keyword
    ${mixed_result}   Run keyword and return status    search_feature.Search with keyword and select product    ${searching['mixed_TH_EN_keyword']}     ${searching['mixed_TH_EN_product']}
    mobile_common.Tap shopping menu    accept_popup=False
    [Return]     ${mixed_result}

Search with mixed (TH+EN+special character) keyword
    ${special_result}  Run keyword and return status    search_feature.Search with keyword and select product    ${searching['mixed_TH_EN_special_keyword']}     ${searching['mixed_TH_EN_special_product']}
    mobile_common.Tap shopping menu  accept_popup=False
    [Return]     ${special_result}

Search results display in order when search keyword match more than one topic
    ${display_result}  Run keyword and return status    search_feature.Search with keyword and select product    ${searching['many topic keyword']}     ${searching['many topic product title']}
    mobile_common.Tap shopping menu  accept_popup=False
    ${display_result2}  Run keyword and return status    search_feature.Search with keyword and select product    ${searching['many topic keyword']}     ${searching['many topic product category']}
    mobile_common.Tap shopping menu  accept_popup=False
    ${results}   Evaluate    ${display_result} and ${display_result2}
    [Return]     ${results}

Search without filling anything (NULL) in search bar
    IF   "${platform}" == "${platform_list['android']}"
        search_page.Click to interact with searchbar
        mobile_common.Press enter on keyboard
        # banner_page.User location should be home page    #not ready
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        search_page.Click to interact with searchbar
        Sleep  2s   # wait for animation  
        ${is_success_en}=   Run keyword and return status   mobile_common.Press keyname        search
        ${is_success_th}=   Run keyword and return status   mobile_common.Press keyname        ค้นหา
        ${result}=          Evaluate    ${is_success_en} or ${is_success_th}
        Should be true      ${result}
        # banner_page.User location should be home page    #not ready
    END

Search with non-related keyword
    search_page.Click to interact with searchbar
    search_page.Search for product with searchbar   ${searching['non-related keyword']}
    search_page.Search page display searching not found       ${searching['non-related keyword']}

Click sort button and select sort by
    [Arguments]     ${sort}
    search_advance_page.Click sort button
    DobbyAppCommon.Wait until element is visible except stale   ${search_advance.txt_sort}    timeout=${very_short_timeout}
    Wait until keyword succeeds   2x  1s    search_advance_page.Click select sort by   ${sort}

Sort search result by
    [Arguments]     ${sort}    ${search_keyword}    ${expected_word}=${empty}
    search_feature.Search keyword from searchbar                ${search_keyword}
    search_feature.Click sort button and select sort by    ${sort}

    IF       '${sort}'=='${sort_type['relevant']}'              
        search_feature.Verify search result sort type relevant       ${expected_word}
    ELSE IF  '${sort}'=='${sort_type['newest']}'                
        Wait until keyword succeeds   2x  1s    search_feature.Verify search result sort type newest         ${search_keyword}  
    ELSE IF  '${sort}'=='${sort_type['price_low_to_high']}'
        Wait until keyword succeeds   2x  1s    search_feature.Verify search result by sort price    ${sort}   
    ELSE IF  '${sort}'=='${sort_type['price_high_to_low']}'     
        Wait until keyword succeeds   2x  1s    search_feature.Verify search result by sort price    ${sort}
    ELSE IF  '${sort}'=='${sort_type['promotion']}'             
        Wait until keyword succeeds   2x  1s    search_feature.Verify search result sort type promotion
    END
    mobile_common.Tap shopping menu  accept_popup=${FALSE}

Verify search result sort type relevant
    [Arguments]     ${expected_word}
    search_advance_page.Close sort modal by swipe down
    search_advance_page.Verify all product title contain expected result       ${expected_word}

Verify search result by sort price
    [Arguments]     ${sort}
    ${first_price}     DobbyAppCommon.Get text from element when ready         ${search.txt_list_item_price_1}
    ${first_price}     String.Remove string        ${first_price}      ,    ${SPACE}฿
    ${first_price}     Convert to number   ${first_price}
    WHILE    True
        ${second_price}    DobbyAppCommon.Get text from element when ready      ${search.txt_list_item_price_2}
        ${second_price}    String.Remove string        ${second_price}     ,    ${SPACE}฿
        ${second_price}    Convert to number   ${second_price}
        IF    ${first_price} == ${second_price}
            DobbyAppCommon.Swipe up
        ELSE
            IF   '${sort}'=='${sort_type['price_low_to_high']}'
                Should be true      ${first_price} < ${second_price}
            ELSE IF   '${sort}'=='${sort_type['price_high_to_low']}'
                Should be true      ${first_price} > ${second_price}
            END
            BREAK
        END
    END

Verify search result sort type newest
    [Arguments]         ${product_name}
    ${search_result}    search_typesense_api.Search and sort via typesense with keyword     ${product_name}    sortBy=${search engine['typesense']['search option']['sort_by_recently']}
    ${product_date}     search_typesense_api.Get publish at of search result from resp      ${search_result}
    ${product_title}    search_typesense_api.Get list product result from resp              ${search_result}
    search_advance_page.Verify product title contain expected result      ${1}           ${product_title}[0]
    search_advance_page.Verify product title contain expected result      ${2}           ${product_title}[1]

Verify search result sort type promotion
    [Documentation]   If first product is not promotion product, it will be search the secondary keyword then verify promotion product should be on top of search result
    ${promotion_product}   search_advance_page.Get promotion percent on search result page  ${1}
    IF  '${promotion_product}' == '${empty}'
        mobile_common.Tap shopping menu  accept_popup=${FALSE}
        search_feature.Search keyword from searchbar    ${searching['keyword_relate_lower']}    
        ${promotion_product}   search_advance_page.Get promotion percent on search result page  ${1}
    END
    Should be true      ${promotion_product}    msg=No promotion product on search result page

Filter search result
    [Arguments]     ${searching word}   ${type}     ${sub type}     ${sub_type2}=${false}
    search_feature.Search Keyword from searchbar    ${searching word}
    search_advance_page.Click filter button
    search_advance_page.Click select filter type    ${type}
    search_advance_page.Click select filter sub type    ${sub type}
    Run Keyword If      '${sub_type2}' != '${false}'    search_advance_page.Click select filter sub type    ${sub_type2}
    search_advance_page.Tap apply sub filter
    search_advance_page.Click show filter result button
    
Filter search result by price
    search_feature.Filter search result   ${searching['keyword_relate_lower']}   ${mobile['search']['label']['price']}     ${filter_sub_type['range_price_2']}
    search_advance_page.Verify product not display on product list       ${product_data['product1']['title']}

Filter search result by one category
    [Arguments]     ${count}=1
    Run keyword and return status    search_feature.Filter search result   ${searching['keyword_promotion']}   ${mobile_additional['filter_type']['category']}     ${mobile_additional['sub_category']['doggogogo']}
    search_advance_page.Filter count should be equal  ${count}
    search_advance_page.Verify product display on product list      ${searching['product_dog_discounted']}
    search_advance_page.Verify product not display on product list  ${product_data['1P']}
    
Filter search result by many category
    [Arguments]     ${count}=2
    Run keyword and return status    search_feature.Filter search result   ${searching['keyword_promotion']}   ${mobile_additional['filter_type']['category']}     ${mobile_additional['sub_category']['doggogogo']}      ${mobile_additional['sub_category']['dont_touch_automate']}
    search_advance_page.Filter count should be equal  ${count}
    search_advance_page.Click sort button
    search_advance_page.Click select sort by   shopify_qaenv_products_price_asc
    search_advance_page.Verify product display on product list      ${product_data['3P_11']}
    
Filter search result by available
    [Arguments]     ${count}=1
    search_feature.Filter search result   ${query['keyword_outofstock']}   ${mobile['search']['label']['inStockOnly']}     ${mobile['search']['label']['inStockOnly']}
    search_advance_page.Filter count should be equal  ${count}
    search_advance_page.Verify product not display on product list  ${product_data_os['product_out']}

Filter search result by one brand 
    search_feature.Filter search result   ${searching['keyword_cat_product']}     ${mobile['search']['label']['brand']}     ${mobile_additional['sub_category']['doggogogo']}
    search_advance_page.Verify product display on product list   ${product_data['product_dog']}
    search_advance_page.Verify product not display on product list  ${searching['keyword_cat_product']}

Filter search result by many brand 
    search_feature.Filter search result   ${searching['keyword_cat_product']}    ${mobile['search']['label']['brand']}     ${mobile_additional['sub_category']['doggogogo']}       ${filter_sub_type['brand_3']}
    search_advance_page.Verify product display on product list   ${product_data['product_dog']}
    search_advance_page.Verify product display on product list  ${searching['keyword_cat_product']}
    search_advance_page.Verify product not display on product list  ${product_data['product7']}

Filter search result by promotion
    search_feature.Filter search result   ${searching['keyword_fruit_product']}   ${mobile['search']['label']['promotion']}     ${filter_sub_type['discount']}
    search_advance_page.Verify product display on product list  ${product_data['fruit_product']}

Search product and should not find product
    [Arguments]    ${productname}   ${empty_category}=${False}
    IF   "${platform}" == "${platform_list['android']}"
        search_feature.Search product from searchbar    ${productname}
        search_advance_page.Verify product not display on product list    ${productname}    ${empty_category}
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        search_feature.Search Keyword from searchbar    ${productname}
        search_advance_page.Verify product not display on product list    ${productname}    ${empty_category}
    END

Search product and increase quantity
    [Arguments]    ${productname}    ${quantity}
    search_feature.Add product to basket from search results    ${productname}
    productcard_page.Increase quantity at product card    ${productname}    ${quantity}

# Android

Clear basket and add multi product to basket from search results
    [Arguments]    @{products_name}
    basket_page.Clear basket via debug menu   
    FOR    ${product}     IN      @{products_name}
    search_feature.Add product to basket from search results    ${product}
    END
    mobile_common.tap basket menu            #navigate to basket menu

Add multi product to basket from search results
    [Arguments]    @{products_name} 
    FOR    ${product}     IN      @{products_name}
    search_feature.Add product to basket from search results    ${product}
    END
    mobile_common.tap basket menu            #navigate to basket menu

# iOS
Add 1P+3P consignment product by search
    [Arguments]    ${1p_product}    ${3p_consignment_product}
    search_feature.Search product from searchbar                ${1p_product}
    product_page.Select product                                 ${1p_product}
    product_page.Click add to basket after select then back to shopping menu
    mobile_common.Tap shopping menu      accept_popup=False
    search_feature.Search product from searchbar                ${3p_consignment_product}
    product_page.Select product                                 ${3p_consignment_product}
    product_page.Click add to basket after select then back to shopping menu
    product_page.Select main category     ${mobile_additional['main_category']['dry food']}
    product_page.Select sub category      ${mobile_additional['sub_category']['spices']}
    product_page.Select product           ${product_data['3P_consignment']}

Click and clear filter
    [Arguments]     ${type_filter}
    Wait until keyword succeeds   2x  1s    search_advance_page.Click filter button
    ${is_filter_selected}    Run keyword and return status    DobbyAppCommon.Tap element when ready   ${search_advance.btn_claer}    timeout=${very_short_timeout}
    IF    ${is_filter_selected} == ${True}
        Wait until keyword succeeds   2x  1s    search_advance_page.Click filter button
    END
    search_advance_page.Click select filter type        ${type_filter}

Verify filter display on filter type
    [Arguments]   ${type_filter}    &{subtypes}
    ${subtypes_length}    Get length    ${subtypes}
    IF    ${subtypes_length} > ${1}
        search_advance_page.Verify number selected filter display on filter type   ${type_filter}   ${subtypes_length}
    ELSE
        search_advance_page.Verify selected filter display on filter type   ${type_filter}  ${subtypes['subtype_1']}
    END
    search_advance_page.Click show filter result button

Filter product all filter types
    [Arguments]     ${type_filter}    &{subtypes}
    search_feature.Click and clear filter    ${type_filter}
    FOR    ${key}    ${subtype}    IN    &{subtypes}
        search_advance_page.Click select filter sub type    ${subtype}
    END
    search_advance_page.Click back button on filter sub type
    search_feature.Verify filter display on filter type   ${type_filter}    &{subtypes}

Verify price after filter price
    ${price_range_list}    String.Split string    ${filter_sub_type['range_price_2']}
    ${minimum}    Convert to number    ${price_range_list[0]}
    ${maximum}    Convert to number    ${price_range_list[3]}

    @{price_list}    AppiumLibrary.Get webelements    ${search.txt_list_item_price}
    FOR    ${price}    IN    @{price_list}
        ${price}     DobbyAppCommon.Get text from element when ready    ${price}
        ${price}     String.Remove string        ${price}      ,    ${SPACE}฿
        ${price}     Convert to number   ${price}
        Should be true    ${price} >= ${minimum} and ${price} <= ${maximum}
    END

Verify product after filter category
    [Arguments]    ${expected_product}
    ${product_name}    DobbyAppCommon.Get text from element when ready    ${search_page.product_title}
    Should be equal    ${product_name}    ${expected_product}

Verify product after filter in stock only
    [Documentation]     this keyword is used to verify product after filter in stock only 
    ...                 it roughly check 3 times to make sure product is in stock
    FOR    ${counter}    IN RANGE    0    3
        ${out_of_stock}    Run keyword and return status    AppiumLibrary.Get webelements    ${productcard_page.btn_outofstock}
        Should be true    ${out_of_stock}==${False}
        DobbyAppCommon.Swipe up
    END

Verify product after filter brand
    [Arguments]     &{brands}
    FOR    ${key}    ${brand}    IN    &{brands}
        ${txt_brand_locator}    String.Replace string    ${product_page.txt_brand}    {{brand}}    ${brand}
        ${brand_is_display}    Run keyword and return status    AppiumLibrary.Get webelements    ${txt_brand_locator}
        Should be true    ${brand_is_display}==${True}
    END

Verify result after filter is correct
    [Arguments]     ${product_detail}       ${total_filter_selected}
    search_advance_page.Filter count should be equal    ${total_filter_selected}
    ${filter_result}    search_advance_page.Get total search found
    search_advance_page.Verify product display on product list         ${product_detail['product_name']}
    productcard_page.Verify product original price and discount at product card       ${product_detail['product_name']}      ${product_detail['original_price']}     ${product_detail['discounted_price']}
    product_page.Veriy product display product brand on product card   ${product_detail['product_name']}   ${product_detail['product_brand']}
    
    search_advance_page.Click filter button
    search_advance_page.Click clear all filter button
    ${clear_filter_result}      search_advance_page.Get total search found
    Should not be equal    ${filter_result}        ${clear_filter_result}

Verify target badge display on search suggestion and search result
    [Arguments]     ${badge_name}       ${product_name}
    mobile_common.Tap shopping menu  accept_popup=${FALSE}
    search_advance_page.Typing search      ${product_name}
    search_advance_page.Verify taget badge display on product in search page  ${badge_name}  ${product_name}
    search_advance_page.Click view all button
    search_advance_page.Verify taget badge display on product in search page  ${badge_name}  ${product_name}

Search product and verify search result
    [Arguments]    ${search_keyword}    ${expected_result}
    search_page.Search for product with searchbar    ${search_keyword}
    search_page.Verify product show on search result page    ${expected_result}
    
Search product and verify product out of delivery
    [Arguments]    ${search_keyword}    ${expected_result}
    search_page.Search for product with searchbar    ${search_keyword}
    product_page.Verify product out of delivery area        ${expected_result}
    
Get multiple product detail from search api with expected qty
    [Arguments]     ${product_payload_list}     ${target_qty_list}
    [Documentation]     output return dictionary item : {'product_1': {'title': 'ไอวี่ นมเปรี้ยว รสส้ม 180 มล.x 48 กล่อง', 'price': 350, 'qty': '0'},..}
    ...     This kw will check seach payload is same with another product or not.If it is same, it will auto query next index.
    &{product_detail}    Create Dictionary
    ${index}    Set variable    1
    ${temp_value}   Create list
    ${product_search_keyword}   Create list
    ${product_name_list}        Create list
    FOR     ${product}    IN    @{product_payload_list}
        Collections.Append to list      ${product_search_keyword}      ${product['q']}
        ${product_key}    Catenate    SEPARATOR=   product_    ${index}
        ${found_same_payload}   Run keyword and return status   Should contain   ${temp_value}   ${product}
        ${api_index}    Set variable    0
        IF    "${found_same_payload}"=="${True}"
            ${api_index}    Evaluate    ${api_index}+1
        ELSE
            Collections.Append to list      ${temp_value}       ${product}
        END
        ${productinfo_detail}   search_api_feature.Post search info dynamic data    ${product}  ${api_index}
        ${product_name}         mobile_common.Set product name from api data               ${productinfo_detail}
        Collections.Append to list      ${product_name_list}    ${product_name}
        ${qty_index}        Evaluate    ${index}-1
        ${product_dict}         Create dictionary    title=${product_name}          price=${productinfo_detail['display_price']}    qty=${target_qty_list}[${qty_index}]
        Collections.Set to dictionary       ${product_detail}    ${product_key}     ${product_dict}
        ${index}    Evaluate   ${index}+1
    END
    [Return]       ${product_detail}    ${product_name_list}    ${product_search_keyword}
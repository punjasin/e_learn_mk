*** Settings ***
Resource        ../../../resources/locators/${platform}/search_locator.resource
Resource        ../../../resources/locators/${platform}/common_locator.resource
Resource        ../../../common/mobile/mobile_common.resource

***Keywords***
Typing search
    [Arguments]    ${productname}
    search_page.Activate searchbar
    DobbyAppCommon.Input text to element when ready  ${search_advance.input_search}    ${productname}
    mobile_common.Wait until loading complete

Delete search from search bar
    search_page.Activate searchbar
    DobbyAppCommon.Clear text when ready  ${search_advance.input_search}

Search suggestion should display predict wording
    [Arguments]    @{words}
    FOR	${wording}	IN	@{words}
        ${txt_wording_locator}    String.Replace string    ${search_advance.txt_wording}    {{wording}}    ${wording}
        DobbyAppCommon.Wait until element is visible except stale   ${txt_wording_locator}
    END		

Search suggestion should display predict wording with category detail
    [Documentation]     set  ${wording2} for support data changes 
    [Arguments]    ${wording}  ${categoryname}  ${wording2}=${empty}
    IF   "${platform}" == "${platform_list['android']}"
        ${wording_locator}    String.Replace string    ${search_advance.txt_wording2_in}    {{wording}}    ${wording}
        ${txt_wording2_in_locator}    String.Replace string    ${wording_locator}    {{wording2}}    ${wording2}

        ${wording_locator_2}    String.Replace string    ${search_advance.txt_wording2_categoryname}    {{wording}}    ${wording}
        ${txt_wording2_in_locator_2}    String.Replace string    ${wording_locator_2}    {{wording2}}    ${wording2}
        ${txt_wording2_categoryname_locator_2}    String.Replace string    ${txt_wording2_in_locator_2}    {{categoryname}}    ${categoryname}
        DobbyAppCommon.Wait until element is visible except stale   ${txt_wording2_in_locator}
        DobbyAppCommon.Wait until element is visible except stale   ${txt_wording2_categoryname_locator_2}
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        ${wording_locator}    String.Replace string    ${search_advance.categoryname_product}    {{wording}}    ${wording}
        ${categoryname_product_locator}    String.Replace string    ${wording_locator}    {{product}}    ${product}
        DobbyAppCommon.Wait until element is visible except stale       ${categoryname_product_locator}
    END

Click predict wording 
    [Arguments]    ${wording}
    ${txt_wording_locator}    String.Replace string    ${search_advance.txt_wording}    {{wording}}    ${wording}
    DobbyAppCommon.Tap element when ready   ${txt_wording_locator}
    mobile_common.Wait until loading complete

Search suggestion should display product suggestion and search total 
    [Arguments]    ${searchtotal}
    ${searchtotal}      Convert to string          ${searchtotal}
    ${txt_searchtotal_locator}    String.Replace string    ${search_advance.txt_searchtotal}    {{searchtotal}}    ${searchtotal}
    DobbyAppCommon.Wait until element is visible except stale   ${txt_searchtotal_locator}
    DobbyAppCommon.Wait until element is visible except stale   ${search_advance.product_item_gid}

Click view all button
    DobbyAppCommon.Tap element when ready   ${search_advance.see_all}
    
Product suggestion display product
    [Arguments]    ${productname}
    IF   "${platform}" == "${platform_list['android']}"
        ${txt_productname_locator}    String.Replace string    ${search_advance.txt_productname}    {{productname}}    ${productname}
        DobbyAppCommon.Wait until element is visible except stale   ${txt_productname_locator}
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        ${list_item_title_productname_locator}    String.Replace string    ${search_advance.list_item_title_productname}    {{productname}}    ${productname}
        DobbyAppCommon.Wait until element is visible except stale   ${list_item_title_productname_locator}
    END

Click to view product detail on product suggestion
    [Arguments]    ${productname}
    IF   "${platform}" == "${platform_list['android']}"
        ${txt_productname_locator}    String.Replace string    ${search_advance.txt_productname}    {{productname}}    ${productname}
        DobbyAppCommon.Tap element when ready   ${txt_productname_locator}
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        ${product_item_gid_locator}    String.Replace string    ${search_advance.product_item_gid_}    {{productname}}    ${productname}
        DobbyAppCommon.Tap element when ready   ${product_item_gid__locator}
    END

Search total should be equal
    [Arguments]   ${searchtotal}
    ${searchtotal}      Convert to string   ${searchtotal}
    ${txt_searchtotal_list_locator}    String.Replace string    ${search_advance.txt_searchtotal_list}    {{searchtotal}}    ${searchtotal}
    DobbyAppCommon.Wait until element is visible except stale   ${txt_searchtotal_list_locator}
   
Click sort button
    DobbyAppCommon.Tap element when ready   ${search_page.sort_button}

Click filter button
    DobbyAppCommon.Tap element when ready   ${search_advance.search_filter_menu_button}    timeout=${very_short_timeout}
    DobbyAppCommon.Wait until element is visible except stale   ${search_advance.txt_filter_by}    timeout=${very_short_timeout}

Click select sort by
    [Arguments]     ${sorttype}
    ${sorttype_locator}    String.Replace string    ${search_advance.sorttype}    {{sorttype}}    ${sorttype}
    DobbyAppCommon.Wait until element is visible except stale    ${sorttype_locator}
    AppiumLibrary.Click element   ${sorttype_locator}

Click select filter type 
    [Arguments]     ${filtertype}
    ${filtertype_locator}    String.Replace string    ${search_advance.filtertype}    {{filtertype}}    ${filtertype}
    DobbyAppCommon.Tap element when ready   ${filtertype_locator}
    AppiumLibrary.Wait until page does not contain element       ${search_advance.txt_filter_by}

Click select filter sub type
    [Arguments]     ${filtersubtypes}
    ${filtertype_locator}    String.Replace string    ${search_advance.filtersubtype}    {{filtersubtype}}    ${filtersubtypes}
    DobbyAppCommon.Tap element when ready   ${filtertype_locator}

Tap apply sub filter
    DobbyAppCommon.Tap element when ready  ${search_advance.txt_apply}
    
Click back button on filter sub type
    search_advance_page.Tap apply sub filter
    search_advance_page.Click filter button
    DobbyAppCommon.Wait until element is visible except stale     ${search_advance.txt_filter_by}

Click show filter result button
    DobbyAppCommon.Tap element when ready   ${search_advance.show_result}

Close sort modal by swipe down
    ${1pos}         AppiumLibrary.Get element location    ${search_advance.show_result_back}
    AppiumLibrary.Swipe   ${1pos}[x]      ${1pos}[y]      ${1pos}[x]     1500   #swipe down
    AppiumLibrary.Wait until page does not contain element     ${search_advance.txt_sort}

Close filter modal by click back button
    IF   "${platform}" == "${platform_list['android']}"
        DobbyAppCommon.Tap element when ready   ${search_advance.filter_by_icon_button}
        AppiumLibrary.Wait until page does not contain element    ${search_advance.txt_filter_by}
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        DobbyAppCommon.Tap element when ready   ${search_advance.icon_button} 
        AppiumLibrary.Wait until page does not contain element    ${search_advance.txt_filter_by} 
    END

Verify selected filter display on filter type
    [Arguments]     ${type}   ${sub}
    ${type_locator}    String.Replace string    ${search_advance.txt_subtype}    {{type}}    ${type}
    ${txt_subtype_locator}    String.Replace string    ${type_locator}    {{sub}}    ${sub}
    DobbyAppCommon.Wait until element is visible except stale     ${txt_subtype_locator}
    
Verify number selected filter display on filter type
    [Arguments]     ${type}   ${number}
    ${type_locator}    String.Replace string    ${search_advance.txt_subnumber}    {{type}}    ${type}
    ${number}       Convert to string   ${number}
    ${txt_subnumber_locator}    String.Replace string    ${type_locator}    {{number}}    ${number}
    DobbyAppCommon.Wait until element is visible except stale     ${txt_subnumber_locator}

Click clear all filter button
    DobbyAppCommon.Tap element when ready   ${search_advance.btn_claer}     

Verify number of product on filter brand
    [Arguments]     ${brandname}   ${number}
    ${brandname_locator}    String.Replace string    ${search_advance.txt_brandname_number}    {{brandname}}    ${brandname}
    ${txt_brandname_number_locator}    String.Replace string    ${brandname_locator}    {{number}}    ${number}
    DobbyAppCommon.Wait until element is visible except stale     ${txt_brandname_number_locator}

Filter count should be equal
    [Arguments]     ${number}
    ${number}       Convert to string           ${number}
    ${list_number_locator}    String.Replace string    ${search_advance.list_number}    {{number}}    ${number}
    DobbyAppCommon.Wait until element is visible except stale   ${list_number_locator}

Get total search found
    ${total_found}     DobbyAppCommon.Get text from element when ready     ${search_page.txt_total_found}
    ${total_found}     String.Remove string        ${total_found}          ${SPACE}${search_additional['label']['list']}
    [Return]           ${total_found}
    
Verify product that related searching display in search result
    [Arguments]     ${word}     ${sensitivecase}
    ${word_locator}    String.Replace string    ${search_advance.sensitivecase}    {{word}}    ${word}
    ${sensitivecase_locator}    String.Replace string    ${word_locator}    {{sensitivecase}}    ${sensitivecase}
    DobbyAppCommon.Wait until element is visible except stale   ${sensitivecase_locator}

Verify all product title contain expected result
    [Arguments]         ${expected_data}
    [Documentation]     Check only first 4 products has title relate to searching keywords
    ${title_list}       AppiumLibrary.Get web elements      ${search_page.product_title}
    FOR    ${index}              IN RANGE              1            4
            search_advance_page.Verify product title contain expected result      ${index}      ${expected_data}
    END
    
Verify product title contain expected result
    [Arguments]     ${index}     ${expected_data}
    ${title_name_with_index}     Catenate    SEPARATOR=    xpath=(${search_page.product_title_2})    [${index}]
    ${title_name}     DobbyAppCommon.Get text from element when ready       ${title_name_with_index}
    Should contain      ${title_name}       ${expected_data}

Get promotion percent on search result page
    [Arguments]     ${index}
    TRY
        ${promotion_locator}    String.Format string      ${search_page.txt_percent_promo}    index=${index}
        ${promotion_percent}    DobbyAppCommon.Get text from element when ready   ${promotion_locator}    timeout=${very_short_timeout}
        ${promotion_percent}    String.Remove string      ${promotion_percent}      -    %
    EXCEPT
        ${promotion_percent}    Set variable    ${empty}
    END
    [Return]    ${promotion_percent}

Product position on search result should be
    [Documentation]     set ${position_error} position for error endroid emulator case   
    [Arguments]     ${productname}     ${position}     ${position_error}=${empty}
    ${position}           Convert to string       ${position}
    ${position_error}     Convert to string       ${position_error}
    ${position_locator}    String.Replace string          ${search_advance.position}    {{position}}    ${position}
    ${position_error_locator}    String.Replace string    ${search_advance.position_error}    {{position_error}}    ${position_error}
    
    IF   "${platform}" == "${platform_list['android']}"
        ${valid_position}=    Run keyword and return status  Element Attribute Should Match  ${position_locator}     text    ${productname} 
        Run keyword if  '${valid_position}'=='${false}'     Element Attribute Should Match  ${position_error_locator}     text    ${productname}
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        DobbyAppCommon.Wait until element is visible except stale  ${search_advance.product_item_gid}
        ${valid_position}=    Run keyword and return status     Element Attribute Should Match  ${position_locator}     label    ${productname} 
        Run keyword if  '${valid_position}'=='${false}'     Element Attribute Should Match  ${position_error_locator}     label    ${productname}
    END

Verify product not display on product list 
    [Arguments]     ${productname}      ${empty_category}=${False}
    IF   "${platform}" == "${platform_list['android']}"
        Run keyword if      '${empty_category}'=='False'     product_page.Find product on list        ${productname}     5
        Run keyword if      '${empty_category}'=='True'     product_page.Verify product item count on sub category page display 0 item
        ${txt_productname_locator}    String.Replace string    ${search_advance.txt_productname}    {{productname}}    ${productname}
        AppiumLibrary.Page should not contain element        ${txt_productname_locator}
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        Run keyword if      '${empty_category}'=='False'     product_page.Find product on list        ${productname}     5
        Run keyword if      '${empty_category}'=='True'     product_page.Verify product item count on sub category page display 0 item
        ${productname_locator}    String.Replace string    ${search_advance.productname}    {{productname}}    ${productname}
        AppiumLibrary.Page should not contain element        ${productname_locator}
    END

Verify product display on product list
    [Arguments]     ${productname}
    ${txt_productname_locator}    String.Replace string    ${search_advance.txt_productname}    {{productname}}    ${productname}
    product_page.Find product on list        ${productname}
    Page Should Contain Element        ${txt_productname_locator}

Verify product out of at search suggestion
    [Arguments]     ${product}
    ${disable_icon_button_locator}    String.Replace string    ${search_advance.disable_icon_button}    {{productname}}    ${productname}
    DobbyAppCommon.Wait until element is visible except stale      ${disable_icon_button_locator}
    
Click add to basket at search suggestion
    [Arguments]     ${productname}
    IF   "${platform}" == "${platform_list['android']}"
        ${productname_icon_button_locator}    String.Replace string    ${search_advance.productname_icon_button}    {{productname}}    ${productname}
        DobbyAppCommon.Tap element when ready    ${productname_icon_button_locator}
        mobile_common.Wait until loading complete
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        ${enable_icon_button_locator}    String.Replace string    ${search_advance.enable_icon_button}    {{productname}}    ${productname}
        DobbyAppCommon.Tap element when ready    ${enable_icon_button_locator}
        mobile_common.Wait until loading complete
    END

# Android

Verify product appear in search results
    [Arguments]     ${product}
    ${txt_product_locator}    String.Replace string    ${search.txt_product}    {{product}}    ${product}
    DobbyAppCommon.Wait until element is visible except stale      ${txt_product_locator}

# iOS

Verify quantity at search suggestion
    [Arguments]     ${productname}      ${qty}
    ${productname_locator}    String.Replace string    ${search_advance.qty_input_quantity}    {{productname}}    ${productname}
    ${qty_input_quantity_locator}    String.Replace string    ${productname_locator}    {{qty}}    ${qty}
    ${qty_input_locator}    String.Replace string    ${search_advance.qty_input}    {{productname}}    ${productname}
    DobbyAppCommon.Wait until element is visible except stale   ${qty_input_quantity_locator}
    Element Attribute Should Match      ${qty_input_locator}    value    ${qty}

Increase quantity at search suggestion
    [Arguments]    ${productname}   ${number}=1
    ${increment_btn_wrapper_locator}    String.Replace string    ${search_advance.increment_btn_wrapper}    {{productname}}    ${productname}
    FOR     ${round}    IN RANGE    ${number}   
        DobbyAppCommon.Tap element when ready    ${increment_btn_wrapper_locator}
        mobile_common.Wait until loading complete
    END

Decrease quantity at search suggestion
    [Arguments]    ${productname}   ${number}=1
    ${decrement_btn_wrapper_locator}    String.Replace string    ${search_advance.decrement_btn_wrapper}    {{productname}}    ${productname}
    FOR     ${round}    IN RANGE    ${number}   
        DobbyAppCommon.Tap element when ready    ${decrement_btn_wrapper_locator}
        mobile_common.Wait until loading complete
    END    

Click trash icon at search suggestion
    [Arguments]    ${productname}
    ${decrement_btn_wrapper_locator}    String.Replace string    ${search_advance.decrement_btn_wrapper}    {{productname}}    ${productname}
    DobbyAppCommon.Tap element when ready   ${decrement_btn_wrapper_locator}
    mobile_common.wait until loading complete

Verify taget badge display on product in search page
    [Arguments]     ${badge_name}   ${product_name}
    [Documentation]  This keyword use with search suggestion and search result page
    ${badge_locator}     String.Replace string      ${search_advance.txt_badge_product}   {{badge_name}}    ${badge_name}
    ${product_with_badge_locator}   String.Replace string       ${badge_locator}   {{product_name}}   ${product_name}
    DobbyAppCommon.Wait until element is visible except stale   ${product_with_badge_locator}
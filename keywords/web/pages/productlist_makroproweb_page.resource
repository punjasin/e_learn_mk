*** Settings ***
Resource            ../../../resources/locators/web/productlist_makroproweb_locator.resource
Resource            ../../../common/web/web_common.resource

*** Keywords ***
Verify product header display
    [Arguments]     ${product_name}
    ${header_locator}       String.Replace string       ${productlist_makroproweb.txt_product_header_name}      {{product_name}}     ${product_name}
    DobbyWebCommon.Wait until element is visible except stale       ${header_locator}

Verify product list title display
    DobbyWebCommon.Wait until element is visible except stale       ${productlist_makroproweb.txt_productlist_header}
    DobbyWebCommon.Wait until element is visible except stale       ${productlist_makroproweb.txt_showing_product}

Click sort by button
    DobbyWebCommon.Click element when ready                         ${productlist_makroproweb.btn_sortby}

Click target sort name
    [Arguments]     ${sort_by_name}
    ${sort_by_name_locator}         String.Replace string       ${productlist_makroproweb.btn_sort_name}    {{sort_by_name}}    ${sort_by_name}
    DobbyWebCommon.Click element when ready                     ${sort_by_name_locator}
    web_common.Wait for page load

Verify sort by price low to high correct
    ${prices_list}       DobbyWebCommon.Get webelements when ready      ${productlist_makroproweb.txt_all_prices}
    ${last_index}        Get length       ${prices_list}
    ${xpath_price}            String.Remove string      ${productlist_makroproweb.txt_all_prices}      xpath=
    ${first_product_price}    Catenate    SEPARATOR=    (${xpath_price})     [1]
    ${last_product_price}     Catenate    SEPARATOR=    (${xpath_price})     [${last_index}]
    ${first_price}      web_common.Get price without currency   ${first_product_price}
    ${last_price}       web_common.Get price without currency   ${last_product_price}
    Should be true      ${first_price}<=${last_price}
    [Return]            ${first_price}      ${last_price}

Click clear filter button
    DobbyWebCommon.Scroll to top of page using java script
    DobbyWebCommon.Click element when ready                       ${productlist_makroproweb.btn_clear_all_filter}

Click filter by discount product
    DobbyWebCommon.Scroll element into view when ready            ${productlist_makroproweb.btn_discount_product}
    SeleniumLibrary.Click element                                 ${productlist_makroproweb.btn_discount_product}

Click filter by product brand
    [Arguments]     ${brand_name}
    ${filter_brand_locator}     String.Replace string       ${productlist_makroproweb.btn_filter_by_brand}      {{brand_name}}     ${brand_name}
    DobbyWebCommon.Scroll element into view when ready      ${filter_brand_locator}
    SeleniumLibrary.Click element                           ${filter_brand_locator}

Click filter by have stock
    DobbyWebCommon.Scroll element into view when ready      ${productlist_makroproweb.btn_filter_have_stock}
    SeleniumLibrary.Click element                  ${productlist_makroproweb.btn_filter_have_stock}
    web_common.Wait for page load

Verify all page show only discount products
    DobbyWebCommon.Scroll to top of page using java script
    ${total_product}     productlist_makroproweb_page.Get total of product in fisrt page
    FOR    ${index}              IN RANGE              1             ${total_product}
        ${product_xpath}          String.Remove string      ${productlist_makroproweb.txt_all_product_percent}       xpath=
        ${product_with_index}     Catenate    SEPARATOR=    (${product_xpath})     [${index}]
        DobbyWebCommon.Scroll element into view when ready      ${product_with_index}
        SeleniumLibrary.Element should be visible        ${product_with_index}
    END

Click expand filter type
    [Arguments]     ${filter_type}
    ${expand_locator}       String.Replace string       ${productlist_makroproweb.btn_expand_icon}      {{filter_type}}     ${filter_type}
    DobbyWebCommon.Scroll element into view when ready      ${expand_locator}
    DobbyWebCommon.Click element when ready                 ${expand_locator}

Verify all page show only target brand
    [Arguments]     ${brand_name}
    DobbyWebCommon.Scroll to top of page using java script
    ${total_product}     productlist_makroproweb_page.Get total of product in fisrt page
    FOR    ${index}              IN RANGE              1             ${total_product}
        ${product_xpath}            String.Remove string      ${productlist_makroproweb.txt_all_product_brand}       xpath=
        ${product_with_index}       Catenate    SEPARATOR=    (${product_xpath})     [${index}]
        ${product_brand_locator}    String.Replace string     ${product_with_index}     {{brand_name}}      ${brand_name}
        DobbyWebCommon.Scroll element into view when ready      ${product_brand_locator}
        SeleniumLibrary.Element should be visible        ${product_brand_locator}
    END

Verify all page not have out of stock product
    SeleniumLibrary.Wait until element is not visible               ${productlist_makroproweb.btn_first_out_of_product}         timeout=${longTimeout}
    DobbyWebCommon.Wait until element is visible except stale       ${productlist_makroproweb.btn_first_product_add_basket}

Get total of product in fisrt page
    ${all_product_list}     DobbyWebCommon.Get text from element when ready     ${productlist_makroproweb.txt_showing_product}
    ${total_first_page}     String.Get regexp matches   ${all_product_list}     (?<=\\-)\\d{1,3}
    ${total_first_page}     Set variable    ${total_first_page[0]}
    [Return]                ${total_first_page}

Click on product name
    [Arguments]     ${product_name}
    ${product_name_locator}     String.Replace string       ${productlist_makroproweb.txt_product_name}     {{product_name}}    ${product_name}
    DobbyWebCommon.Click element when ready                 ${product_name_locator}

Get current qty
    [Arguments]     ${product_name}
    ${qty_locator}     String.Replace string       ${productlist_makroproweb.txt_product_qty}     {{product_name}}    ${product_name}
    ${qty_amount}      DobbyWebCommon.Get text from element when ready     ${qty_locator}
    [Return]        ${qty_amount}

Verify delivery within 24hr product banner display
    [Arguments]    ${product_name}
    ${banner_product_locator}        String.Replace string     ${productlist_makroproweb.txt_delivery_1P_banner}    {{product_name}}    ${product_name}
    DobbyWebCommon.Wait until element is visible except stale       ${banner_product_locator}

Click plus icon add product
    [Arguments]    ${product_name}
    ${btn_add_basket_each_product_locator}   String.Replace string       ${productlist_makroproweb.btn_add_basket_each_product}   {{product_name}}   ${product_name}
    DobbyWebCommon.Click element when ready     ${btn_add_basket_each_product_locator}

Click add qty popup with expected qty
    [Arguments]    ${product_name}     ${expected_amount}
    [Documentation]     Click btn until reach to expected value
    ${btn_locator}      String.Replace string       ${productlist_makroproweb.btn_add_qty_popup}     {{product_name}}    ${product_name}
    FOR     ${round}    IN RANGE  1  ${${expected_amount}}
       DobbyWebCommon.Click element when ready         ${btn_locator}
       web_common.Wait for page load
    END
    productlist_makroproweb_page.Verify qty should be equal to expected    ${product_name}   ${expected_amount}
Verify qty should be equal to expected
    [Arguments]    ${product_name}    ${expected_qty}
    ${qty_locator}   String.Replace string     ${productlist_makroproweb.input_basket_item}    {{product_name}}    ${product_name}
    ${actual_qty}    DobbyWebCommon.Get value from element when ready    ${qty_locator}
    ${actual_qty}    Convert To Integer    ${actual_qty}
    Should Be Equal As Strings   ${actual_qty}    ${expected_qty}

Click add to basket popup
    DobbyWebCommon.Click element when ready    ${productlist_makroproweb.btn_add_to_basket_popup}
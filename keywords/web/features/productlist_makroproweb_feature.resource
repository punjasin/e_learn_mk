*** Settings ***
Resource            ../pages/productlist_makroproweb_page.resource

*** Keywords ***
Select sort by
    [Arguments]     ${sort_by_name}
    productlist_makroproweb_page.Click sort by button
    productlist_makroproweb_page.Click target sort name     ${sort_by_name}

Verify products are filtered by brand 
    [Arguments]     ${brand_name}
    productlist_makroproweb_page.Click clear filter button
    productlist_makroproweb_page.Click expand filter type                ${web['Brands']}
    productlist_makroproweb_page.Click filter by product brand           ${brand_name}
    Wait until keyword succeeds  3x   2s    productlist_makroproweb_page.Verify all page show only target brand  ${brand_name}

Verify only avilable products are filtered
    DobbyWebCommon.Scroll to top of page using java script
    productlist_makroproweb_page.Click filter by have stock
    productlist_makroproweb_page.Verify all page not have out of stock product

Verify products filtered by discount products
    productlist_makroproweb_page.Click clear filter button
    productlist_makroproweb_page.Click filter by discount product
    Wait until keyword succeeds  3x   2s    productlist_makroproweb_page.Verify all page show only discount products

Verify products are filtered by price range correctly
    ${prices_list}       SeleniumLibrary.Get webelements      ${productlist_makroproweb.btn_filter_all_prices}
    ${total_filter}      Get length       ${prices_list}
    FOR    ${index}              IN RANGE              1             ${total_filter}+1
        ${xpath_filter}          String.Remove string      ${productlist_makroproweb.btn_filter_all_prices}       xpath=
        ${filter_with_index}     Catenate    SEPARATOR=    (${xpath_filter})     [${index}]
        SeleniumLibrary.Click element        ${filter_with_index}
        ${name_attribute}    SeleniumLibrary.Get element attribute     ${filter_with_index}    name
        ${range_price}       String.Split string           ${name_attribute}     ${SPACE}TO${SPACE}
        ${min_price}         Set variable    ${range_price[0]}
        ${max_price}         Set variable    ${range_price[1]}
        productlist_makroproweb_feature.Select sort by         ${web['search']['priceLowToHigh']}
        ${not_found_filter}     Run keyword and return status      DobbyWebCommon.Wait until element is visible except stale     ${productlist_makroproweb.btn_no_filter_product}
        IF   "${not_found_filter}"=="${False}"
            ${min_sort}     ${max_sort}     productlist_makroproweb_page.Verify sort by price low to high correct
            Should be true       ${min_sort}>=${min_price}
            Should be true       ${max_price}>=${max_sort}
        END
    END

Add product with qty after searching
    [Arguments]        ${product_name}    ${expected_qty}=1
    SeleniumLibrary.Press keys      none      ENTER
    search_makroproweb_page.Verify search result display search keyword correct    ${product_name}
    productlist_makroproweb_page.Click plus icon add product             ${product_name}
    productlist_makroproweb_page.Click add qty popup with expected qty   ${product_name}     ${expected_qty}
    productlist_makroproweb_page.Click add to basket popup
    web_common.Wait until toast message dissapear
    ${current_qty}    productlist_makroproweb_page.Get current qty    ${product_name}
    [Return]          ${current_qty}
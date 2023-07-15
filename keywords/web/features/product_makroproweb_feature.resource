*** Settings ***
Resource            search_makroproweb_feature.resource
Resource            ../pages/search_makroproweb_page.resource
Resource            ../pages/productlist_makroproweb_page.resource
Resource            ../pages/product_makroproweb_page.resource
Resource            ../pages/basket_makroproweb_page.resource
Resource            ../pages/home_makroproweb_page.resource

*** Keywords ***
Navigate to product page after searching
    [Arguments]     ${product_payload_api}
    ${product_detail}    search_makroproweb_feature.Search with dynamic data   ${product_payload_api}
    SeleniumLibrary.Press keys      none      ENTER
    search_makroproweb_page.Verify search result display search keyword correct  ${product_detail['productname']}
    productlist_makroproweb_page.Click on product name          ${product_detail['productname']}
    productlist_makroproweb_page.Verify product header display  ${product_detail['productname']}
    [Return]        ${product_detail['productname']}

Verify every pages show same qty as product page
    [Arguments]     ${product_name}
    [Documentation]     Get qty from product detail page to compare value with basket, search result and product list page
    ${product_qty}  product_makroproweb_page.Get current qty
    home_makroproweb_page.Click cart icon
    basket_makroproweb_page.Verify qty amount display as expected value    ${product_name}      ${product_qty}
    basket_makroproweb_page.Close basket
    web_common.Wait until toast message dissapear
    search_makroproweb_page.Input search keyword        ${product_name}
    SeleniumLibrary.Press keys      none      ENTER
    ${product_list_qty}      productlist_makroproweb_page.Get current qty        ${product_name}
    Should be equal          ${product_list_qty}        ${product_qty}
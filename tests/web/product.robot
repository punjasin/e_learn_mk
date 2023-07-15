*** Settings ***
Resource            ../../common/api/api_common.resource
Resource            ../../common/web/web_common.resource

Test Setup          web_common.Makro pro web setup
Test Teardown       web_common.Close browser

*** Test Cases ***
Add product to basket and adjust product quantity : PDP _ MAKNET-3794
    [Tags]      MAKNET-3794     web     priority_high
    [Documentation]     Verify user can adjust quantity of product in product page and the qty show the correct number on every page
    ${product_name}     product_makroproweb_feature.Navigate to product page after searching  ${search_api['payload']['search_api_payload1']}
    product_makroproweb_page.Click add to basket button         ${product_name}
    product_makroproweb_page.Verify qty has been changed after clicked increase      ${MAKNET_3794_data['add_amount']}
    product_makroproweb_page.Verify qty has been changed after clicked decrease
    product_makroproweb_feature.Verify every pages show same qty as product page     ${product_name}

Out of stock indication : PDP _ MAKNET-3800
    [Tags]      MAKNET-3800     web
    [Documentation]     Verify user can't add out of stock product to basket
    search_makroproweb_feature.Search product and navigate to product detail page   ${list_product['Doppio-tech']['3P_25']}
    product_makroproweb_page.Verify out of stock button is display  ${list_product['Doppio-tech']['3P_25']}

Verify "Next Day Delivery" for 1P product _ MAKNET-3802
    [Tags]    MAKNET-3802     web
    [Documentation]    Verify all page show "Delivery within 24 hr" banner or description for product 1P
    home_makroproweb_page.Verify delivery within 24hr product banner display    ${web_additional['homeCategory']['lastPromotion']}    ${product_data['0408_product']}
    search_makroproweb_feature.Search product and navigate to product list page   ${product_data['0408_product']}
    productlist_makroproweb_page.Verify delivery within 24hr product banner display    ${product_data['0408_product']}
    productlist_makroproweb_page.Click on product name                                 ${product_data['0408_product']}
    product_makroproweb_page.Verify delivery description product 1P display correct    ${product_data['0408_product']}
*** Settings ***
Resource            ../../common/api/api_common.resource
Resource            ../../common/web/web_common.resource

Test Setup          web_common.Makro pro web setup
Test Teardown       web_common.Close browser

*** Test Cases ***
Adjust quantity +/- and remove _ MAKNET-3875
    [Tags]    MAKNET-3875     web   priority_high
    [Documentation]     Verify user can adjust quantity of product in basket by click +/- ,adjust number to be 0 and click bin icon
    ${product_detail}    search_makroproweb_feature.Search with dynamic data   ${search_api['payload']['search_api_payload1']}
    productlist_makroproweb_feature.Add product with qty after searching       ${product_detail['productname']}
    home_makroproweb_feature.Verify item in cart when click add to basket      ${product_detail['productname']}   ${default['qty_basket']}
    basket_makroproweb_page.Verify basket has been changed after quantity added       ${product_detail['productname']}
    basket_makroproweb_page.Verify basket has been changed after quantity decreased   ${product_detail['productname']}
    basket_makroproweb_feature.Adjust number directly to zero and verify no items in basket     ${product_detail['productname']}

    search_makroproweb_page.Input search keyword    ${product_detail['productname']}
    productlist_makroproweb_feature.Add product with qty after searching      ${product_detail['productname']}
    home_makroproweb_feature.Verify item in cart when click add to basket     ${product_detail['productname']}   ${default['qty_basket']}
    basket_makroproweb_feature.Verify no items in basket when click bin icon  ${product_detail['productname']}
*** Settings ***
Resource            ../pages/basket_makroproweb_page.resource

*** Keywords ***
Adjust number directly to zero and verify no items in basket
    [Arguments]     ${product_name}
    basket_makroproweb_page.Adjust input value to zero directly     ${product_name}
    basket_makroproweb_page.Verify no items in basket
    basket_makroproweb_page.Close basket

Verify no items in basket when click bin icon
    [Arguments]     ${product_name}
    basket_makroproweb_page.Click bin icon                          ${product_name}
    basket_makroproweb_page.Verify no items in basket
    basket_makroproweb_page.Close basket

Click cart and verify vendor of product 
    [Arguments]     ${1p_vendor_name}    ${3p_vendor_name}
    home_makroproweb_page.Click cart icon
    basket_makroproweb_page.Verify basket header
    ${total_price}    basket_makroproweb_page.Get total price
    basket_makroproweb_page.Verify vendor name with 1p    ${1p_vendor_name} 
    basket_makroproweb_page.Verify vendor name with 3p    ${3p_vendor_name}
    ${total_product}    basket_makroproweb_page.Get total products by bin icon
    basket_makroproweb_page.Click make payment button
    [Return]     ${total_price}    ${total_product}
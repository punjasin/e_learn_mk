*** Settings ***
Resource        ../pages/promotion_page.resource
Resource        ../pages/product_page.resource

*** Keywords ***
Tap product and verify the product not sold by makro
    [Arguments]      ${total_promotions}=3
    FOR     ${i}    IN RANGE    1   ${total_promotions}
        ${sequent}=  Convert to string   ${i}
        promotion_page.Tap product in last promotion by sequent     ${sequent}
        product_page.Verify the product not sold by makro
        product_page.Tap back at product detail page
    END

Verify store on last promotion is selected via subdistrict
    [Documentation]    Select zipcode and subdistrict for verify products on last promotion section change follow zipcode store
    [Arguments]     ${zipcode}        ${subdistrict}        ${productname_1}        ${productname_2}
    home_page.Tap zip code selector
    homepage_feature.Enter zip code and save        ${zipcode}      ${subdistrict}
    promotion_page.Click see all button
    promotion_page.Verify product should be display on last promotion       ${productname_1}
    promotion_page.Verify product should be display on last promotion       ${productname_2}
    mobile_common.Toast message should display and close    ${homepage.toast_success}
    mobile_common.Go back to main page
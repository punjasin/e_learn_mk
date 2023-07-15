*** Settings ***
Resource            ../../common/api/api_common.resource
Resource            ../../common/web/web_common.resource
Resource            ../../keywords/api/basket_api.resource

Test Setup          web_common.Makro pro web setup
Test Teardown       web_common.Close browser

*** Test Cases ***
Verify that payment failed when pay with invalid credit card/debit card _ MAKNET-2854
    [Tags]    MAKNET-2854     web   priority_low
    [Documentation]    Verify payment unsuccessful when pay with invalid credit card
    login_makroproweb_feature.Login with email and password    ${login_web['user1']['email']}   ${login_web['user1']['password']}
    basket_api.Login and delete basket via API     ${login_web['user1']['email']}   ${login_web['user1']['password']}
    ${product_detail}    search_makroproweb_feature.Search with dynamic data   ${search_api['payload']['search_api_payload1']}
    productlist_makroproweb_feature.Add product with qty after searching       ${product_detail['productname']}
    home_makroproweb_feature.Verify item in cart when click add to basket      ${product_detail['productname']}   ${default['qty_basket']}
    basket_makroproweb_page.Verify basket has been changed after quantity added        ${product_detail['productname']}    ${MAKNET_2854_data['add_amount']}
    ${total_price}    basket_makroproweb_page.Get total price
    basket_makroproweb_page.Click make payment button
    checkout_makroproweb_feature.Verify total price and go to payment    ${total_price}
    payment_makroproweb_feature.Select payment channel      ${web_additional['payment']['creditDebit']}
    payment_makroproweb_feature.Input credit/debit detail   ${MAKNET_2854_data}    ${total_price}
    payment_makroproweb_feature.Verify payment unsuccessful
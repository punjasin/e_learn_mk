*** Settings ***
Resource            ../../keywords/api/basket_api.resource
Resource            ../../keywords/api/login_api.resource
Resource            ../../keywords/web/pages/orderhistory_makroproweb_page.resource
Resource            ../../common/api/api_common.resource
Resource            ../../common/web/web_common.resource

Test Setup          web_common.Makro pro web setup
Test Teardown       web_common.Close browser

*** Test Cases ***
User can change the delivery slot on checkout page[Only order 1P change] _ MAKNET-3987
    [Tags]      MAKNET-3987     web     priority_high
    [Documentation]    Verify delivery slot change only product 1P and verify delivery info in order delivery history
    basket_api.Login and delete basket via API       ${user['userforTestpoint1']['email']}      ${user['userforFavourite_scenario']['password']}
    login_makroproweb_feature.Login with email and password    ${user['userforTestpoint1']['email']}      ${user['userforFavourite_scenario']['password']}
    
    ${product_list_1p}    search_makroproweb_feature.Search with dynamic data   ${search_api['payload']['search_api_product_1P']}
    ${1P_qty}    productlist_makroproweb_feature.Add product with qty after searching   ${product_list_1p['productname']}    ${amount_quantity['adjust_amount']}
    ${product_list_3p}    search_makroproweb_feature.Search with dynamic data   ${search_api['payload']['search_api_payload_3P']}    index=2
    ${3P_qty}    productlist_makroproweb_feature.Add product with qty after searching   ${product_list_3p['productname']}    ${shortNumberScroll}
    
    ${total_price}    ${total_product}    basket_makroproweb_feature.Click cart and verify vendor of product    ${product_list_1p['seller']}    ${product_list_3p['seller']} 
    ${delivery_date_1P}     ${delivery_date_3P}    checkout_makroproweb_feature.Verify different delivery date and time slot from vendor   ${product_list_1p['seller']}    ${product_list_3p['seller']}
    checkout_makroproweb_feature.Verify total price and go to payment           ${total_price}
    payment_makroproweb_feature.Process to payment by credit card successful    ${payment['creditcard_cc_2']}    ${total_price}
    checkout_makroproweb_page.Click view my order button
    ${order_detail}       Create dictionary    delivery_product_1=${delivery_date_1P}    delivery_product_2=${delivery_date_3P}
    ...    seller_product_1=${product_list_1p['seller']}    seller_product_2=${product_list_3p['seller']}
    ...    product_name_1=${product_list_1p['productname']}    product_name_2=${product_list_3p['productname']}
    ...    qty_product_1=${1P_qty}    qty_product_2=${3P_qty}    total_product=${total_product}
    ...    payment_method=${web_additional['orderhistory']['paymentCredit']}    payment_status=${web_additional['orderhistory']['paymentSuccess']}
    ...    order_status=${web['label']['being_prepared']}
    orderhistory_detail_makroproweb_feature.Verify delivery information correct    ${order_detail}
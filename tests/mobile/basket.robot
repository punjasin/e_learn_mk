*** Settings ***
Force Tags       basket    regression
Resource        ../../common/mobile/mobile_common.resource
Resource        ../../common/api/api_common.resource

Suite Setup         mobile_common.Mango Suite Setup
Test Setup          mobile_common.Mango Test Setup
Test Teardown       mobile_common.Mango Test Teardown

*** Test Cases ***
Adjust quantity in the basket _ MAKNET-58
    [Tags]  MAKNET-58  priority_critical  must_pass  sanity  smoke  android  basket
    [Documentation]    Verify that quantity is changed as expected after change qty input and tap +/- button on basket page
    @{productinfo_1p}        search_api_feature.Search dynamic product from db    seller=${seller_name['1P_shop']}
    ${dynamic_productinfo1}        Set variable    ${productinfo_1p[0]}
    search_feature.Add product to basket from search results    ${dynamic_productinfo1['productname']}
    mobile_common.Tap basket menu
    # ios will fail line 30-38 at this kw because can't click +,- and trash icon (appium locator problem, wait dev fix)
    ${final_qty}    basket_feature.Verify quantity in basket after click increase or decrease button    ${dynamic_productinfo1['productname']}    ${amount_quantity['increase_amount_2']}   ${amount_quantity['decrease_amount_2']}
    basket_page.Tap at product name    ${dynamic_productinfo1['productname']}
    product_page.Verify product quantity at PDP     ${final_qty}
    product_page.Tap back at product detail page
    basket_feature.Delete product on basket    ${dynamic_productinfo1['productname']}
    mobile_common.Tap shopping menu
    search_feature.Add product to basket from search results    ${dynamic_productinfo1['productname']}
    mobile_common.Tap basket menu
    basket_page.Verify product and quantity display in basket    ${dynamic_productinfo1['productname']}
    # ios will fail at line 40 because can't input text to adjust qty (appium locator problem, wait dev fix)
    basket_feature.Verify quantity in basket after adjust quantity    ${dynamic_productinfo1['productname']}    ${amount_quantity['adjust_amount']}
    basket_page.Tap at product name    ${dynamic_productinfo1['productname']}
    product_page.Verify product quantity at PDP     ${amount_quantity['adjust_amount']}
    product_page.Tap back at product detail page
    # ios will fail at line 45 because can't input text to adjust qty   (appium locator problem, wait dev fix)
    basket_feature.Adjust product quantity to zero and verify product is deleted     ${dynamic_productinfo1['productname']}
    mobile_common.Tap shopping menu     accept_popup=False
    search_feature.Add product to basket from search results    ${dynamic_productinfo1['productname']}
    basket_feature.Verify product has been deleted successfully    ${dynamic_productinfo1['productname']}

Verify multiple seller section _ MAKNET-2347
    [Tags]  MAKNET-2347  priority_medium  sanity  smoke  android  basket
    [Documentation]     Verify after user add product to basket, at basket page show different seller name
    ...     Check the "checkout" button enable when order more than minimum 999 thb and total price correct
    @{productinfo_1p}        search_api_feature.Search dynamic product from db    seller=${seller_name['1P_shop']}
    @{productinfo_3p_SOD}    search_api_feature.Search dynamic product from db    seller=${seller_name['3P_SOD_AUTOMATE']}
    @{productinfo_3p_FBM}    search_api_feature.Search dynamic product from db    seller=${seller_name['3P_FBM_new']}    discount=True
    ${productinfo_1p}        Set variable    ${productinfo_1p[0]}
    ${productinfo_3p_SOD}    Set variable    ${productinfo_3p_SOD[0]}
    ${productinfo_3p_FBM}    Set variable    ${productinfo_3p_FBM[0]}
    @{all_product_price_list}       Create list       ${productinfo_1p['display_price']}    ${productinfo_3p_FBM['display_price']}  ${productinfo_3p_SOD['display_price']}
    login_feature.User login from my order    ${user['userforBasket_orderhistory']['email']}  ${user['userforBasket_orderhistory']['password']}
    basket_page.Clear basket via debug menu
    debug_page.Open search localization via debug menu
    Comment   Step: Verify porduct less than mimimum order can't checkout 
    basket_feature.Search and add multiple products to basket  ${productinfo_1p['productname']}
    mobile_common.Tap basket menu
    basket_page.Verify product in basket not able to checkout display  ${default['minimum_order']}  ${default['price_unit']}
    basket_page.Swipe to delete product by product name        ${productinfo_1p['productname']}

    basket_feature.Search and add multiple products to basket  ${productinfo_1p['productname']}      ${amount_quantity['increase_amount_2']}
    basket_feature.Search and add multiple products to basket  ${productinfo_3p_FBM['productname']}  ${amount_quantity['increase_amount_2']}
    basket_feature.Search and add multiple products to basket  ${productinfo_3p_SOD['productname']}  ${amount_quantity['increase_amount_2']}
    mobile_common.Tap basket menu
    @{seller_name_list}    Create list     ${seller_name['1P_basket_seller']}     ${productinfo_3p_FBM['seller']}   ${productinfo_3p_SOD['seller']}
    basket_page.Verify the number of sections at basket page        ${seller_name_list}
    ${total_qty}    mobile_common.Get new qty after click increase button  ${amount_quantity['increase_amount_2']}
    Comment   Step: Verify seller name and product detail
    basket_feature.Verify the detail of 1P products in the section  ${productinfo_1p}      ${total_qty}     ${productinfo_1p['productname']}
    basket_feature.Verify the detail of 3P products in the section  ${productinfo_3p_FBM}  ${total_qty}     ${productinfo_3p_FBM['productname']}
    basket_feature.Verify the detail of 3P products in the section  ${productinfo_3p_SOD}  ${total_qty}     ${productinfo_3p_SOD['productname']}
    ${size_data}           Get length    ${seller_name_list}
    ${all_total_qty}       mobile_common.Extend data equal to array size   ${total_qty}           ${size_data}  
    ${total_all_price}  basket_feature.Verify summary price in basket                   ${all_product_price_list}  ${all_total_qty}
    basket_feature.Verify total price with discount is correct after applied voucher    ${total_all_price}      ${voucher_data['voucher1']}
    basket_page.Verify product in basket able to checkout

Adding products to baskets from order details section _ MAKNET-2526
    [Tags]  MAKNET-2526    priority_high  sanity  smoke   android    ios   basket
    [Documentation]     Adding products to Baskets from Order details - filter by store / OOS /OOD
    [Setup]      mobile_common.Mango test setup     ${multistore_data['store04_zipcode']}        ${multistore_data['bangkhlo_subdistrict']['${lang}']} 
    basket_api.Login and delete basket via API  ${user['userforOrder_history']['user1']['email']}    ${user['userforOrder_history']['user1']['password']}
    login_feature.User login from my order    ${user['userforOrder_history']['user1']['email']}    ${user['userforOrder_history']['user1']['password']}
    order_history_feature.Click first order and add all item to basket
    checkout_feature.Complete checkout for the products added in basket without verifying amount
    mobile_common.Tap my orders menu
    ${pickpack_order_number}        medusa_api.Get latest order from medusa api        ${user['userforOrder_history']['user1']['email']}
    order_history_feature.Verify lastest order match with pickpack order number     ${pickpack_order_number}
    ${store_code}        medusa_api.Get lastest store code from medusa api      ${user['userforOrder_history']['user1']['email']}
    medusa_api.Verify store code should be default      ${store_code}

Verify minimum basket condition checkout _ MAKNET-2940
    [Tags]  MAKNET-2940  priority_critical  must_pass  sanity  smoke  android  ios  basket
    [Documentation]     Verify total value of basket below minimum basket can not checkout
    ...     Verify total value of basket exceed minimum basket can checkout
    ${dynamic_productinfo1}    search_api_feature.Post search info dynamic data    ${search_api['payload']['search_api_by_price_filters_under_200']}
    ${dynamic_productinfo2}    search_api_feature.Post search info dynamic data    ${search_api['payload']['search_api_by_price_filters_under_2000']}
    search_feature.Add product to basket from search results    ${dynamic_productinfo1['productname']}
    mobile_common.tap basket menu
    basket_page.Verify product in basket not able to checkout display    ${default['minimum_order']}   ${default['price_unit']}
    search_feature.Search product and increase quantity        ${dynamic_productinfo2['productname']}    ${10}
    mobile_common.tap basket menu
    basket_page.Verify product in basket able to checkout
    
Verify that user can apply and remove makro points in pay by points section _ MAKNET-3641
    [Tags]  MAKNET-3641  priority_critical  must_pass  sanity  smoke  android  basket
    [Documentation]     Verify point form display correct before and after apply point
    ...             Verify total price changed after apply discount by point and
    ...             after delete point, Makro point is restore to before applying points
    basket_api.Login and delete basket via API  ${user['userforTestpoint1']['email']}  ${user['userforTestpoint1']['password']}
    ${current_point}         myaccount_feature.Navigate to get point in my account  ${user['userforTestpoint1']['email']}       ${user['userforTestpoint1']['password']}
    @{productinfo_1p}        search_api_feature.Search dynamic product from db    seller=${seller_name['1P_shop']}
    ${productinfo_1p}        Set variable    ${productinfo_1p[0]}
    basket_feature.Search and add multiple products to basket  ${productinfo_1p['productname']}    ${productinfo_1p['min_qty']}
    ${current_qty}           mobile_common.Get new qty after click increase button    add_amount=${productinfo_1p['min_qty']}
    ${total_price}           mobile_common.Get total price by qty  ${productinfo_1p['display_price']}     ${current_qty}
    mobile_common.Tap basket menu
    basket_page.Verify total point on basket page is correct  ${current_point}
    basket_page.Verify pay by point label with arrow symbol display
    basket_feature.Verify total point on home page were deducted after using point in basket    ${current_point}
    basket_feature.Verify total point on home page shows same like basket after delete point   ${current_point}    ${total_price}
    ${total_price_with_fee}       basket_page.Get total price with delivery fee   ${total_price}
    basket_feature.Verify total price should be      ${total_price_with_fee}
    voucher_page.Verify voucher form is display

Verify price of multiple product & seller _ MAKNET-2348
    [Tags]  MAKNET-2348  priority_critical  must_pass  sanity  smoke  android  ios  basket
    [Documentation]     add products from different seller like 1P, 3P SOD and 3P FBM and then
    ...     try tap +,- on all products in basket page to check summary price correct follow qty changed
    ...     and verify empty basket after delete all products.
    ...     ** please open "search_localization_enabled" flag for run in en languge
    mobile_common.Tap shopping menu   accept_popup=${FALSE}
    basket_api.Login and delete basket via API  ${user['userforOrder_history']['user1']['email']}    ${user['userforOrder_history']['user1']['password']}
    ${seller_list}       Create list     ${seller_name['1P_shop']}     ${seller_name['3P_SOD_AUTOMATE']}      ${seller_name['3P_FBM_AUTOMATE']}
    ${product_detail}    basket_feature.Search and add all dynamic products to basket     ${seller_list}   ${mobile_test_data['maknet-2348']['add_qty_list']}    total_product=${amount_quantity['increase_amount_2']}
    basket_feature.Verify summary price from product detail and move to top     ${product_detail}
    basket_feature.Check all products price correct by increase and decrease qty follow odd and even order  ${product_detail}  ${6}  ${3}
    basket_feature.Decrease qty all products to left only one qty to verify trash icon  ${product_detail}
    basket_page.Clear basket via debug menu
    basket_feature.Verify empty basket

Login after checkout, Apply voucher with fixed value for all products with minimum basket and total usage at basket _ MAKNET-1369
    [Tags]  MAKNET-1369  priority_critical  must_pass  sanity  smoke  android  ios  basket
    [Documentation]    Verify that voucher can apply for all products (product 1P and product 3P) having specific conditions
    debug_page.Open search localization via debug menu
    ${seller_list}       Create list     ${seller_name['1P_shop']}     ${seller_name['3P_FBM_AUTOMATE']}
    ${product_detail}    basket_feature.Search and add all dynamic products to basket     ${seller_list}   ${mobile_test_data['maknet-1369']['add_qty_list']}    price_range=${mobile_test_data['maknet-1369']['price_minimun']}    target_brand=${mobile_test_data['maknet-1369']['brand_list']}    
    ${total_price}   mobile_common.Calculate total price      ${product_detail['seller_0'][0]['display_price']}    ${product_detail['seller_1'][0]['display_price']}    
    login_feature.User login from my favourite list         ${voucher_data['email']}  ${voucher_data['password']}
    mobile_common.Tap basket menu
    basket_feature.Verify total price with discount is correct after applied voucher    ${total_price}      ${voucher_data['voucher1']}
    basket_feature.Verify total price with fee is correct after remove voucher            ${total_price}      ${voucher_data['voucher1']['voucher_name']}
    basket_feature.Verify total price with discount is correct after applied voucher    ${total_price}      ${voucher_data['voucher1']}

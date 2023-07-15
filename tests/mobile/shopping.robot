*** Settings ***
Force Tags       shopping    regression
Resource        ../../common/mobile/mobile_common.resource
Resource        ../../common/api/api_common.resource

Suite Setup         mobile_common.Mango Suite Setup
Test Setup          mobile_common.Mango Test Setup 
Test Teardown       mobile_common.Mango Test Teardown   

*** Test Cases ***
Adjust product quantity on search result page by +/- button _ MAKNET-342
    [Tags]  MAKNET-342  priority_high  sanity  smoke  android  ios  search
    [Documentation]     Verify quantity of product changed after tap +/- on search result page and display quantity correct at cart page
    mobile_common.Tap shopping menu  accept_popup=${FALSE}
    @{productinfo_1p}        search_api_feature.Search dynamic product from db    seller=${seller_name['1P_shop']}
    ${productinfo_1p}        Set variable    ${productinfo_1p[0]}
    search_feature.Search product from searchbar    ${productinfo_1p['productname']}
    productcard_page.Click add to basket at product card       ${productinfo_1p['productname']}
    productcard_page.Update basket    ${productinfo_1p['productname']}
    product_feature.Verify quantity in basket after click increase or decrease button    ${productinfo_1p['productname']}    ${amount_quantity['increase_amount_1']}   ${amount_quantity['decrease_amount_1']}

Adjust product quantity on shopping page by +/- button _ MAKNET-1289
    [Tags]  MAKNET-1289  priority_high  sanity   smoke  android  shopping
    [Documentation]     Tap +,- at home page and verify qty changed at home page, basket page and product page
    basket_api.Login and delete basket via API      ${user['userforOrder_history']['user1']['email']}  ${user['userforOrder_history']['user1']['password']}
    mobile_common.Tap shopping menu   accept_popup=${FALSE}
    home_page.Verify promotion category is display
    home_page.Tap + add first item in promotion category
    ${product_name}     home_page.Get product name of first product in promotion category
    productcard_page.Verify qty product display correct         ${product_name}       ${default['qty_basket']}
    productcard_page.Open update quantity                       ${product_name}       ${default['qty_basket']}
    home_page.Tap trash button
    home_page.Verify toast message show product remove from basket
    home_page.Tap + add first item in promotion category
    product_feature.Update and increase quantity  ${product_name}    ${amount_quantity['increase_amount_2']}   ${default['qty_basket']}
    product_feature.Update and decrease quantity  ${product_name}    ${amount_quantity['decrease_amount_1']}   ${amount_quantity['product_qty_display_5']}
    mobile_common.Tap shopping menu   accept_popup=${FALSE}
    home_page.Tap at product name                               ${product_name}
    product_page.Verify product quantity at PDP     ${amount_quantity['product_qty_display_1']}
    mobile_common.tap basket menu
    basket_page.Verify product and quantity display in basket   ${product_name}       ${amount_quantity['product_qty_display_1']}

[1P] PDP without discount, delivery desc. _ MAKNET-5103
    [Tags]  MAKNET-5103   priority_critical  must_pass   sanity   smoke  android  ios  product
    [Documentation]     Verify that product detail at PDP page can display correctly. 
    ...                 One product has no discount and another has discount period.
    mobile_common.Tap shopping menu  accept_popup=${FALSE}
    @{productinfo_1p}        search_api_feature.Search dynamic product from db    seller=${seller_name['1P_shop']}
    ${productinfo_1p}        Set variable    ${productinfo_1p[0]}
    @{productinfo_3p}    search_api_feature.Search dynamic product from db    seller=${seller_name['3P_FBM_new']}
    ${productinfo_3p}        Set variable    ${productinfo_3p[0]}
    search_feature.Search product from searchbar    ${productinfo_1p['productname']}
    ${1P_unit_price}    search_page.Get product price at search page    ${productinfo_1p['productname']}
    product_page.Select product                     ${productinfo_1p['productname']}
    product_feature.Verify product detail  ${productinfo_1p}  ${1P_unit_price}
    mobile_common.Tap shopping menu  accept_popup=${FALSE}
    search_feature.Search product from searchbar    ${productinfo_3p['productname']}
    ${3P_unit_price}    search_page.Get product price at search page    ${productinfo_3p['productname']}
    product_page.Select product                     ${productinfo_3p['productname']}
    product_feature.Verify product detail  ${productinfo_3p}  ${3P_unit_price}

[3P] PDP with discount, estimate delivery time _ MAKNET-5106
    [Tags]  MAKNET-5106  priority_high  sanity   smoke  android  ios  product
    [Documentation]     Verify each product type show different discount detail
    Comment   case : product with discount without start and end date
    mobile_common.Tap shopping menu  accept_popup=${FALSE}
    search_feature.Search product from searchbar    ${product_data['product1']}
    ${discount_price}       ${original_price}       product_feature.Get discount price and original price from product      ${product_data['product1']}
    product_page.Select product                     ${product_data['product1']}
    product_feature.Verify discount percentage is correct  ${original_price}  ${discount_price}
    product_page.Verify discount duration not shown at PDP
    
    Comment   case : case : product with discount & starts date
    mobile_common.Tap shopping menu  accept_popup=${FALSE}
    search_feature.Search product from searchbar    ${product_data['product2']}
    ${discount_price}       ${original_price}       product_feature.Get discount price and original price from product      ${product_data['product2']}
    product_page.Select product                     ${product_data['product2']}
    product_feature.Verify discount percentage is correct  ${original_price}  ${discount_price}
    product_page.Verify discount starts date is shown at PDP

    Comment   case : product with discount & end date
    mobile_common.Tap shopping menu  accept_popup=${FALSE}
    search_feature.Search product from searchbar    ${product_data['product3']}
    ${discount_price}       ${original_price}       product_feature.Get discount price and original price from product      ${product_data['product3']}
    product_page.Select product                     ${product_data['product3']}
    product_feature.Verify discount percentage is correct  ${original_price}  ${discount_price}
    product_page.Verify discount end date is shown at PDP

    Comment   case : product with discount & both start and end date
    mobile_common.Tap shopping menu  accept_popup=${FALSE}
    search_feature.Search product from searchbar    ${product_data['product4']}
    ${discount_price}       ${original_price}       product_feature.Get discount price and original price from product      ${product_data['product4']}
    product_page.Select product                     ${product_data['product4']}
    product_feature.Verify discount percentage is correct  ${original_price}  ${discount_price}
    product_page.Verify discount start and end date is shown at PDP

Exceed quantity alert on PDP and PLP and Search result _ MAKNET-5105 MAKNET-5112 MAKNET-351
    [Tags]  MAKNET-5105  MAKNET-5112  MAKNET-351  priority_critical  must_pass  sanity   smoke  android  ios  product
    [Documentation]     MAKNET-5105 is Exceed quantity alert on product details page (PDP)
    ...                 MAKNET-5112 is Exceed quantity alert on product list page (PLP)
    ...                 MAKNET-351 is Exceed quantity alert on at search result
    ${dynamic_productinfo1}    search_api_feature.Post search info dynamic data    ${search_api['payload']['search_api_payload_dog_collection']}    ${3}
    # search results page
    search_feature.Search product from searchbar  ${dynamic_productinfo1['productname']}
    productcard_page.Click add to basket at product card    ${dynamic_productinfo1['productname']}
    productcard_page.Update basket    ${dynamic_productinfo1['productname']}
    product_feature.Verify error after input qty exceed stock after search at product card    ${dynamic_productinfo1['productname']}    ${product_data['Pet_accessories_product']['product_qty_exceed']}
    # product list page
    search_feature.Go to PLP of product  ${mobile_additional['main_category']['pet accessories']}     ${mobile_additional['sub_category']['pet_bedding']}    ${dynamic_productinfo1['productname']}
    product_feature.Verify error after input qty exceed stock at product card    ${dynamic_productinfo1['productname']}    ${product_data['Pet_accessories_product']['product_qty_exceed']}    ${amount_quantity['adjust_amount_max']}
    # product details page
    search_feature.Go to PDP of product  ${mobile_additional['main_category']['pet accessories']}     ${mobile_additional['sub_category']['pet_bedding']}    ${dynamic_productinfo1['productname']}
    product_feature.Verify error after input qty exceed stock at PDP    ${dynamic_productinfo1['productname']}    ${product_data['Pet_accessories_product']['product_qty_exceed']}    ${amount_quantity['adjust_amount_max']}

Add product to basket from category and adjust the quality _ MAKNET-5111
    [Tags]  MAKNET-5111  priority_critical  must_pass  sanity   smoke  android  ios  product
    [Documentation]     Verify quantity of product changed after tap +/- on product list page and show the same qty
    ...            on cart page, product detail page and search result page
    ${dynamic_productinfo1}    search_api_feature.Post search info dynamic data    ${search_api['payload']['search_api_payload_dog_collection']}    ${3}
    Comment   step: verify increase and decrease on product list page and cart page
    search_feature.Go to PLP of product         ${mobile_additional['main_category']['pet accessories']}     ${mobile_additional['sub_category']['pet_bedding']}        ${dynamic_productinfo1['productname']}
    productcard_page.Click add to basket at product card    ${dynamic_productinfo1['productname']}
    productcard_page.Update basket    ${dynamic_productinfo1['productname']}
    ${total_qty}     product_feature.Verify quantity in basket after click increase or decrease button  ${dynamic_productinfo1['productname']}  ${amount_quantity['increase_amount_2']}   ${amount_quantity['decrease_amount_1']}
    Comment   step: verify product detail page show the same qty from product list page
    basket_page.Tap at product name                         ${dynamic_productinfo1['productname']}
    product_page.Verify product quantity at PDP on typing mode    ${total_qty}  
    Comment   step: verify product qty in search result page show the same qty from product list page
    mobile_common.Tap shopping menu  accept_popup=${FALSE}
    search_feature.Search product from searchbar            ${dynamic_productinfo1['productname']}
    productcard_page.Verify qty product display correct         ${dynamic_productinfo1['productname']}       ${total_qty}

Add product to basket and adjust product quantity : PDP , recommendation _ MAKNET-5104
    [Tags]  MAKNET-5104  priority_critical  must_pass  sanity   smoke  android  ios  product
    [Documentation]     Verify quantity of product changed after tap +/- on PDP page and display quantity correct at cart page
    mobile_common.Tap shopping menu   accept_popup=${FALSE}
    ${dynamic_productinfo1}    search_api_feature.Post search info dynamic data    ${search_api['payload']['search_api_payload1']}
    search_feature.Search product from searchbar    ${dynamic_productinfo1['productname']}
    product_page.Select product                     ${dynamic_productinfo1['productname']}
    productcard_page.Tap add to basket button       ${dynamic_productinfo1['productname']}
    product_feature.Verify quantity in basket after click increase or decrease button  ${dynamic_productinfo1['productname']}  ${amount_quantity['increase_amount_1']}   ${amount_quantity['decrease_amount_1']}

Verify product badge : fresh _ MAKNET-2860
    [Tags]  MAKNET-2860  priority_critical  must_pass  sanity   smoke  android  ios  product
    [Documentation]     Verify fresh category show on home page and fresh badge show on all pages like PDP product page,
    ...  search result, search recommend page, basket page, favourite page, PLP product page
    ${vegetable_collection_result}      search_api_feature.Post search info dynamic data    ${search_api['payload']['search_api_vegetable_collection']}
    ${fresh_badge_promotion_result}     search_api_feature.Post search info dynamic data    ${search_api['payload']['search_api_fresh_badge_has_promotion']}
    ${fresh_badge_no_promotion_result}  search_api_feature.Post search info dynamic data    ${search_api['payload']['search_api_fresh_badge_no_promotion']}
    basket_api.Login and delete basket via API                     ${user_os['userforFavourite_scenario']['email']}  ${user_os['userforFavourite_scenario']['password']}
    favourite_api.Call API delete all favorite list on this user   ${user_os['userforFavourite_scenario']['email']}  ${user_os['userforFavourite_scenario']['password']}
    login_feature.User login from my favourite list                ${user_os['userforFavourite_scenario']['email']}  ${user_os['userforFavourite_scenario']['password']}
    Comment   Step: Verify Product with fresh tag should have fresh badge in fresh section and tap see all to verify all product
    product_feature.Tap see all from home section and verify all product have target badge  ${mobile['global']['fresh']}  ${fresh_badge_promotion_result['productname']}  ${fresh_badge_no_promotion_result['productname']}
    Comment   Step: User add product with fresh tag to basket and go to basket
    mobile_common.tap basket menu
    basket_page.Verify target badge display on product in basket        ${mobile['global']['fresh']}  ${fresh_badge_promotion_result['productname']}
    Comment   Step: User go to PDP of product with fresh tag
    basket_page.Tap at product name                                     ${fresh_badge_promotion_result['productname']}
    product_page.Verify target badge display on product on PDP page     ${mobile['global']['fresh']}  ${fresh_badge_promotion_result['productname']}
    Comment   Step: User add product with fresh tag to favorite list and corresponding list
    favourite_feature.Verify target badge display after add to favourite list  ${favourite['listname50']}  ${mobile['global']['fresh']}  ${fresh_badge_promotion_result['productname']}
    Comment   Step: User input product name with fresh tag and verify fresh badge is visible in search suggestion and search result
    search_feature.Verify target badge display on search suggestion and search result  ${mobile['global']['fresh']}  ${fresh_badge_promotion_result['productname']}
    Comment   Step: User go to PLP of product with fresh tag and verify fresh badge is visible on product list
    search_feature.Go to PLP of product                                 ${mobile_additional['main_category']['meat']}   ${mobile_additional['sub_category']['beef']}   ${vegetable_collection_result['productname']}   ${mobile_additional['sub_category']['chilled']}
    productcard_page.Verify target badge display on product card        ${mobile['global']['fresh']}  ${vegetable_collection_result['productname']}

Product have slab pricing then we display the slab 2 default view as fixed price. _ MAKNET-5973
    [Tags]  MAKNET-5973  priority_critical  must_pass   sanity   smoke  android  ios
    [Documentation]     If product have slab pricing then we display the slab 2 default view as fixed price.
    login_feature.User login from my order      ${user['userforOrder_history']['user1']['email']}    ${user['userforOrder_history']['user1']['password']}
    mobile_common.Tap shopping menu
    home_page.Tap see all category      ${mobile_additional['main_category']['slabPrice']}
    productcard_page.Click add to basket at product card   ${product_data['slab_price_product']}
    productcard_page.Verify product display all slab prices type   ${mobile_additional['slab_price']['lbl_info4']}   ${mobile_additional['slab_price']['lbl_info5']}   ${mobile_additional['slab_price']['lbl_info6']}
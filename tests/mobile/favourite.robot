*** Settings ***
Force Tags       favourite    regression
Resource        ../../common/mobile/mobile_common.resource
Resource        ../../common/api/api_common.resource


Suite Setup         mobile_common.Mango Suite Setup
Test Setup          mobile_common.Mango Test Setup
Test Teardown       mobile_common.Mango Test Teardown

*** Test Cases ***
PDP : create list / add-remove product / redirect from list _ MAKNET-5969
    [Tags]  MAKNET-5969  priority_critical  must_pass  sanity  smoke  android  ios  favourite
    [Documentation]     Verify that user is able to create new favourite type and add product to that favourite type
    [Setup]      Run keywords
    ...          Run keyword and ignore error        favourite_api.Call API delete all favorite list on this user     ${user_os['userforFavourite_scenario']['email']}  ${user_os['userforFavourite_scenario']['password']}
    ...     AND  mobile_common.Mango test setup
    # user without list
    login_feature.User login from my favourite list         ${user_os['userforFavourite_scenario']['email']}  ${user_os['userforFavourite_scenario']['password']}
    ${product_1p}    search_api_feature.Post search info dynamic data    ${search_api['payload']['search_api_payload_suggestions']}
    mobile_common.Tap shopping menu    login=True
    search_feature.Search product and go to PDP  ${product_1p['productname']}
    favourite_page.Click favourite icon in PDP
    favourite_feature.Create new favourite list with name from PDP    ${favourite['listname50']}    no_list=${True}
    favourite_page.Verify favourite icon that filled
    # remove product
    mobile_common.Tap favourite list menu
    favourite_page.Click on list for view list detail  ${favourite['listname50']}
    favourite_feature.Delete product from favourite list by swipe              ${product_1p['productname']}
    # add to existing list
    search_feature.Search product and go to PDP  ${product_1p['productname']}
    favourite_page.Verify favourite icon that unfilled
    favourite_feature.Add product to favourite list    ${favourite['listname50']}
    # PDP redirection
    mobile_common.Tap favourite list menu
    favourite_page.Click on list for view list detail  ${favourite['listname50']}
    favourite_page.Click product in list details    ${product_1p['productname']}
    product_page.Tap back at product detail page
    # verify quantity can be 0 in list
    favourite_detail_page.List detail display product with quantity     ${product_1p['productname']}  ${default['qty_favorite']}
    favourite_feature.Verify quantity changed after tab decrease button  ${product_1p['productname']}  ${amount_quantity['decrease_amount_1']}
    # remove from existing list
    mobile_common.Tap shopping menu  accept_popup=${FALSE}
    search_feature.Search product and go to PDP  ${product_1p['productname']}
    favourite_page.Verify favourite icon that unfilled
    favourite_page.Click favourite icon in PDP
    favourite_feature.Create new favourite list with name from PDP    ${favourite['listnameEN1']}
    favourite_page.Toast message should display update add product to list successful
    favourite_page.Verify favourite icon that filled
    favourite_feature.Remove product from favourite list    ${favourite['listnameEN1']}
    favourite_page.Verify favourite icon that unfilled
    # add to multiple list
    favourite_feature.Add product to favourite list    ${favourite['listname50']}      ${favourite['listnameEN1']}
    favourite_page.Verify favourite icon that filled

My lists detail page : verify multi seller section/ adjust quantity / add all product to basket _ MAKNET-5276
    [Tags]  MAKNET-5276  priority_high  sanity  smoke  android  ios  favourite
    [Documentation]     Verify quantity of product changed after tap +/- on favourite page and display quantity correct at favourite page
    ...                 Verify product list after add items from your favourite list to cart with all items listed.
    [Setup]      Run keywords
    ...          favourite_api.Call API delete all favorite list on this user     ${user_os['userforFavourite_scenario']['email']}  ${user_os['userforFavourite_scenario']['password']}
    ...     AND  mobile_common.Mango Test Setup
    # # Login via api to delete basket prevent flaky
    basket_api.Login and delete basket via API  ${user_os['userforFavourite_scenario']['email']}  ${user_os['userforFavourite_scenario']['password']}
    login_feature.User login from my favourite list         ${user_os['userforFavourite_scenario']['email']}  ${user_os['userforFavourite_scenario']['password']}
    mobile_common.Tap favourite list menu
    favourite_feature.Create new favourite list with name   ${favourite['listnameEN1']}
    mobile_common.Tap shopping menu     login=True
    @{productinfo_1p}        search_api_feature.Search dynamic product from db    seller=${seller_name['1P_shop']}
    @{3p_fbm_new}       search_api_feature.Search dynamic product from db    seller=${seller_name['3P_FBM_new']}
    @{3p_fruitgogogo}        search_api_feature.Search dynamic product from db    seller=${seller_name['3P_fruitgogogo']}
    ${productinfo_1p}        Set variable    ${productinfo_1p[0]}
    ${3p_fbm_new}       Set variable    ${3p_fbm_new[0]}
    ${3p_fruitgogogo}        Set variable    ${3p_fruitgogogo[0]}

    favourite_feature.Search product and add to favourite list  ${productinfo_1p['productname']}       ${favourite['listnameEN1']}
    favourite_feature.Search product and add to favourite list  ${3p_fbm_new['productname']}      ${favourite['listnameEN1']}
    favourite_feature.Search product and add to favourite list  ${3p_fruitgogogo['productname']}       ${favourite['listnameEN1']}
    mobile_common.Tap favourite list menu
    favourite_page.Click on list for view list detail       ${favourite['listnameEN1']}
    # # verify multi seller section
    favourite_feature.List detail display product shipment by partner on product    ${productinfo_1p['productname']}      ${mobile['product']['message']['deliveryTimeInfoTitle']}
    favourite_feature.List detail display product shipment by partner on product    ${3p_fbm_new['productname']}      ${mobile_additional['basket']['message']['by']} ${3p_fbm_new['seller']}
    favourite_feature.List detail display product shipment by partner on product    ${3p_fruitgogogo['productname']}      ${mobile_additional['basket']['message']['by']} ${3p_fruitgogogo['seller']}
    # adjust quantity
    favourite_feature.Verify quantity and detail of product after click increase    ${productinfo_1p['productname']}    ${amount_quantity['product_qty_display_1']}
    favourite_feature.Verify quantity and detail of product after click decrease    ${productinfo_1p['productname']}    ${amount_quantity['product_qty_display_2']}
    favourite_feature.Verify quantity and detail of product after click adjust      ${productinfo_1p['productname']}    ${amount_quantity['product_qty_display_5']}
    # add to basket should merge with current basket
    favourite_detail_page.Click add all product to basket button
    mobile_common.Tap basket menu
    basket_page.Verify product and quantity display in basket    ${productinfo_1p['productname']}  ${amount_quantity['product_qty_display_5']}
    basket_page.Verify product and quantity display in basket    ${3p_fbm_new['productname']}  ${amount_quantity['product_qty_display_2']}
    basket_page.Verify product and quantity display in basket    ${3p_fruitgogogo['productname']}  ${amount_quantity['product_qty_display_2']}

Non-login user not be able to use favorite list feature _ MAKNET-5964
    [Tags]  MAKNET-5964  priority_medium  sanity  smoke  android  ios
    [Documentation]     Non-login user not be able to use favorite list feature , lead user to my List menu that suggestion to login
    home_page.Tap first product at target category to PDP page      ${mobile_additional['promotions']['label']['latest_promotion_only']}
    favourite_page.Click favourite icon in PDP
    favourite_page.Favourite list page should suggestion to login
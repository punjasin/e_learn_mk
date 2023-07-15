*** Settings ***
Force Tags       order_history    regression
Resource        ../../common/mobile/mobile_common.resource
Resource        ../../common/api/api_common.resource
Resource        ../../common/web/web_common.resource

Suite Setup         mobile_common.Mango Suite Setup
Test Setup          mobile_common.Mango Test Setup
Test Teardown       mobile_common.Mango Test Teardown

*** Test Cases ***
Status tab : payment pending _ MAKNET-2918 MAKNET-6266 MAKNET-6267 MAKNET-6268
    [Tags]  MAKNET-2918  MAKNET-6266  MAKNET-6267  MAKNET-6268  priority_high  sanity   smoke  android
    [Documentation]     Verify Mirakl status 'Debit in Progress' and 'Pending Acceptance' change to shipping in progress after paid and verify order detail
    ...                 MAKNET-6266 is Verify the user can able to add the previous order to cart and same order displayed in cart
    ...                 MAKNET-6267 is Verify the user can cable to increased/decreased the item count after adding the same previous order to cart
    ...                 MAKNET-6268 is Verify the user can able to checkout their cart as usual after adding the previous order from recent orders.
    basket_api.Login and delete basket via API  ${user['userforOrder_history']['user1']['email']}    ${user['userforOrder_history']['user1']['password']}
    login_feature.User login from my order    ${user['userforOrder_history']['user1']['email']}    ${user['userforOrder_history']['user1']['password']}
    mobile_common.Tap shopping menu   accept_popup=${FALSE}
    ${product_basket}       homepage_feature.Click first recent order get all productname and add all productname to basket until verify product to basket
    basket_feature.Verify quantity in basket after click increase or decrease button with product list  ${product_basket}
    ${payment_ref}   ${amount}      checkout_feature.Complete checkout for the products added in basket without verifying amount
    mobile_common.Tap my orders menu
    ${order_id}        medusa_api.Get latest order from medusa api        ${user['userforOrder_history']['user1']['email']}
    order_history_page.Verify order status by order id      ${order_id}     ${mobile['order']['label']['unpaid']}

Status tab : shipped _ MAKNET-2920
    [Tags]  MAKNET-2920  priority_high  sanity   smoke  android  ios  orderhistory
    [Documentation]    Verify order detail after paid and then continue pick, pack, ship on OMS pickpack
    [Teardown]         Run keywords     mobile_common.Mango Test Teardown
    ...                AND              web_common.Close browser
    @{productinfo_1p}        search_api_feature.Search dynamic product from db    seller=${seller_name['1P_shop']}
    @{3p_fbm_automate}       search_api_feature.Search dynamic product from db    seller=${seller_name['3P_FBM_AUTOMATE']}
    ${productinfo_1p}        Set variable    ${productinfo_1p[0]}
    ${3p_fbm_automate}       Set variable    ${3p_fbm_automate[0]}

    basket_api.Login and delete basket via API  ${user['userforOrder_history']['user1']['email']}    ${user['userforOrder_history']['user1']['password']}
    login_feature.User login from my order      ${user['userforOrder_history']['user1']['email']}    ${user['userforOrder_history']['user1']['password']}
    basket_feature.Search and add multiple products to basket   ${productinfo_1p['productname']}     ${productinfo_1p['min_qty']}
    basket_feature.Search and add multiple products to basket   ${3p_fbm_automate['productname']}    ${3p_fbm_automate['min_qty']}
    mobile_common.Tap basket menu
    ${payment_ref}   ${amount}      checkout_feature.Complete checkout for the products added in basket without verifying amount
    123_portal_feature.Open 123 portal and mark as paid                ${payment_ref}      ${payment['123_portal']['AgentCode']['KBANK']}   ${payment['123_portal']['ChannelCode']['IMB']}     ${amount}
    ${pickpack_order_number}        medusa_api.Get latest order from medusa api        ${user['userforOrder_history']['user1']['email']}
    pickpack_feature.Open pickpack and login
    pickpack_feature.Complete pick pack shipped  ${pickpack_order_number}  ${pickpack['picpack zone']['makro_zone']}
    order_history_feature.Change tab and verify order status by order id      ${pickpack_order_number}     ${mobile['order']['label']['shipped']}

Status tab : cancelled _ MAKNET-3869
    [Tags]  MAKNET-3869  priority_high  sanity   smoke  android  ios    orderhistory
    [Documentation]     Verify that order detail header, product section and payment section in cancelled tab display correctly
    ${refund_order}     medusa_api.Get order details from medusa api via email and order status  ${user['userforOrdercancelled']['email']}  ${medusa_api['order_status']['pending']}
    ${canceled_order}   medusa_api.Get order details from medusa api via email and order status  ${user['userforOrdercancelled']['email']}  ${medusa_api['order_status']['cancel']}

    login_feature.User login from my order      ${user['userforOrdercancelled']['email']}        ${user['userforOrdercancelled']['password']}
    order_history_page.Verify current tab is target status  ${mobile['order']['tab']['all']}

    order_history_page.Verify refund tag is display on order list
    order_history_page.Verify target order number has cancel status display on order list    ${canceled_order['orders'][0]['order_id']}     moveto=${scroll_direction['top']}
    order_history_page.Swipe to the tab in my orders        ${mobile['order']['tab']['cancelled']}
    order_history_page.Verify target order number has cancel status display on order list    ${canceled_order['orders'][0]['order_id']}
    order_detail_feature.Tap at order number to verify canceled order detail is correct   ${canceled_order['orders'][0]}    ${order_test_data['maknet-2922']['order_2']}

Verify recent order detail _ MAKNET-6259 MAKNET-6260 MAKNET-6261 MAKNET-6263 MAKNET-6264 MAKNET-6265 MAKNET-6269
    [Tags]    MAKNET-6259    MAKNET-6260    MAKNET-6261    MAKNET-6263    MAKNET-6264    MAKNET-6265    MAKNET-6269
    [Documentation]   Verify the Recent order section is displayed below Top banner and above collections in homepage _ MAKNET-6259
    ...         Verify the See all option is displayed on the right side of the home page and by clicking see all user get previous order list _ MAKNET-6260
    ...         Verify the user can able to see a latest five previous order list in home page _ MAKNET-6261
    ...         Verify the product images is displayed on the each order and rest of the order count will be displayed as a number ex:+10 _ MAKNET-6263
    ...         Verify the order status is displayed for each orders ex :shipped, completed _ MAKNET-6264
    ...         Verify the order id, date and total amount is displayed for each order it self  in home page _ MAKNET-6265
    ...         Verify the user can able to view the orders list from recent order by using swipe MAKNET-6269
    login_feature.User login from my order      ${mobile_test_data['maknet-6259']['user']['email']}        ${mobile_test_data['maknet-6259']['user']['password']}
    @{order_list}            order_history_feature.Get order history to dictionary             ${orderhistory.order_card_details}    ${orderhistory.order_card_status}
    @{recent_order_list}     homepage_feature.Get recent order to dictionary
    homepage_feature.Verify the recent order section is displayed betweeen top banner and above collections in homepage
    homepage_feature.Verify recent orders displays the same list as the order history page            ${order_list}    ${recent_order_list}
    home_page.Verify image on recent order card is display correct number    ${order_list}    ${recent_order_list}
    homepage_feature.Verify order details on recent order cards display correct    ${order_list}    ${recent_order_list}
    homepage_feature.Verify see all button is display and tap see all button        ${homepage.txt_see_all_recent_order}

Status tab : delivered _ MAKNET-2921
    [Tags]    MAKNET-2921    priority_high  sanity   smoke  android  ios    orderhistory
    [Documentation]    Verify delivered tab display seller, order id, total amount correct same like order history detail page
    login_feature.User login from my order      ${user['userforOrder_history']['user1']['email']}        ${user['userforOrder_history']['user1']['password']}
    order_history_page.Verify current tab is target status  ${mobile['order']['tab']['all']}
    order_history_page.Swipe to the tab in my orders        ${mobile['order']['label']['delivered']}
    ${order_no}    order_history_page.Get lastest order number of order history
    order_history_page.Verify order history card status same like order title tab    ${mobile['order']['label']['delivered']}
    order_history_page.Tap at order number     ${order_no}
    mobile_common.Wait until loading complete
    order_detail_page.Verify order delivered display
    ${seller_name}      order_detail_page.Get seller name
    ${total_price}      order_detail_page.Get total price
    order_detail_page.Tap back button
    order_history_page.Verify amount on order card    ${order_no}    ${total_price}
    order_history_page.Verify seller name of target number correct   ${order_no}    ${seller_name}

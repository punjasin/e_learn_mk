*** Settings ***
Force Tags       navigation    regression
Resource        ../../common/mobile/mobile_common.resource
Resource        ../../common/api/api_common.resource

Suite Setup         mobile_common.Mango Suite Setup
Test Setup          mobile_common.Mango Test Setup 
Test Teardown       mobile_common.Mango Test Teardown   

*** Test Cases ***
Verify store is selected via subdistrict _ MAKNET-3297 _ MAKNET-3299
    [Tags]  MAKNET-3297    MAKNET-3299  priority_high  sanity   smoke  android  ios  navigation
    [Documentation]     MAKNET-3297    Verify store is selected via subdistrict
    ...    MAKNET-3299    Product on homepage display only product in selected store
    promotion_feature.Verify store on last promotion is selected via subdistrict    ${multistore_data['samaedam_zipcode']}      ${multistore_data['samaedam_subdistrict']['${lang}']}    ${product_data['product_store4']['${lang}']}      ${product_data['0408_product']}
    promotion_feature.Verify store on last promotion is selected via subdistrict    ${multistore_data['phuetudom_zipcode']}      ${multistore_data['phuetudom_subdistrict']['${lang}']}     ${product_data['product_store8']}      ${product_data['0408_product']}
    home_page.Tap zip code selector
    homepage_feature.Enter zip code and save       ${multistore_data['bangplasoi_zipcode']}      ${multistore_data['bangplasoi_subdistrict']['${lang}']} 
    home_page.Verify selected zip code display as    ${multistore_data['bangplasoi_zipcode']}
    promotion_feature.Tap product and verify the product not sold by makro
    home_page.Tap zip code selector
    home_page.Enter zip code        ${multistore_data['non_support_zipcode']}
    home_page.Error message should display as       ${mobile['multistore']['message']['outsideAreaErrorInput']}

Force select zip code when user are in app _ MAKNET-2450
    [Tags]  MAKNET-2450  priority_high  sanity   smoke  android  ios  navigation 
    [Documentation]     Verify that user cannot close zipcode popup at first usage app even swipe or close app and reopen.
    [Setup]      mobile_common.Open application     ${lang}
    onboarding_feature.Skip onboarding process if exist
    home_page.Verify provide your zip code popup is display
    homepage_feature.Verify zip code popup display after quit app and reopen
    homepage_feature.Verify zip code popup not close when swipe or tap back
    homepage_feature.Enter zip code and save         ${multistore_data['store4_zipcode']}  ${multistore_data['store4_subdistrict']['${lang}']}
    home_page.Verify selected zip code display as    ${multistore_data['store4_zipcode']}

Verify CVP content, accept all privacy consent and continue to shopping _ MAKNET-1874 MAKNER-1875 MAKNET-3430 MAKNET-3431
    [Tags]  MAKNET-1874  MAKNET-1875  MAKNET-3430  MAKNET-3431  priority_high  sanity   smoke  android  ios  navigation
    [Documentation]     MAKNET-1874    CVP : 3 page - click next / back / skip
    ...    MAKNET-1875    Start to shopping on End onboarding page
    ...    MAKNET-3430    When user device language is NOT Thai, app display in English
    ...    MAKNET-3431    When user device language is Thai, app display in Thai
    [Setup]  mobile_common.Open application  ${lang}
    #### Step: View CVP page
    onboarding_page.Verify CVP page appear
    onboarding_feature.Click next on CVP 3 page
    onboarding_feature.Click back on CVP 3 page
    onboarding_feature.Verify CVP content - online market
    mobile_common.Swipe right to left android
    onboarding_feature.Verify CVP content - product quantity
    mobile_common.Swipe right to left android
    onboarding_feature.Verify CVP content - delivery
    onboarding_page.Click get start
    
    #### Step: Onboarding end
    onboarding_page.Click start shoppping
    homepage_feature.Enter zip code when open application
    pdpa_cookie_feature.Accept all for sdk cookie popup if exist

Verify unable to continue shopping when enter OOD zipcode _ MAKNET-4640
    [Tags]  MAKNET-4640  priority_medium  sanity   smoke  android  ios  navigation
    [Documentation]     Verify when select out of area zipcode show error message and not allow to continue search
    [Setup]  mobile_common.Open application     ${lang}
    onboarding_feature.Skip onboarding process if exist
    home_page.Verify provide your zip code popup is display
    homepage_feature.Verify zipcode outside of delivery area has error message  ${default['ood_zipcode']}

Screenshot on bank transfer QR code section _ MAKNET-3455
    [Tags]  MAKNET-3455  priority_high  sanity   smoke  android  ios  navigation
    [Documentation]     User should be able to take screenshot on bank transfer QR code and checkout step 3
    @{productinfo_1p_shop}        search_api_feature.Search dynamic product from db    seller=${seller_name['3P_BEEF']}
    ${productinfo_1p_shop}        Set variable    ${productinfo_1p_shop[0]}
    basket_api.Login and delete basket via API  ${user['userforOrder_history']['user1']['email']}  ${user['userforOrder_history']['user1']['password']}
    login_feature.User login from my order    ${user['userforOrder_history']['user1']['email']}    ${user['userforOrder_history']['user1']['password']}
    debug_page.Open prevent screenshots via debug menu
    mobile_common.Tap shopping menu     login=True
    search_feature.Add product to basket from search results    ${productinfo_1p_shop['productname']}
    mobile_common.Tap basket menu
    checkout_feature.Checkout by bank transfer until qr code
    checkout_2c2p_page.Take bank transfer QR code screenshot

Enter a valid zipcode and its corresponding subdistricts should be displayed automatically _ MAKNET-6024
    [Tags]  MAKNET-6024  priority_critical  must_pass  sanity   smoke  android  ios
    [Documentation]     Verify when enter zipcode, all subd istrict on app display same like db data
    [Setup]      mobile_common.Open application
    onboarding_feature.Skip onboarding process if exist
    home_page.Verify provide your zip code popup is display
    homepage_feature.Verify all sub district from its zipcode display correct    ${multistore_data['samaedam_zipcode']}
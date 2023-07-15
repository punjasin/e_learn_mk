*** Settings ***
Force Tags       search   filter    Regression
Resource        ../../common/mobile/mobile_common.resource
Resource        ../../common/api/api_common.resource

Suite Setup         mobile_common.Mango Suite Setup
Test Setup          mobile_common.Mango Test Setup
Test Teardown       mobile_common.Mango Test Teardown

*** Test Cases ***
User able to view all product from searching _ MAKNET-2903
    [Tags]  MAKNET-2903  priority_high  sanity  smoke  android  ios  search
    [Documentation]     Verify after search and tap "view all" button, the products should display all
    search_advance_page.Typing search       ${search_api['payload']['search_api_payload_suggestions']['q']}
    ${dynamic_productinfo1}    search_api_feature.Post search info dynamic data    ${search_api['payload']['search_api_payload_suggestions']}
    search_advance_page.Search suggestion should display product suggestion and search total       ${dynamic_productinfo1['total_found']}
    search_advance_page.Click view all button
    search_advance_page.Search total should be equal    ${dynamic_productinfo1['total_found']}
    product_page.Verify target product is visible       ${dynamic_productinfo1['productname']}

User able to sort search result by sort type _ MAKNET-1062 MAKNET-2904 MAKNET-1064 MAKNET-1065 MAKNET-1066
    [Tags]  MAKNET-1062    MAKNET-2904    MAKNET-1064    MAKNET-1065    MAKNET-1066  priority_high  sanity  smoke  android  ios  search
    [Documentation]   MAKNET-2904    User able to sort search result by price low to high
    ...    MAKNET-1062    User able to sort search result by relevant
    ...    MAKNET-1064    User able to sort search result by price high to low
    ...    MAKNET-1065    User able to sort search result by promotion
    ...    MAKNET-1066    User able to sort search result by newest
    search_feature.Sort search result by    ${sort_type['relevant']}    ${searching['keyword_relate_lower']}       ${searching['keyword_relate_th']}
    search_feature.Sort search result by    ${sort_type['price_low_to_high']}      ${searching['keyword_relate_lower']}
    search_feature.Sort search result by    ${sort_type['price_high_to_low']}      ${searching['keyword_relate_lower']}
    search_feature.Sort search result by    ${sort_type['promotion']}              ${product_data['product16']}
    search_feature.Sort search result by    ${sort_type['newest']}                 ${searching['keyword_relate_lower']}

User able to filter search results by many filter type _ MAKNET-2905 MAKNET-2906
    [Tags]  MAKNET-2905  MAKNET-2906  priority_critical  must_pass  sanity  smoke  android  ios  search
    [Documentation]     Verify the search result display product correctly according to all filter type
    ...         Verify user able to clear all filter, the total applied filter is displayed correct and the total result found changed when used filter
    ...    
    search_page.Search for product with searchbar    ${searching['keyword_product_4']}
    search_feature.Filter product all filter types  ${mobile_additional['filter_type']['price']}        subtype_1=${filter_sub_type['range_price_2']}
    search_feature.Verify price after filter price
    search_feature.Filter product all filter types  ${mobile_additional['filter_type']['category']}     subtype_1=${filter_sub_type['category_2']}    subtype_2=${filter_sub_type['category_3']}
    ${dynamic_product_by_category}    search_api_feature.Post search info dynamic data    ${search_api['payload']['search_api_payload_soda_category']}
    search_feature.Verify product after filter category    ${dynamic_product_by_category['productname']}
    search_feature.Filter product all filter types  ${mobile_additional['filter_type']['available']}    subtype_1=${mobile['search']['label']['inStockOnly']}
    search_feature.Verify product after filter in stock only
    search_feature.Filter product all filter types  ${mobile_additional['filter_type']['brand']}        subtype_1=${filter_sub_type['brand_4']}       subtype_2=${filter_sub_type['brand_5']}
    search_feature.Verify product after filter brand    subtype_1=${result_brand['brand_4']}       subtype_2=${result_brand['brand_5']}
    search_feature.Filter product all filter types  ${mobile_additional['filter_type']['promotion']}    subtype_1=${mobile['search']['label']['flatDiscount']}
    search_feature.Verify search result sort type promotion

Verify search from homepage and search with keyword _ MAKNET-2893
    [Tags]  MAKNET-2893  priority_critical  must_pass  sanity  smoke  android  ios  search
    [Documentation]     Verify the search result display product correctly by search all keyword type
    ${dynamic_productinfo_1}    search_api_feature.Post search info dynamic data    ${search_api['payload']['search_api_product_name']}
    ${dynamic_productinfo_2}    search_api_feature.Post search info dynamic data    ${search_api['payload']['search_api_synonym']}
    ${dynamic_productinfo_3}    search_api_feature.Post search info dynamic data    ${search_api['payload']['search_api_collection_name']}
    ${dynamic_productinfo_4}    search_api_feature.Post search info dynamic data    ${search_api['payload']['search_api_curation']}
    ${dynamic_productinfo_5}    search_api_feature.Post search info dynamic data    ${search_api['payload']['search_api_sku']}
    search_feature.Search product and verify search result    ${searching['keyword_product_name']}    ${dynamic_productinfo_1['productname']}
    search_feature.Search product and verify search result    ${dynamic_productinfo_1['makroId']}    ${dynamic_productinfo_1['productname']}
    search_feature.Search product and verify search result    ${dynamic_productinfo_1['brand']}    ${dynamic_productinfo_1['productname']}
    search_feature.Search product and verify search result    ${searching['keyword_collection_name']}    ${dynamic_productinfo_3['productname']}
    search_feature.Search product and verify search result    ${searching['keyword_synonym']}    ${dynamic_productinfo_2['productname']}
    search_feature.Search product and verify search result    ${searching['keyword_curation']}    ${dynamic_productinfo_4['productname']}
    search_feature.Search product and verify search result    ${dynamic_productinfo_5['sku']}    ${dynamic_productinfo_5['productname']}

Verify the slab price 2 and add to cart icon _ MAKNET-5983
    [Tags]  MAKNET-5983  priority_critical  must_pass  sanity  smoke  android  ios
    [Documentation]     Verify the slab price 2 and add to cart icon (+) is displayed in slab price search product list
    login_feature.User login from my favourite list         ${user['userforLogin_data']['email']}  ${user['userforLogin_data']['password']}
    mobile_common.Tap shopping menu
    search_feature.Search product and verify search result    ${searching['slab_price_TH_EN_keyword']}    ${searching['slab_price_TH_EN_product']}
    product_page.Verify product show slab price at PLP   ${mobile_additional['slab_price']['lbl_info2']}
    productcard_page.Click add to basket at product card    ${searching['slab_price_TH_EN_product']}
    productcard_page.Verify product display all slab prices type   ${mobile_additional['slab_price']['lbl_info1']}   ${mobile_additional['slab_price']['lbl_info2']}   ${mobile_additional['slab_price']['lbl_info3']}
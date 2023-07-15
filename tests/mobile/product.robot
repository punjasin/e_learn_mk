*** Settings ***
Force Tags       product    regression
Resource        ../../common/mobile/mobile_common.resource
Resource        ../../common/api/api_common.resource

Suite Setup         mobile_common.Mango Suite Setup
Test Setup          mobile_common.Mango Test Setup 
Test Teardown       mobile_common.Mango Test Teardown   

*** Test Cases ***
PLP & Search on area that support only 1 P : found active product 1P + FBM _ MAKNET-3271
    [Tags]  MAKNET-3271   priority_high  sanity   smoke  android  ios    product
    [Documentation]     PLP & Search on area that support only 1 P : found active product  1P +  FBM
    [Setup]      mobile_common.Mango Test Setup     ${multistore_data['store8_zipcode']}        ${multistore_data['store8_subdistrict']['${lang}']} 
    
    ${product_1p}       search_api_feature.Post search info dynamic data    ${search_api['payload']['search_api_product_1P']}
    ${product_3p_FBM}   search_api_feature.Post search info dynamic data    ${search_api['payload']['search_api_product_3P_fbm']}
    ${product_3p_SOD}   search_api_feature.Post search info dynamic data    ${search_api['payload']['search_api_product_3P_sod']}

    ${product1p_name}       mobile_common.Set product name from api data               ${product_1p}
    ${product3p_fbm_name}   mobile_common.Set product name from api data               ${product_3p_FBM}
    ${product3p_sod_name}   mobile_common.Set product name from api data               ${product_3p_SOD}
    
    debug_page.Open search localization via debug menu
    search_feature.Go to PLP of product                     ${mobile_additional['main_category']['regressionGroup']}     ${mobile_additional['sub_category']['3pOwn']}        ${product3p_fbm_name}
    search_page.Verify product show on search result page        ${product1p_name}
    product_page.Verify product out of delivery area             ${product3p_sod_name}
    mobile_common.Tap shopping menu
    home_page.Tap see all category      ${mobile_additional['main_category']['storeExtension']}
    search_page.Verify product show on search result page        ${product1p_name}
    search_page.Verify product show on search result page        ${product3p_fbm_name}
    product_page.Verify product out of delivery area             ${product3p_sod_name}   
    search_feature.Search product and verify search result  ${product1p_name}  ${product1p_name}
    search_feature.Search product and verify search result  ${product3p_fbm_name}  ${product3p_fbm_name}
    search_feature.Search product and verify product out of delivery  ${product3p_sod_name}  ${product3p_sod_name}

PLP & Search on area that support all : found active product 1P + SOD + FBM _ MAKNET-3273
    [Tags]  MAKNET-3273  priority_high  sanity   smoke  android  ios    product
    [Documentation]     PLP & Search on area that support all : found active product 1P + SOD + FBM
    ${product_1p}       search_api_feature.Post search info dynamic data    ${search_api['payload']['search_api_product_1P']}
    ${product_3p_FBM}   search_api_feature.Post search info dynamic data    ${search_api['payload']['search_api_product_3P_fbm']}
    ${product_3p_SOD}   search_api_feature.Post search info dynamic data    ${search_api['payload']['search_api_product_3P_sod']}
    ${product_3p_OOD}   search_api_feature.Post search info dynamic data    ${search_api['payload']['search_api_product_3P_ood']}

    ${product1p_name}       mobile_common.Set product name from api data               ${product_1p}
    ${product3p_fbm_name}   mobile_common.Set product name from api data               ${product_3p_FBM}
    ${product3p_sod_name}   mobile_common.Set product name from api data               ${product_3p_SOD}
    ${product3p_ood_name}   mobile_common.Set product name from api data               ${product_3p_OOD}
    
    debug_page.Open search localization via debug menu
    search_feature.Go to PLP of product                     ${mobile_additional['main_category']['regressionGroup']}     ${mobile_additional['sub_category']['3pOwn']}        ${product1p_name}
    search_page.Verify product show on search result page        ${product3p_fbm_name}
    search_page.Verify product show on search result page        ${product3p_sod_name}
    product_page.Verify product out of delivery area             ${product3p_ood_name}
    mobile_common.Tap shopping menu
    home_page.Tap see all category      ${mobile_additional['main_category']['storeExtension']}
    search_page.Verify product show on search result page        ${product1p_name}
    search_page.Verify product show on search result page        ${product3p_fbm_name}
    search_page.Verify product show on search result page        ${product3p_sod_name}
    product_page.Verify product out of delivery area             ${product3p_ood_name}    
    search_feature.Search product and verify search result  ${product1p_name}  ${product1p_name}
    search_feature.Search product and verify search result  ${product3p_fbm_name}  ${product3p_fbm_name}
    search_feature.Search product and verify search result  ${product3p_sod_name}  ${product3p_sod_name}
    search_feature.Search product and verify product out of delivery  ${product3p_ood_name}  ${product3p_ood_name}
*** Settings ***
Resource            ../pages/search_makroproweb_page.resource
Resource            ../../api/search_api_feature.resource
Resource            ../../../common/web/web_common.resource

*** Keywords ***
Verify search result display correct after click on recommend keyword
    ${search_recommend}     search_makroproweb_page.Get search recommend keyword
    search_makroproweb_page.Click on search recommendation
    search_makroproweb_page.Verify search result display search keyword correct  ${search_recommend}

Search with dynamic data
    [Arguments]    ${search_api}        ${index}=0
    ${dynamic_productinfo}    search_api_feature.Post search info dynamic data    ${search_api}     ${index}
    ${dynamic_productinfo}    web_common.Set product name from api data    ${dynamic_productinfo}
    ${dynamic_productinfo}    web_common.Set seller name from api data     ${dynamic_productinfo}
    search_makroproweb_page.Input search keyword    ${dynamic_productinfo['productname']}
    [Return]          ${dynamic_productinfo} 

Search product and navigate to product detail page
    [Arguments]    ${productname}  
    search_makroproweb_page.Input search keyword     ${productname}
    SeleniumLibrary.Press keys      none      ENTER
    productlist_makroproweb_page.Click on product name  ${productname}

Search product and navigate to product list page
    [Arguments]    ${productname}  
    search_makroproweb_page.Input search keyword     ${productname}
    SeleniumLibrary.Press keys      none      ENTER


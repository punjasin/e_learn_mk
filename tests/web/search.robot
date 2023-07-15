*** Settings ***
Resource            ../../common/web/web_common.resource

Variables           ../../resources/data/common.yaml

Test Setup          web_common.Makro pro web setup
Test Teardown       web_common.Close browser

*** Test Cases ***
User able to view search results by click search prediction _ MAKNET-4037
    [Tags]      MAKNET-4037     web      priority_high
    [Documentation]     Verify all predict suggestion display only keyword relate to search topic and verify search result
    search_makroproweb_page.Input search keyword        ${MAKNET_4037_data['search_keyword']}
    search_makroproweb_page.Verify search topic highlight on all recommend keywords  ${MAKNET_4037_data['search_keyword']}
    search_makroproweb_feature.Verify search result display correct after click on recommend keyword

User able to sort search result by price low to high _ MAKNET-4041
    [Tags]      MAKNET-4041     web     priority_high
    [Documentation]     Verify all product sort by price low to high
    home_makroproweb_feature.Navigate to sub category page  ${web_additional['mainCategory']['fruiteVeggies']}  ${web_additional['subCategory']['fruiteVeggies']}
    productlist_makroproweb_feature.Select sort by              ${web['search']['priceLowToHigh']}
    productlist_makroproweb_page.Verify sort by price low to high correct

User able to filter search results by many filter type _ MAKNET-4042
    [Tags]      MAKNET-4042     web     priority_high
    [Documentation]     Verify product display correct after filter
    home_makroproweb_feature.Navigate to sub category page  ${web_additional['mainCategory']['kitchenSupplies']}  ${web_additional['subCategory']['containers']}
    productlist_makroproweb_feature.Verify products are filtered by price range correctly
    productlist_makroproweb_feature.Verify products filtered by discount products
    productlist_makroproweb_feature.Verify products are filtered by brand   ${MAKNET_4042_data['product_brand']}
    productlist_makroproweb_feature.Verify only avilable products are filtered
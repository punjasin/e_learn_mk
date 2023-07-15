*** Settings ***
Resource            ../pages/home_makroproweb_page.resource
Resource            ../pages/search_makroproweb_page.resource
Resource            ../pages/basket_makroproweb_page.resource
Resource            ../pages/productlist_makroproweb_page.resource
Resource            ../../database/zipcode_db_page.resource

*** Keywords ***
Enter zip code when open new session
    [Arguments]     ${zipcode}=${multistore_data['samaedam_zipcode']}     ${subdistrict}=${multistore_data['samaedam_subdistrict']['${lang}']} 
    home_makroproweb_page.Verify provide your zip code & sub district title display
    home_makroproweb_page.Input zipcode  ${zipcode}
    home_makroproweb_page.Select subdistrict    ${subdistrict}
    home_makroproweb_page.Click save zipcode
    home_makroproweb_page.Verify selected zipcode display on header  ${zipcode}

Verify error when input out of area zipcode makro
    [Arguments]     ${out_of_area_zipcode}
    home_makroproweb_page.Input zipcode      ${out_of_area_zipcode}
    home_makroproweb_page.Verify zipcode is outside of MakroPRO delivery area error display
    home_makroproweb_page.Verify save button is disabled

Verify item in cart when click add to basket
    [Arguments]    ${product_name}      ${expect}
    home_makroproweb_page.Verify cart label    ${expect}
    home_makroproweb_page.Click cart icon
    basket_makroproweb_page.Verify qty amount display as expected value    ${product_name}      ${expect}

Verify all sub district from its zipcode display correct
    [Arguments]     ${zipcode}
    home_makroproweb_page.Input zipcode          ${zipcode}
    ${sub_district_db_data}    zipcode_db_page.Get all sub district by zipcode     ${zipcode}       ${makropro_db['catalog_data_service']}
    ${sub_district_web_data}   home_makroproweb_page.Get all sub district
    Collections.Lists should be equal       ${sub_district_web_data}    ${sub_district_db_data}     ignore_order=${True}

Verify banner redirect to youtube channel
    home_makroproweb_page.Click on makro logo
    home_makroproweb_page.Find target banner                ${web_additional['banner']['bannerYoutube']}
    web_common.Switch to last tab
    home_makroproweb_page.Verify youtube display
    web_common.Switch back to first tab 

Verify banner redirect to information page
    home_makroproweb_page.Click on makro logo
    home_makroproweb_page.Find target banner                ${web_additional['banner']['bannerInfo']}
    home_makroproweb_page.Verify information page display

Verify banner redirect to product page
    [Arguments]     ${product_name}
    home_makroproweb_page.Click on makro logo
    home_makroproweb_page.Find target banner                ${web_additional['banner']['bannerNescafe']}
    productlist_makroproweb_page.Verify product header display  ${product_name}

Verify banner redirect to product list page
    home_makroproweb_page.Click on makro logo
    home_makroproweb_page.Find target banner                ${web_additional['banner']['bannerCollection']}
    productlist_makroproweb_page.Verify product list title display

Navigate to sub category page
    [Arguments]     ${main_category}        ${sub_category}
    home_makroproweb_page.Click categories menu
    home_makroproweb_page.Select main categories        ${main_category}
    home_makroproweb_page.Select sub category           ${main_category}   ${sub_category}
    productlist_makroproweb_page.Verify product header display   ${sub_category}
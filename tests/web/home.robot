*** Settings ***
Resource            ../../keywords/database/zipcode_db_page.resource

Resource            ../../common/web/web_common.resource
Resource            ../../common/database/db_common.resource

Test Setup          web_common.Open makro pro web
Test Teardown       web_common.Close browser

*** Test Cases ***
Verify non-support zipcode makro area error display _ MAKNET-3672
    [Tags]      MAKNET-3672     web     priority_medium
    [Documentation]     Verify non-support zipcode displays error message "This zipcode is outside of MakroPro delivery area"
    home_makroproweb_page.Verify provide your zip code & sub district title display
    home_makroproweb_feature.Verify error when input out of area zipcode makro  ${default['ood_zipcode']}

Verify when enter a valid zipcode and its corresponding subdistricts should be displayed automatically _ MAKNET-3669
    [Tags]      MAKNET-3669     web     priority_medium
    [Documentation]     Verify when enter zipcode, all subdistrict display same like db data
    home_makroproweb_page.Verify provide your zip code & sub district title display
    home_makroproweb_feature.Verify all sub district from its zipcode display correct  ${multistore_data['samaedam_zipcode']}

Verify redirect page after user click on banner _ MAKNET-3859
    [Tags]      MAKNET-3859     web     priority_high
    [Documentation]     Verify banner redirect to the correct page
    [Setup]     web_common.Makro pro web setup
    home_makroproweb_feature.Verify banner redirect to product list page
    home_makroproweb_feature.Verify banner redirect to product page      ${MAKNET_3859_data['product_name']}
    home_makroproweb_feature.Verify banner redirect to information page
    home_makroproweb_feature.Verify banner redirect to youtube channel
*** Settings ***
Resource        ../../common/api/api_common.resource
Resource        ../database/zipcode_db_page.resource
Resource        search_api_feature.resource

*** Keywords ***
Get product 1P price
    [Arguments]     ${makro_id}    ${zipcode}=${multistore_data['samaedam_zipcode']}     ${subdistrict}=${multistore_data['samaedam_subdistrict']['${lang}']} 
    ${template_path}          Set Variable    ${file_path['rm3_price_v1']}
    ${file_data}              api_common.Update json variable     ${template_path}    $..articles[0]      ${makro_id}
    RequestsLibrary.Create session            Post session           ${ROOT_URL['RM3']}
    ${headers}                Create dictionary     Content-Type=application/json
    ${file_data}              OperatingSystem.Get binary file        ${CURDIR}/../../resources/data/json_template/${template_path}
    ${response}               RequestsLibrary.Post on session        Post session    url=${url_price}       data=${file_data}    headers=${headers}    expected_status=200
    ${product_price}          JSONLibrary.Get value from json        ${response.json()}      $.Art[0].priceInVat
    ${product_price}          Convert to string           @{product_price}
    ${product_price}          Evaluate              "{:.2f}".format(${product_price})
    [Return]                  ${product_price}
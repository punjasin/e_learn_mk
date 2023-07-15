*** Settings ***
Resource        ../../common/api/api_common.resource
Resource        shopify_api.resource

*** Keywords ***
Call Mirakl API to accept order
    [Arguments]     ${id}      ${suborder}=A      ${lineitem}=1
    ${orderid}=     Set Variable    Order_${id}-${suborder}

    ${headers}       Create Dictionary    Authorization=e0348fae-48c7-40c2-950e-780e6239c3f1    Accept=application/json     

    ${entry 1}=    Create Dictionary    accepted=true    id=${orderid}-${lineitem}
    ${order_lines}=    Create list     ${entry 1}
    &{data}=    Create Dictionary    order_lines=${order_lines}

    RequestsLibrary.Create session      adminSession    https://siammakroth1-preprod.mirakl.net
    ${get_resp}=        PUT On Session     adminSession     url=/api/orders/${orderid}/accept   headers=${headers}    json=&{data}      expected_status=204

Get user lastest order and accept with suborder and line items
    [Arguments]     ${email}     ${suborder}=A      ${lineitem}=1
    ${order}        shopify_api.Call shopify API and get lastest order  ${email}
    mirakl_api.Call Mirakl API to accept order      ${order}    ${suborder}       ${lineitem}

Update quantity product 3P
    [Arguments]      ${product_detail}
    IF  "${product_detail['discount_price']}" != "${empty}"
        ${template_path}=   Set Variable    ${file_path['mirakl_3P_offer_discount']}
        ${file_data}=       api_common.Update json variable     ${template_path}    $.offers[0].discount.price        ${product_detail['discount_price']}
    ELSE
        ${template_path}=   Set Variable    ${file_path['mirakl_3P_offer_nondiscount']}
    END

    ${file_data}=       api_common.Update json variable     ${template_path}    $.offers[0].quantity        ${product_detail['quantity']}
    ${file_data}=       api_common.Update json variable     ${template_path}    $.offers[0].product_id      ${product_detail['sku']}
    ${file_data}=       api_common.Update json variable     ${template_path}    $.offers[0].shop_sku        ${product_detail['shop_sku']}
    ${file_data}=       api_common.Update json variable     ${template_path}    $.offers[0].price           ${product_detail['original_price']}

    RequestsLibrary.Create session      Post session        ${ROOT_URL['Mirakl']}
    ${headers}       Create dictionary      Authorization=${ROOT_URL['Mirakl_seller_token']}    Content-Type=application/json
    ${file_data}     OperatingSystem.Get binary file        ${CURDIR}/../../resources/data/json_template/${template_path}
    ${response}      RequestsLibrary.Post on session        Post session        url=/api/offers?shop_id=${product_detail['shop_id']}        data=${file_data}       headers=${headers}    expected_status=201
    ${import_id}	 JSONLibrary.Get value from json           ${response.json()}      $..import_id
    mirakl_api.Verify offer status import successfully         @{import_id}    ${product_detail['shop_id']}

Verify offer status import successfully
    [Arguments]     ${import_id}    ${shop_id}
    RequestsLibrary.Create session      Get session        ${ROOT_URL['Mirakl']}
    ${headers}       Create dictionary      Authorization=${ROOT_URL['Mirakl_seller_token']}    Content-Type=application/json
    ${response}      RequestsLibrary.Get on session      Get session    url=/api/offers/imports/${import_id}?shop_id=${shop_id}     headers=${headers}       expected_status=200
    ${import_status}	 JSONLibrary.Get value from json        ${response.json()}      $..has_error_report
    Should not be true   @{import_status}

Update product detail for synchonization status
    [Arguments]     ${product_detail}
    ${template_path}=   Set Variable    ${file_path['synchronization_mirakl']}
    ${file_data}=       JSONLibrary.Load json from file             ${CURDIR}/../../resources/data/json_template/${template_path}
    ${file_data}=       JSONLibrary.Update value to json     ${file_data}    $..data.category          ${product_detail['category']}
    ${file_data}=       JSONLibrary.Update value to json     ${file_data}    $..data.makro_id          ${product_detail['makro_id']}
    ${file_data}=       JSONLibrary.Update value to json     ${file_data}    $..data.brand_name        ${product_detail['brand_name']}
    ${file_data}=       JSONLibrary.Update value to json     ${file_data}    $..data.unit_depth        ${product_detail['unit_depth']}
    ${file_data}=       JSONLibrary.Update value to json     ${file_data}    $..data.unit_width        ${product_detail['unit_width']}
    ${file_data}=       JSONLibrary.Update value to json     ${file_data}    $..data.unit_amount       ${product_detail['unit_amount']}
    ${file_data}=       JSONLibrary.Update value to json     ${file_data}    $..data.unit_height       ${product_detail['unit_height']}
    ${file_data}=       JSONLibrary.Update value to json     ${file_data}    $..data.product_name      ${product_detail['product_name']}
    ${file_data}=       JSONLibrary.Update value to json     ${file_data}    $..data.brand_name_th     ${product_detail['brand_name_th']}
    ${file_data}=       JSONLibrary.Update value to json     ${file_data}    $..data.packaging_depth      ${product_detail['packaging_depth']}
    ${file_data}=       JSONLibrary.Update value to json     ${file_data}    $..data.packaging_width      ${product_detail['packaging_width']}
    ${file_data}=       JSONLibrary.Update value to json     ${file_data}    $..data.product_name_th      ${product_detail['product_name_th']}
    ${file_data}=       JSONLibrary.Update value to json     ${file_data}    $..data.packaging_height     ${product_detail['packaging_height']}
    ${file_data}=       JSONLibrary.Update value to json     ${file_data}    $..data.packaging_weight     ${product_detail['packaging_weight']}
    ${file_data}=       JSONLibrary.Update value to json     ${file_data}    $..data.short_description    ${product_detail['short_description']}
    ${file_data}=       JSONLibrary.Update value to json     ${file_data}    $..data.unit_amount_classification    ${product_detail['unit_amount_classification']}
    ${file_data}=       JSONLibrary.Update value to json     ${file_data}    $..mirakl_product_id        ${product_detail['mirakl_product_id']}
    ${file_data}=       JSONLibrary.Update value to json     ${file_data}    $..product_sku              ${product_detail['sku']}
    
    RequestsLibrary.Create session      Post session        ${ROOT_URL['Mirakl']}
    ${headers}       Create dictionary      Authorization=${ROOT_URL['Mirakl_operator_token']}    Content-Type=application/json
    ${file_data}     OperatingSystem.Get binary file        ${CURDIR}/../../resources/data/json_template/${template_path}
    ${response}      RequestsLibrary.Post on session        Post session        url=/api/mcm/products/synchronization        data=${file_data}       headers=${headers}    expected_status=200
    ${tracking_id}	 JSONLibrary.Get value from json        ${response.json()}      $..tracking_id
    Wait until keyword succeeds  2x   10s    mirakl_api.Verify tracking id synchronization complete    @{tracking_id}
    
Verify tracking id synchronization complete
    [Arguments]     ${tracking_id}
    RequestsLibrary.Create session      Get session        ${ROOT_URL['Mirakl']}
    ${headers}       Create dictionary      Authorization=${ROOT_URL['Mirakl_operator_token']}    Content-Type=application/json
    ${response}          RequestsLibrary.Get on session      Get session    url=/api/mcm/products/synchronization/${tracking_id}     headers=${headers}       expected_status=200
    ${report_status}	 JSONLibrary.Get value from json        ${response.json()}      $..has_report
    Should be true       @{report_status}
    ${complete_status}    JSONLibrary.Get value from json       ${response.json()}      $..status
    Should be equal      @{complete_status}    COMPLETE
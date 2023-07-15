*** Settings ***
Resource        ../../common/api/api_common.resource
Resource        ../mobile/features/kyc_feature.resource

*** Keywords ***
Call shopify API and delete registered account
    [Arguments]     ${shopifyemail}
    RequestsLibrary.Create session      adminSession    https://${shopify_api['key']}:${shopify_api['password']}@mango-store-qa.myshopify.com
    ${get_resp}=        RequestsLibrary.Get on session     adminSession     url=/admin/api/2021-10/customers/search.json?query=${shopifyemail}      expected_status=200
    ${id}=              Set Variable    ${get_resp.json()['customers'][0]['id']}
    RequestsLibrary.Delete on session        adminSession     url=/admin/api/2021-10/customers/${id}.json      expected_status=200

Call shopify API and get lastest order
    [Arguments]     ${shopifyemail}
    RequestsLibrary.Create session      adminSession    https://${shopify_api['key']}:${shopify_api['password']}@mango-store-qa.myshopify.com
    ${get_resp}=        RequestsLibrary.Get on session     adminSession     url=/admin/api/2021-10/customers/search.json?query=${shopifyemail}      expected_status=200
	${id}=		        Get value from json	    ${get_resp.json()}      $.customers[?(@.email=="${shopifyemail}")].id
	${order}=           RequestsLibrary.Get on session		adminSession     url=/admin/api/2021-10/customers/${id[0]}/orders.json      expected_status=200
	${order_id}=		Set Variable	${order.json()['orders'][0]['order_number']}	#Most recent non-cancel order
    [return]  ${order_id}

Call shopify API and get order id by email
    [Arguments]     ${shopifyemail}
    RequestsLibrary.Create session      adminSession    https://${shopify_api['key']}:${shopify_api['password']}@mango-store-qa.myshopify.com
    ${get_resp}=        RequestsLibrary.Get on session     adminSession     url=/admin/api/2021-10/customers/search.json?query=${shopifyemail}      expected_status=200
	${id}=		        Get value from json	    ${get_resp.json()}      $.customers[?(@.email=="${shopifyemail}")].id
	${order}=           RequestsLibrary.Get on session		adminSession     url=/admin/api/2021-10/customers/${id[0]}/orders.json      expected_status=200
	${order_id}=		Set Variable	${order.json()['orders'][0]['id']}	#Most recent non-cancel order
    [return]  ${order_id}

Call shopify API to get customer id by email
    [Arguments]     ${email}
    RequestsLibrary.Create session      getSession    ${ROOT_URL['Shopify']}
    ${headers}       Create Dictionary    X-Shopify-Access-Token=${ROOT_URL['Shopify_token']}   Content-Type=application/json
    ${response}=     RequestsLibrary.Get on session        getSession        url=/api/2022-07/customers.json       headers=${headers}        expected_status=200

    FOR     ${i}        IN RANGE    5
        ${customer_email}		Set Variable	${response.json()['customers'][${i}]['email']}
        ${status}       Run keyword and return status       Should be equal     ${customer_email}       ${email}
        IF  ${status}
            ${customer_id}=		Set Variable	${response.json()['customers'][${i}]['id']}
        END
        Exit for loop if        ${status}
    END

    [Return]        ${customer_id}

Call shopify API to get customer detail by customer id
    [Arguments]     ${customer_id}
    RequestsLibrary.Create session      getSession    ${ROOT_URL['Shopify']}
    ${headers}       Create Dictionary    X-Shopify-Access-Token=${ROOT_URL['Shopify_token']}   Content-Type=application/json
    ${response}=     RequestsLibrary.Get on session        getSession        url=/api/2022-07/customers/${customer_id}.json       headers=${headers}        expected_status=200
    [Return]        ${response.json()}

Call shopify API to verify customer business type by user email
    [Arguments]     ${email}        ${business_type}
    ${customer_id}       Call shopify API to get customer id by email        ${email}
    ${response}     Call shopify API to get customer detail by customer id      ${customer_id}
    kyc_feature.Verify customer business type should be     ${response['customer']['tags']}     ${business_type}

Call shopify API to update product quantity
    [Arguments]     ${inventory_id}     ${quantity}=${amount_quantity['add_quantity']}     
    ${file_data}=       api_common.Update json variable     ${file_path['shopify_3p_product']}    $.available    ${quantity}
    ${file_data}=       api_common.Update json variable     ${file_path['shopify_3p_product']}    $.inventory_item_id    ${inventory_id}

    RequestsLibrary.Create session      postSession    ${ROOT_URL['Shopify']}
    ${headers}       Create Dictionary    X-Shopify-Access-Token=${ROOT_URL['Shopify_token']}   Content-Type=application/json
    ${file_data}=    OperatingSystem.Get binary file        ${CURDIR}/../../../resources/json_template${file_path['shopify_3p_product']}

    ${response}=     RequestsLibrary.Post on session        postSession        url=/api/2021-10/inventory_levels/set.json        data=${file_data}       headers=${headers}

Call shopify API to update product status
    [Arguments]     ${inventory_id}     ${status}=${multistore_data['draft_product_value']}
    ${file_data}=       api_common.Update json variable     ${file_path['product_status_shopify']}    $.product.id   ${inventory_id}
    ${file_data}=       api_common.Update json variable     ${file_path['product_status_shopify']}    $.product.status    ${status}

    RequestsLibrary.Create session      putSession    ${ROOT_URL['Shopify']}
    ${headers}       Create Dictionary    X-Shopify-Access-Token=${ROOT_URL['Shopify_token']}   Content-Type=application/json

    ${file_data}=    OperatingSystem.Get binary file        ${CURDIR}/../../../resources/json_template${file_path['product_status_shopify']}
    ${response}=     PUT On Session        putSession        url=/api/2022-07/products/${inventory_id}.json        data=${file_data}       headers=${headers}       expected_status=200
    ${resp.body}     Set Variable           ${response.json()['product']['status']}

    Should be equal     ${status}        ${resp.body}

Call shopify API add product to collection
    [Arguments]     ${product_id}       ${collection_id}
    ${file_data}=       api_common.Update json variable     ${file_path['collection_product']}    $.collect.product_id      ${product_id}
    ${file_data}=       api_common.Update json variable     ${file_path['collection_product']}    $.collect.collection_id    ${collection_id}

    RequestsLibrary.Create session      postSession    ${ROOT_URL['Shopify']}
    ${headers}       Create Dictionary    X-Shopify-Access-Token=${ROOT_URL['Shopify_token']}   Content-Type=application/json
    ${file_data}=    OperatingSystem.Get binary file        ${CURDIR}/../../../resources/json_template${file_path['collection_product']}
    ${response}=     RequestsLibrary.Post on session        postSession        url=/api/2021-10/collects.json       data=${file_data}       headers=${headers}      expected_status=201
    ${resp.body}     Set Variable           ${response.json()['collect']['id']}
    [Return]        ${resp.body}

Call shopify API delete product from collection
    [Documentation]     Get ID get from "Add product to collection API"
    [Arguments]     ${id}
    RequestsLibrary.Create session      deleteSession    ${ROOT_URL['Shopify']}
    ${headers}       Create Dictionary    X-Shopify-Access-Token=${ROOT_URL['Shopify_token']}
    ${response}=     RequestsLibrary.Delete on session        deleteSession        url=/api/2021-10/collects/${id}.json       headers=${headers}        expected_status=200

Call shopify API delete product from collection via graphql
    [Arguments]     ${json_file}=${file_path['delete_product_graphql']}
    ${response}     api_common.Call graphql shopify API     ${json_file}
    ${user_error}=		Set Variable	${response.json()['data']['collectionRemoveProducts']['userErrors']}
    Should be empty     ${user_error}

Call shopify API verify store code by order id using customer email
    [Arguments]     ${shopifyemail}     ${store_code_expected}
    ${order_id}     Call shopify API and get order id by email  ${shopifyemail}

    RequestsLibrary.Create session      getSession    ${ROOT_URL['Shopify']}

    ${headers}       Create Dictionary    X-Shopify-Access-Token=${ROOT_URL['Shopify_token']}   Content-Type=application/json
    ${response}=     RequestsLibrary.Get on session        getSession        url=/api/2022-07/orders/${order_id}.json       headers=${headers}        expected_status=200
    ${store_code}=		Set Variable	${response.json()['order']['line_items'][0]['properties'][0]['value']}
    ${store_code_str}       Convert to string       ${store_code_expected}

    Should be equal     ${store_code_str}     ${store_code}

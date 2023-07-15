*** Settings ***
Resource        ../../common/api/api_common.resource

*** Keywords ***      
Call medusa api
    [Arguments]    ${data_value}    ${endpoint}    ${data_column}
    Create Session      medusaSession    ${medusa_api['url']}
    ${headers}     Create dictionary       Authorization=Bearer ${medusa_api['access_token']}
    ${params}      Create dictionary       ${data_column}=${data_value}
    ${get_resp}=        GET On Session      medusaSession     ${endpoint}   params=${params}    headers=${headers}
    [RETURN]        ${get_resp}

Get customer id from medusa api
    [Arguments]     ${data_value}    ${endpoint}=${medusa_api['endpoint_customers']}    ${data_column}=${medusa_api['column_q']}
    ${get_resp}=        medusa_api.Call medusa api    ${data_value}    ${endpoint}    ${data_column}
    ${data_id}    JSONLibrary.Get value from json    ${get_resp.json()}        $.customers..id
    [Return]        ${data_id}[0]

Get latest order from medusa api
    [Arguments]     ${email}    ${endpoint}=${medusa_api['endpoint_orders']}    ${data_column}=${medusa_api['column_customer_id']}
    ${data_id}=      medusa_api.Get customer id from medusa api     ${email}
    ${get_resp}=        medusa_api.Call medusa api    ${data_id}    ${endpoint}    ${data_column}
    ${order_id}    JSONLibrary.Get value from json    ${get_resp.json()}        $.orders[0]..display_id
    [Return]        ${order_id}[0]

Get lastest store code from medusa api
    [Arguments]     ${email}    ${endpoint}=${medusa_api['endpoint_orders']}    ${data_column}=${medusa_api['column_customer_id']}
    ${data_id}=      medusa_api.Get customer id from medusa api     ${email}
    ${get_resp}=        medusa_api.Call medusa api    ${data_id}    ${endpoint}    ${data_column}
    ${store_code}    JSONLibrary.Get value from json    ${get_resp.json()}        $.orders[0].metadata.stores[0].storeCode
    ${current_store_code}=       Convert to integer      ${store_code}[0]
    [Return]        ${current_store_code}

Verify store code should be default
    [Arguments]     ${store_code}
    ${store_code}             Convert to string   ${store_code}
    Should be equal           ${store_code}      ${store_code['st4']}['store_code']}

Login to medusa as admin
    Create Session      medusaSession    ${medusa_api['url']}
    ${file_data}             JSONLibrary.Load json from file             ${CURDIR}/../../resources/data/json_template${file_path['medusa_admin_account']}
    ${response}=     RequestsLibrary.Post on session        medusaSession        ${medusa_api['endpoint_admin']}       json=${file_data}    expected_status=200

Get order details from medusa api via email and order status
    [Documentation]     Order status can be either "pending" or "canceled"
    [Arguments]     ${email}    ${order_status}
    medusa_api.Login to medusa as admin

    ${order_url}       String.Replace string       ${medusa_api['url_order_status']}     {{order_status}}    ${order_status}
    ${email_url}       String.Replace string       ${order_url}     {{email}}    ${email}

    ${response}        RequestsLibrary.Get on session      medusaSession     ${email_url}

    ${orders_list}    Create list
    FOR     ${orders}    IN    @{response.json()['orders']}
        Log     ${orders}
        ${order_info}    Create dictionary    payment_status=${orders['payment_status']}
        ...             fulfillment_status=${orders['fulfillment_status']}
        ...             order_id=${orders['display_id']}
        ...             order_url=${orders['id']}

        ${order_detail}       String.Replace string       ${medusa_api['url_order_detail']}     {{order_url}}    ${orders['id']}
        ${orderdetails}        RequestsLibrary.Get on session      medusaSession     ${order_detail}
        Collections.Set to dictionary	${order_info}	shop_name=${orderdetails.json()['order']['items'][0]['metadata']['shop_name']}

        Collections.Append to list    ${orders_list}    ${order_info}
        ${all_orders}    Create dictionary    orders=${orders_list}
    END
    [Return]        ${all_orders}

*** Settings ***
Resource        ../../common/api/api_common.resource
Resource        ../database/mirakl_product_db_page.resource
Resource        mirakl_api.resource

*** Keywords ***
Call mirakl API to update product quantity
    [Arguments]     ${product_detail}    ${add_quantity}=1000    ${minimum_qty_db}=10
    ${original_quantity}    Convert to integer    ${product_detail['quantity']}
    IF    ${original_quantity} <= ${minimum_qty_db}
        Collections.Set to dictionary   ${product_detail}    quantity       ${add_quantity}
        mirakl_api.Update quantity product 3P     ${product_detail}
        # Sleep to wait db update quantity from API
        Sleep    3s
        ${product_detail}    mirakl_product_db_page.Get product with shop detail by product name    ${product_detail['product_name_en']}    ${product_detail['seller']}    ${makropro_db['product_service']}
        Should be equal      ${product_detail['quantity']}    ${add_quantity}
    END

Call API get product from product service by product id
    [Documentation]     Pass language by "th" or "en"
    [Arguments]     ${product_id_string}       ${language}
    ${product_id}       String.Remove string    ${product_id_string}  "
    ${file_data}=       api_common.Update json variable     ${file_path['product_detail']}    $.variables.lang      ${language}
    ${file_data}=       api_common.Update json variable     ${file_path['product_detail']}    $.variables.id    ${product_id}

    RequestsLibrary.Create session      postSession    ${ROOT_URL['Product_graphql']}
    ${headers}       Create dictionary    Content-Type=application/json
    ${file_data}=    OperatingSystem.Get binary file        ${CURDIR}/../../resources/data/json_template${file_path['product_detail']}
    ${response}=     RequestsLibrary.Post on session        postSession        url=${product_api['endpoint_graphql']}       data=${file_data}       headers=${headers}      expected_status=200

    ${productinfo}    Create dictionary    productname=${response.json()['data']['productById']['title']}
    ...                       brand=${response.json()['data']['productById']['brand']}
    ...                       description=${response.json()['data']['productById']['description']}
    ...                       size=${response.json()['data']['productById']['size']}
    ...                       displayPrice=${response.json()['data']['productById']['displayPrice']}
    ...                       originPrice=${response.json()['data']['productById']['originPrice']}
    ...                       seller=${response.json()['data']['productById']['seller']}
    ...                       discountStartDate=${response.json()['data']['productById']['discountStartDate']}
    ...                       discountEndDate=${response.json()['data']['productById']['discountEndDate']}

    [Return]        ${productinfo}

Call mirakl API to update product detail and synchonization
    [Arguments]    ${product_name}
    ${product_detail}    mirakl_product_db_page.Get product detail by product name    ${product_name}    ${makropro_db['product_service']}
    mirakl_api.Update product detail for synchonization status    ${product_detail}

Sync status all product detail
    [Arguments]         ${seller_name}=${product_seller}
    ${total_seller}     Get length    ${seller_name}
    FOR  ${seller_key}       IN       @{seller_name}
        ${total_products}    Get length       ${list_product['${seller_key}']}
        FOR    ${index}      IN RANGE    1    ${total_products}+1
            ${parent_key}       Catenate      SEPARATOR=   3P_    ${index}
            product_api.Call mirakl API to update product detail and synchonization    ${list_product['${seller_key}']['${parent_key}']}
        END
    END

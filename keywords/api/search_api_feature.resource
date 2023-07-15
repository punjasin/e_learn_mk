*** Settings ***
Resource        search_typesense_api.resource
Resource        ../../common/api/api_common.resource
Resource        ../../common/common.resource

*** Keywords ***
Search with keyword via api and verify product display
    [Documentation]     ${search_type} is search option on engine , please select from search_data.yaml 
    [Arguments]  ${query_wording}  ${productname}  
    ...     ${query_store}=${store_code['st4']}  
    ${search_result}=   search_typesense_api.Search via typesense with keyword     ${query_wording}     ${query_store} 
    search_typesense_api.Verify typesense products result should not equal           ${search_result}   ${0} 
    search_typesense_api.Verify typesense products result should contains product    ${search_result}   ${productname}     

Search with keyword via api and verify product not display
    [Arguments]  ${query_wording}  ${productname}   ${query_store}=${store_code['st4']}  
    ${search_result}=   search_typesense_api.Search via typesense with keyword     ${query_wording}     ${query_store} 
    search_typesense_api.Verify typesense products result should not contains product    ${search_result}   ${productname}     

Search with keyword via api and verify no product display
    [Documentation]     ${search_type} is search option on engine , please select from search_data.yaml 
    [Arguments]    ${query_wording}  ${query_store}   
    ...     ${query_store}=${store_code['st4']}     
    ${search_result}=   search_typesense_api.Search via typesense with keyword     ${query_wording}     ${query_store} 
    search_typesense_api.Verify typesense products result should be equal     ${search_result}  ${0} 

Search with keyword via api and verify predict search display
    [Documentation]     ${search_type} is search option on engine , please select from search_data.yaml 
    [Arguments]    ${query_wording}    ${predict_word}=${query_wording}  
    ...     ${query_store}=${store_code['st4']}   
    ${search_result}=   search_typesense_api.Search via typesense with keyword     ${query_wording}     ${query_store} 
    search_typesense_api.Verify typesense products result should not equal           ${search_result}    ${0} 
    search_typesense_api.Verify typesense suggestions result should contain keyword    ${search_result}    ${predict_word} 

Search with keyword via api and Verify quantity
    [Documentation]     ${search_type} is search option on engine , please select from search_data.yaml 
    [Arguments]    ${query_wording}   ${productname}     ${qty}     
    ...     ${query_store}=${store_code['st4']}      
    ${search_result}=   search_typesense_api.Search via typesense with keyword     ${query_wording}     ${query_store} 
    log     ${search_result}
    search_typesense_api.Verify typesense products result with quantity should be  ${search_result}   ${productname}     ${qty}

Post search info dynamic data
    [Arguments]    ${payload_key}    ${index}=0
    ${resp}     RequestsLibrary.Post    ${search_api['endpoint']}      json=${payload_key}
    ${product_count}    Get length    ${resp.json()['hits']}
    Should be true     ${index} < ${product_count}    msg="lenght of data less than target index"
    ${dynamic_productinfo}    Create dictionary    productname=${resp.json()['hits'][${index}]['document']['title']}
    ...                       productname_en=${resp.json()['hits'][${index}]['document']['titleEn']}
    ...                       original_price=${resp.json()['hits'][${index}]['document']['originalPrice']}
    ...                       display_price=${resp.json()['hits'][${index}]['document']['displayPrice']}
    ...                       size=${resp.json()['hits'][${index}]['document']['unitSize']}
    ...                       productId=${resp.json()['hits'][${index}]['document']['productId']}
    ...                       total_found=${resp.json()['found']}
    ...                       seller=${resp.json()['hits'][${index}]['document']['seller']}
    ...                       brand=${resp.json()['hits'][${index}]['document']['brand']}
    ...                       sku=${resp.json()['hits'][${index}]['document']['sku']}
    ...                       collections=${resp.json()['hits'][${index}]['document']['collections']}
    ...                       makroId=${resp.json()['hits'][${index}]['document']['makroId']}
    IF    '${lang}' == 'th'
        Collections.Set to dictionary   ${dynamic_productinfo}      titlename=${resp.json()['hits'][${index}]['document']['title']}
    ELSE
        Collections.Set to dictionary   ${dynamic_productinfo}      titlename=${resp.json()['hits'][${index}]['document']['titleEn']}
    END
    [Return]    ${dynamic_productinfo}

Search dynamic product from db
    [Arguments]    ${seller}    ${discount}=${False}    ${total_product}=1    ${current_qty}=1    ${target_brand}=${empty}  
    ...            ${upper_range}=${True}    ${price_range}=1    
    [Documentation]   example output: [{'shop_id': '2011', 'seller': 'Commercial Test 1P MAKRO', 'shop_sku': '157469', 
    ...    'sku': 'n4hljbul', 'quantity': '111', 'original_price': '2000.00', 'discount_price': '', 
    ...    'product_name_en': 'เนสกาแฟ กาแฟพร้อมดื่ม เอสเปรสโซ โรสต์ 180 มล. แพ็ค 30 กระป๋อง', 
    ...    'product_name_th': 'เนสกาแฟ กาแฟพร้อมดื่ม เอสเปรสโซ โรสต์ 180 มล. แพ็ค 30 กระป๋อง', 
    ...    'productId': 7277213057174, 'makroId': '157469', 'brand': 'NESCAFE', 'packaging_depth': '34.00',
    ...    'packaging_width': '11.00', 'packaging_height': '28.00', 'weight': '6.60', 'provider_code': '157469', 
    ...    'long_description_en': '- Product name: Nescafe ready to drink espresso roast 180 ml. pack 30 can\n- 
    ...    Brand: NESCAFE\n- packing volume: 30 can\n- weight: 180 ml.\n\n(Long product description)',
    ...    'long_description_th': '- ชื่อสินค้า: เนสกาแฟ กาแฟพร้อมดื่ม เอสเปรสโซ โรสต์ 180 มล. แพ็ค 30 กระป๋อง\n-
    ...    แบรนด์: NESCAFE\n- ปริมาณบรรจุ: 30 กระป๋อง\n- น้ำหนัก: 180 มิลลิลิตร\n\n(- Product name: Nescafe ready to 
    ...    drink espresso roast 180 ml. pack 30 can\n- Brand: NESCAFE\n- packing volume: 30 can\n- weight: 180 ml.\n\n
    ...    (TH Long product description))', 'size': '30 can', 'synchronization_status': 'SYNCHRONIZED', 
    ...    'acceptance_status': 'ACCEPTED', 'validation_status': 'VALID', 'product_variant_status': 'active', 
    ...    'productname': 'เนสกาแฟ กาแฟพร้อมดื่ม เอสเปรสโซ โรสต์ 180 มล. แพ็ค 30 กระป๋อง', 'min_qty': 0, 'display_price': '355.00'}]
    IF  "${seller}"=="${seller_name['1P_shop']}"
        ${productinfo}    mirakl_product_db_page.Get product list by makro seller    discount=${discount}   total_product=${total_product}    target_brand=${target_brand}    price_range=${price_range}    upper_range=${upper_range}
    ELSE
        ${productinfo}    mirakl_product_db_page.Get product list by 3P seller    seller=${seller}   discount=${discount}   total_product=${total_product}    price_range=${price_range}    upper_range=${upper_range}
    END
    FOR   ${index}   IN RANGE   ${total_product}
        IF    "${productinfo[${index}]['seller']}"!="${seller_name['1P_shop']}"
            product_api.Call mirakl API to update product quantity    ${productinfo[${index}]}
        END
        ${product_change}    Set variable          ${productinfo[${index}]}
        ${product_change}    common.Set product name from api data      ${productinfo[${index}]}
        Collections.Set to dictionary   ${productinfo[${index}]}      productname=${product_change['productname']}
        IF    "${productinfo[${index}]['seller']}"=="${seller_name['1P_shop']}"
                ${product_price}      rm3_api.Get product 1P price    ${productinfo[${index}]['makroId']}
                Collections.Set to dictionary   ${productinfo[${index}]}      original_price=${product_price}
        END
        IF   "${productinfo[${index}]['discount_price']}"=="${empty}"
            Collections.Set to dictionary   ${productinfo[${index}]}      display_price=${productinfo[${index}]['original_price']}
        ELSE
            Collections.Set to dictionary   ${productinfo[${index}]}      display_price=${productinfo[${index}]['discount_price']}
        END

        ${target_qty}        common.Get required qty to reach minimum price     ${productinfo[${index}]['display_price']}        ${current_qty}
        Collections.Set to dictionary   ${productinfo[${index}]}      min_qty=${target_qty}
    END
    [Return]        ${productinfo}

Set target qty product
    [Arguments]    ${product_detail}    ${qty_list}
    [Documentation]    product detail not has key 'qty', update on single product
    ...    input as product_detail: [{'shop_id': '2011', ... , 'display_price': '89.00'}]
    ...    output : [{'shop_id': '2011', ... , 'display_price': '89.00', 'qty': '4'}]
    ...    This keyword use with loop sent each product_detail from keyword 'Search and add all dynamic products to basket'
    FOR   ${index}    ${products}    IN ENUMERATE       @{product_detail}
        Collections.Set to dictionary    ${products}    qty=${qty_list[${index}]}
    END
    [Return]        ${product_detail}

Update target qty product
    [Arguments]    ${product_detail}     ${qty_list}
    [Documentation]    Update on all product detail array which are separated by seller key
    ...   input as product_detail: {'seller_0': [{'shop_id': '2011', ... , 'qty': 0}, {'shop_id': '2011', ... , 'qty': 4}]}
    ...   input as qty_list: [1,5]
    ...   output: {'seller_0': [{'shop_id': '2011', ... , 'qty': 1}, {'shop_id': '2011', ... , 'qty': 5}]}
   FOR   ${index}    ${seller_key}    IN ENUMERATE      @{product_detail}
        FOR   ${record_index}    ${products}    IN ENUMERATE      @{product_detail['${seller_key}']}
            Collections.Set to dictionary     ${products}    qty=${qty_list[${record_index}]}
        END
    END
    [Return]     ${product_detail}
***Settings***
Resource        ../../common/database/db_common.resource
Variables       ../../resources/data/common.yaml

*** Keywords ***
Get product with shop detail by product name
    [Arguments]    ${product_name}    ${seller_name}        ${db_detail}=${makropro_db['product_service']}
    [Documentation]    output: {'shop_id': '2045', 'shop_name': 'Automation FBM', 
    ...    'shop_sku': 'S2268', 'product_sku': 'lzmqxbiv', 'quantity': '0', 
    ...    'original_price': '1000.00', 'discount_price': '800.00', 'product_name_en': 'Coconut FBM',
    ...    'product_name_th': 'มะพร้าว FBM'}
    db_common.Connect to postgres database      ${db_detail}
    ${query} =   Catenate        SELECT
    ...    mo."miraklData" ->> 'shopId' AS shopId,
    ...    mo."miraklData" ->> 'shopName' AS shopName,
    ...    mo."miraklData" ->> 'shopSku' AS shopSku,
    ...    mo."miraklData" ->> 'productSku' AS productSku,
    ...    mo."miraklData" ->> 'quantity' AS quantity,
    ...    mo."miraklData" ->> 'originPrice' AS originPrice,
    ...    mo."miraklData" ->> 'discountPrice' AS discountPrice,
    ...    p.product_name_en,
    ...    p.product_name_th
    ...    FROM
    ...    mirakl_offer AS mo
    ...    JOIN
    ...    (
    ...    SELECT
    ...    "miraklData" ->> 'product_sku' AS product_sku,
    ...    "miraklData" -> 'data' ->> 'product_name' AS product_name_en,
    ...    "miraklData" -> 'data' ->> 'product_name_th' AS product_name_th
    ...    FROM
    ...    product
    ...    WHERE
    ...    "miraklData" -> 'data' ->> 'product_name' = '${product_name}' 
    ...    or "miraklData" -> 'data' ->> 'product_name_th' = '${product_name}'
    ...    ) AS p ON mo."miraklData" ->> 'productSku' = p.product_sku
    ...    WHERE
    ...    (mo."miraklData" ->> 'shopId' IS NOT NULL AND mo."miraklData" ->> 'shopId' <> ''
    ...    and mo."miraklData"->>'shopName' = '${seller_name}');
    @{queryResults}   DatabaseLibrary.query     ${query}
    ${total_records}    Get length      ${queryResults}
    Should be true      ${total_records}>0        msg=data not found
    ${all_data}       Collections.Convert to list   @{queryResults}
    ${total_data}     Get length      ${all_data}
    ${product_detail}       Create dictionary
    ${key_index}      Create list    shop_id    shop_name   shop_sku
    ...    sku   quantity    original_price    discount_price
    ...    product_name_en    product_name_th
    FOR    ${index}    IN RANGE    ${total_data}
        Collections.Set to dictionary     ${product_detail}
        ...                 ${key_index[${index}]}=${all_data[${index}]}
    END
    db_common.Disconnect from database
    [Return]          ${product_detail}

Get product detail by product name
    [Arguments]    ${product_name}        ${db_detail}=${makropro_db['product_service']}
    db_common.Connect to postgres database      ${db_detail}
    ${query} =   Catenate     SELECT DISTINCT
    ...    product."miraklData" -> 'data' ->> 'category' AS category,
    ...    product."miraklData" -> 'data' ->> 'makro_id' AS makro_id,
    ...    product."miraklData" -> 'data' ->> 'brand_name' AS brand_name,
    ...    product."miraklData" -> 'data' ->> 'unit_depth' AS unit_depth,
    ...    product."miraklData" -> 'data' ->> 'unit_width' AS unit_width,
    ...    product."miraklData" -> 'data' ->> 'unit_amount' AS unit_amount,
    ...    product."miraklData" -> 'data' ->> 'unit_height' AS unit_height,
    ...    product."miraklData" -> 'data' ->> 'product_name' AS product_name,
    ...    product."miraklData" -> 'data' ->> 'brand_name_th' AS brand_name_th,
    ...    product."miraklData" -> 'data' ->> 'packaging_depth' AS packaging_depth,
    ...    product."miraklData" -> 'data' ->> 'packaging_width' AS packaging_width,
    ...    product."miraklData" -> 'data' ->> 'product_name_th' AS product_name_th,
    ...    product."miraklData" -> 'data' ->> 'packaging_height' AS packaging_height,
    ...    product."miraklData" -> 'data' ->> 'packaging_weight' AS packaging_weight,
    ...    product."miraklData" -> 'data' ->> 'short_description' AS short_description,
    ...    product."miraklData" -> 'data' ->> 'unit_amount_classification' AS unit_amount_classification,
    ...    product."miraklData" ->> 'mirakl_product_id' AS mirakl_product_id,
    ...    product."miraklData" ->> 'product_sku' AS product_sku
    ...    FROM
    ...    product AS product
    ...    JOIN mirakl_offer ON product."miraklData" ->> 'product_sku' = mirakl_offer."miraklData" ->> 'productSku'
    ...    WHERE product."miraklData" -> 'data' ->> 'product_name' = '${product_name}'
    ...    OR  product."miraklData" -> 'data' ->> 'product_name_th' = '${product_name}';
    
    @{queryResults}   DatabaseLibrary.query     ${query}
    ${total_records}    Get length      ${queryResults}
    Should be true      ${total_records}>0        msg=data not found
    ${all_data}       Collections.Convert to list   @{queryResults}
    ${total_data}     Get length      ${all_data}
    ${product_detail}       Create dictionary
    ${key_index}      Create list    category    makro_id   brand_name
    ...    unit_depth           unit_width             unit_amount        unit_height
    ...    product_name         brand_name_th          packaging_depth    packaging_width
    ...    product_name_th      packaging_height       packaging_weight
    ...    short_description    unit_amount_classification    mirakl_product_id    sku
    FOR    ${index}    IN RANGE    ${total_data}
        Collections.Set to dictionary     ${product_detail}
        ...                 ${key_index[${index}]}=${all_data[${index}]}
    END
    db_common.Disconnect from database
    [Return]          ${product_detail}

Get product list by makro seller
    [Arguments]      ${discount}=${False}    ${total_product}=1    ${db_detail}=${makropro_db['product_service']}
    ...              ${upper_range}=${True}        ${price_range}=1    ${target_brand}=${empty}
    [Documentation]    by defaul, get single product with no discount.
    ...    if want discounts products, have to call kewyord again with argument discount=True
    ...    You can specify total products you want, EX: discount=True   total_product=2
    db_common.Connect to postgres database      ${db_detail}
    ${query} =   Catenate     SELECT DISTINCT
    ...    mo."miraklData" ->> 'shopId' AS shopId,
    ...    mo."miraklData" ->> 'shopName' AS shopName,
    ...    COALESCE(mo."miraklData" ->> 'shopSku', '') AS shopSku,
    ...    mo."miraklData" ->> 'productSku' AS productSku,
    ...    mo."miraklData" ->> 'quantity' AS quantity,
    ...    mo."miraklData" ->> 'originPrice' AS originPrice,
    ...    mo."miraklData" ->> 'discountPrice' AS discountPrice,
    ...    p.product_name_en,
    ...    p.product_name_th,
    ...    pv.product_id,
    ...    p.makro_id,
    ...    p.brand_name,
    ...    p.packaging_depth,
    ...    p.packaging_width,
    ...    p.packaging_height,
    ...    p.weight,
    ...    p.provider_code,
    ...    p.long_description_en,
    ...    p.long_description_th,
    ...    p.unit,
    ...    p.synchronization_status,
    ...    p.acceptance_status,
    ...    p.validation_status,
    ...    pv.status AS variant_status,
    ...    mo."miraklData" -> 'shippingMethods' -> 'dropship' -> 'BKK' -> 'delivery-time-latest-days' as max_delivery_day,
    ...    mo."miraklData" -> 'shippingMethods' -> 'dropship' -> 'BKK' -> 'delivery-time-earliest-days' as min_delivery_day,
    ...    pv.weight_unit
    ...    FROM
    ...    mirakl_offer AS mo
    ...    join (
    ...    select
    ...    "data" ->> 'sku' AS product_sku,
    ...    status AS status,
    ...    "data" -> 'product_id' as product_id,
    ...    (jsonb_extract_path_text(data, 'metafields', '2', 'value')::jsonb ->> 'shopName') AS shop_name,
    ...    "data" ->> 'weight_unit' as weight_unit
    ...    FROM
    ...    product_variant 
    ...    where
    ...    (jsonb_extract_path_text(data, 'metafields', '2', 'value')) like '{"%' 
    ...    and (jsonb_extract_path_text(data, 'metafields', '2', 'value')::jsonb ->> 'shopName') LIKE '%Commercial Test 1P MAKRO%'
    ...    AND (jsonb_extract_path_text(data, 'metafields', '4', 'value')) = 'active'
    ...    ) AS pv ON mo."miraklData" ->> 'productSku' = pv.product_sku
    ...    and mo."miraklData" ->> 'shopName' = pv.shop_name
    ...    and pv.status = 'active'
    IF   ${upper_range}==${True}
        ${price_condition}    Set variable   >
    ELSE
        ${price_condition}    Set variable   <
    END
    ${query} =   Catenate    ${query}
    ...    and COALESCE(NULLIF(mo."miraklData" ->> 'originPrice', ''), '0')::numeric ${price_condition} ${price_range}
    ...    JOIN
    ...    (
    ...    SELECT
    ...    "miraklData" ->> 'product_sku' AS product_sku,
    ...    COALESCE("miraklData" -> 'data' ->> 'product_name', '') AS product_name_en,
    ...    COALESCE("miraklData" -> 'data' ->> 'product_name_th', '') AS product_name_th,
    ...    "miraklData" -> 'synchronization' ->> 'status' AS synchronization_status,
    ...    "miraklData" -> 'acceptance' ->> 'status' AS acceptance_status,
    ...    "miraklData" -> 'validation' ->> 'status' AS validation_status,
    ...    "miraklData" -> 'data' ->> 'makro_id' as makro_id,
    ...    "miraklData" -> 'data' ->> 'brand_name' as brand_name,
    ...    "miraklData" -> 'data' ->> 'packaging_depth' as packaging_depth,
    ...    "miraklData" -> 'data' ->> 'packaging_width' as packaging_width,
    ...    "miraklData" -> 'data' ->> 'packaging_height' as packaging_height,
    ...    "miraklData" -> 'data' ->> 'packaging_weight' as weight,
    ...    "miraklData" -> 'sources' -> 0 ->> 'provider_sku' as provider_code,
    ...    replace(COALESCE(jsonb_extract_path_text("miraklData" -> 'data', 'long_description'), '')::text, E'\n', E'\\n') AS long_description_en,
    ...    replace(COALESCE(jsonb_extract_path_text("miraklData" -> 'data', 'long_description_th'), '')::text, E'\n', E'\\n') AS long_description_th,
	...    concat("miraklData" -> 'data' ->> 'unit_amount',' ',"miraklData" -> 'data' ->> 'unit_amount_classification') as unit
    ...    FROM
    ...    product
    ...    WHERE
    ...    "miraklData" -> 'synchronization' ->> 'status' = 'SYNCHRONIZED'
    ...    AND "miraklData" -> 'acceptance' ->> 'status' = 'ACCEPTED'
    ...    AND "miraklData" -> 'validation' ->> 'status' = 'VALID'
    ...    AND "miraklData" -> 'data' ->> 'brand_name' NOT ILIKE  'NT'
    ...    AND "miraklData" -> 'data' ->> 'brand_name' NOT ILIKE 'UAT TEST'
    ...    AND "miraklData" -> 'data' ->> 'brand_name' NOT ILIKE 'QA'
    ...    AND "miraklData" -> 'data' ->> 'brand_name' NOT ILIKE 'testshop'
    ...    AND "miraklData" -> 'data' ->> 'brand_name' NOT ILIKE 'QA regression'
    ...    and COALESCE("miraklData" -> 'data' ->> 'product_name', '') NOT ILIKE '%ำ%'
    ...    and COALESCE("miraklData" -> 'data' ->> 'product_name_th', '') NOT ILIKE '%ำ%'
    IF  "${target_brand}"!="${empty}"
        ${query} =   Catenate    ${query}
        ...    AND "miraklData" -> 'data' ->> 'brand_name' like '${target_brand}'
    END
    ${query} =   Catenate    ${query}
    ...    ) AS p ON mo."miraklData" ->> 'productSku' = p.product_sku
    ...    where
    ...    mo."miraklData" ->> 'shopSku' NOT ILIKE 'fresh%'
    ...    and mo."miraklData" ->> 'shopSku' NOT ILIKE '85%'
    ...    and mo."miraklData" ->> 'shopSku' = p.makro_id
    ...    and p.provider_code NOT ILIKE '1P%'
    ...    and p.long_description_en <> ''
    ...    or p.long_description_th <> ''
     IF   ${discount}==${True}
        ${discount_condition}    Set variable   <>
    ELSE
        ${discount_condition}    Set variable    =
    END
    ${query} =   Catenate    ${query}
    ...    and mo."miraklData" ->> 'discountPrice' ${discount_condition} ''
    ...    order by p.product_name_th asc,mo."miraklData" ->> 'quantity' desc, mo."miraklData" ->> 'discountPrice' desc,
    ...    mo."miraklData" ->> 'originPrice' desc
    ...    limit ${total_product}
    @{queryResults}     DatabaseLibrary.Query     ${query}      
    ${total_records}    Get length      ${queryResults}
    Should be true      ${total_records}>0        msg=data not found
    ${header_index}      Create list    shop_id    seller   shop_sku
        ...    sku   quantity    original_price    discount_price
        ...    product_name_en    product_name_th    productId    makroId    
        ...    brand     packaging_depth    packaging_width    packaging_height
        ...    weight    provider_code    long_description_en      long_description_th
        ...    size      synchronization_status     acceptance_status
        ...    validation_status    product_variant_status    max_delivery_day    min_delivery_day    weight_unit
    ${product_list}     Create list
    FOR    ${record_index}    IN      @{queryResults}
        ${product_detail}       Create dictionary
        FOR     ${index}  ${items}     IN ENUMERATE     @{record_index}
            Collections.Set to dictionary     ${product_detail}
            ...                 ${header_index[${index}]}=${items}
        END
        Collections.Append to list    ${product_list}    ${product_detail}
    END
    db_common.Disconnect from database
    [Return]           ${product_list}

Get product list by 3P seller
    [Arguments]      ${seller}    ${discount}=${False}    ${total_product}=1    ${db_detail}=${makropro_db['product_service']}
    ...              ${upper_range}=${True}        ${price_range}=1
    [Documentation]    by defaul, get single product with no discount.
    ...    if want discounts products, have to call kewyord again with argument discount=True
    ...    You can specify total products you want, EX: seller=Automation SOD   discount=True   total_product=2
    ...    This query already test with seller Automation SOD, Automation FBM, Fruitgogogo and Doppio Tech
    db_common.Connect to postgres database      ${db_detail}
    ${query} =   Catenate     SELECT DISTINCT
    ...    mo."miraklData" ->> 'shopId' AS shopId,
    ...    mo."miraklData" ->> 'shopName' AS shopName,
    ...    mo."miraklData" ->> 'shopSku' AS shopSku,
    ...    mo."miraklData" ->> 'productSku' AS productSku,
    ...    mo."miraklData" ->> 'quantity' AS quantity,
    ...    mo."miraklData" ->> 'originPrice' AS originPrice,
    ...    mo."miraklData" ->> 'discountPrice' AS discountPrice,
    ...    p.product_name_en,
    ...    p.product_name_th,
    ...    pv.product_id,
    ...    p.makro_id,
    ...    p.brand_name,
    ...    p.packaging_depth,
    ...    p.packaging_width,
    ...    p.packaging_height,
    ...    p.weight,
    ...    p.provider_code,
    ...    p.long_description_en,
    ...    p.long_description_th,
    ...    p.unit,
    ...    p.synchronization_status,
    ...    p.acceptance_status,
    ...    p.validation_status,
    ...    pv.status AS variant_status,
    ...    mo."miraklData" -> 'shippingMethods' -> 'dropship' -> 'BKK' -> 'delivery-time-latest-days' as max_delivery_day,
    ...    mo."miraklData" -> 'shippingMethods' -> 'dropship' -> 'BKK' -> 'delivery-time-earliest-days' as min_delivery_day,
    ...    pv.weight_unit
    ...    FROM
    ...    mirakl_offer AS mo
    ...    JOIN
    ...    (
    ...    SELECT
    ...    "miraklData" ->> 'product_sku' AS product_sku,
    ...    COALESCE("miraklData" -> 'data' ->> 'product_name', '') AS product_name_en,
    ...    COALESCE("miraklData" -> 'data' ->> 'product_name_th', '') AS product_name_th,
    ...    "miraklData" -> 'synchronization' ->> 'status' AS synchronization_status,
    ...    "miraklData" -> 'acceptance' ->> 'status' AS acceptance_status,
    ...    "miraklData" -> 'validation' ->> 'status' AS validation_status,
    ...    COALESCE("miraklData" -> 'data' ->> 'makro_id', '') as makro_id,
    ...    "miraklData" -> 'data' ->> 'brand_name' as brand_name,
    ...    "miraklData" -> 'data' ->> 'packaging_depth' as packaging_depth,
    ...    "miraklData" -> 'data' ->> 'packaging_width' as packaging_width,
    ...    "miraklData" -> 'data' ->> 'packaging_height' as packaging_height,
    ...    "miraklData" -> 'data' ->> 'packaging_weight' as weight,
    ...    "miraklData" -> 'sources' -> 0 ->> 'provider_sku' as provider_code,
    ...    replace(COALESCE(jsonb_extract_path_text("miraklData" -> 'data', 'long_description'), '')::text, E'\n', E'\\n') AS long_description_en,
    ...    replace(COALESCE(jsonb_extract_path_text("miraklData" -> 'data', 'long_description_th'), '')::text, E'\n', E'\\n') AS long_description_th,
    ...    concat("miraklData" -> 'data' ->> 'unit_amount',' ',"miraklData" -> 'data' ->> 'unit_amount_classification') as unit
    ...    FROM
    ...    product
    ...    WHERE
    ...    "miraklData" -> 'synchronization' ->> 'status' = 'SYNCHRONIZED'
    ...    AND "miraklData" -> 'acceptance' ->> 'status' = 'ACCEPTED'
    ...    AND "miraklData" -> 'validation' ->> 'status' = 'VALID'
    ...    and COALESCE("miraklData" -> 'data' ->> 'product_name', '') NOT ILIKE '%ำ%'
    ...    and COALESCE("miraklData" -> 'data' ->> 'product_name_th', '') NOT ILIKE '%ำ%'
    ...    AND "miraklData" -> 'data' ->> 'brand_name' NOT ILIKE 'Logi%'
    ...    AND "miraklData" -> 'data' ->> 'brand_name' NOT ILIKE 'Countrybean'
    ...    AND "miraklData" -> 'data' ->> 'brand_name' NOT ILIKE 'Gourmet%'
    ...    AND "miraklData" -> 'data' ->> 'brand_name' NOT ILIKE 'mildmyshop'
    ...    AND "miraklData" -> 'data' ->> 'brand_name' NOT ILIKE 'test'
    ...    AND "miraklData" -> 'data' ->> 'brand_name' NOT ILIKE 'coffee'
    ...    AND "miraklData" -> 'data' ->> 'brand_name' NOT ILIKE 'Makro'
    ...    ) AS p ON mo."miraklData" ->> 'productSku' = p.product_sku
    IF   ${discount}==${True}
        ${discount_condition}    Set variable   <>
    ELSE
        ${discount_condition}    Set variable    =
    END
    ${query} =   Catenate    ${query}
    ...    and mo."miraklData" ->> 'discountPrice' ${discount_condition} ''
    ...    JOIN
    ...    (
    ...    SELECT
    ...    "data" ->> 'sku' AS product_sku,
    ...    status AS status,
    ...    (jsonb_extract_path_text(data, 'metafields', '2', 'value')::jsonb ->> 'shopName') AS shop_name
    ...    FROM
    ...    product_variant
    ...    WHERE
    ...    (jsonb_extract_path_text(data, 'metafields', '2', 'value')) like '{"%' 
    ...    AND (jsonb_extract_path_text(data, 'metafields', '2', 'value')::jsonb ->> 'shopName') LIKE '${seller}'
    ...    AND (jsonb_extract_path_text(data, 'metafields', '4', 'value')) = 'active'
    ...    ) AS product_variant ON mo."miraklData" ->> 'shopName' = product_variant.shop_name
    ...    JOIN
    ...    (
    ...    SELECT
    ...    "data" ->> 'sku' AS product_sku,
    ...    "data" -> 'metafields' -> 4 ->> 'value' AS status,
    ...    "data" -> 'product_id' as product_id,
    ...    "data" ->> 'weight_unit' as weight_unit
    ...    FROM
    ...    product_variant
    ...    WHERE
    ...    (jsonb_extract_path_text(data, 'metafields', '4', 'value')) = 'active'
    ...    ) AS pv ON p.product_sku = pv.product_sku 
    ...    where
    IF   ${upper_range}==${True}
        ${price_condition}    Set variable   >
    ELSE
        ${price_condition}    Set variable   <
    END
    ${query} =   Catenate    ${query}
    ...    COALESCE(NULLIF(mo."miraklData" ->> 'originPrice', ''), '0')::numeric ${price_condition} ${price_range}
    IF  "${seller}"=="${seller_name['3P_FBM_new']}"
        ${query} =   Catenate    ${query}
        ...    and p.long_description_en <> ''
        ...    or p.long_description_th <> '' 
    END
    ${query} =   Catenate    ${query}
    ...    order by mo."miraklData" ->> 'quantity' DESC, p.product_name_th asc,
    ...    mo."miraklData" ->> 'discountPrice' desc, mo."miraklData" ->> 'originPrice' desc
    ...    limit ${total_product}
    
    @{queryResults}     DatabaseLibrary.Query     ${query}      
    ${total_records}    Get length      ${queryResults}
    Should be true      ${total_records}>0        msg=data not found
    ${header_index}      Create list    shop_id    seller   shop_sku
        ...    sku   quantity    original_price    discount_price
        ...    product_name_en    product_name_th    productId    makroId    
        ...    brand     packaging_depth    packaging_width    packaging_height
        ...    weight    provider_code    long_description_en      long_description_th
        ...    size      synchronization_status     acceptance_status
        ...    validation_status    product_variant_status    max_delivery_day    min_delivery_day    weight_unit
    ${product_list}     Create list
    FOR    ${record_index}    IN      @{queryResults}
        ${product_detail}       Create dictionary
        FOR     ${index}  ${items}     IN ENUMERATE     @{record_index}
            Collections.Set to dictionary     ${product_detail}
            ...                 ${header_index[${index}]}=${items}
        END
        Collections.Append to list    ${product_list}    ${product_detail}
    END
    db_common.Disconnect from database
    [Return]           ${product_list}
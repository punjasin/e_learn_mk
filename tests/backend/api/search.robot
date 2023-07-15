*** Settings ***
Resource            ../../../common/api/api_common.resource

variables           ../../../resources/settings/api.yaml
Variables           ../../../resources/data/common.yaml
Variables           ../../../resources/localisation/mobile/${lang}.yaml
Variables           ../../../resources/data/search_api.yaml
Variables           ../../../resources/data/product.yaml

*** Test Cases ***
Search with TH , EN , mix 
    [Tags]  MAKNET-12   priority_high   api  search  
    search_api_feature.Search with keyword via api and verify product display      ${query['TH']}      ${list_product['Commercial Test 1P MAKRO']['1P_1']}  
    search_api_feature.Search with keyword via api and verify product display      ${query['EN']}      ${list_product['Commercial Test 1P MAKRO']['1P_2']}  
    search_api_feature.Search with keyword via api and verify product display      ${query['mixed']}   ${list_product['Sure Chemical Supply Co.,Ltd']['3P_12']}

Search with Search with product name , brand , collection , synonym , barcode
    [Tags]  MAKNET-1080  priority_high  api  search  
    search_api_feature.Search with keyword via api and verify product display      ${query['product name keyword']}     ${list_product['Commercial Test 1P MAKRO']['1P_1']}
    search_api_feature.Search with keyword via api and verify product display      ${query['brand keyword']}            ${list_product['Commercial Test 1P MAKRO']['1P_7']}
    search_api_feature.Search with keyword via api and verify product display      ${query['collection keyword']}       ${list_product['Commercial Test 1P MAKRO']['1P_8']}
    search_api_feature.Search with keyword via api and verify product display      ${searching['synonym keyword']}          ${list_product['Commercial Test 1P MAKRO']['1P_5']}
    search_api_feature.Search with keyword via api and verify product display      ${query['sku keyword']}              ${list_product['Commercial Test 1P MAKRO']['1P_1']}

    ##barcode
    ${search_result}=  search_typesense_api.Search via typesense with keyword      ${list_product['Commercial Test 1P MAKRO']['1P_6_barcode']}
    search_typesense_api.Verify typesense products result should contains product    ${search_result}   ${list_product['Commercial Test 1P MAKRO']['1P_6']}
    search_typesense_api.Verify typesense products result should match with barcode  ${search_result}   ${list_product['Commercial Test 1P MAKRO']['1P_6_barcode']}

Search keyword that matched more than one topic
    [Tags]  MAKNET-16   priority_medium  api  search  
    search_api_feature.Search with keyword via api and verify product display      ${query['many topic keyword']}   ${list_product['Commercial Test 1P MAKRO']['1P_3']}  
    search_api_feature.Search with keyword via api and verify product display      ${query['many topic keyword']}   ${list_product['Commercial Test 1P MAKRO']['1P_4']}  

Search with keyword that not exists in system
    [Tags]  MAKNET-15  priority_low  api  search  
    search_api_feature.Search with keyword via api and verify no product display   ${searching['non-related keyword']}
    search_api_feature.Search with keyword via api and verify no product display   ${searching['non-related keyword']}

User able to see predict searching
    [Tags]  MAKNET-2942  priority_medium  api  search  
    search_api_feature.Search with keyword via api and verify predict search display   ${query['predict']}   ${query['predict']}           

User able to see product that not avaliable from searching
    [Tags]  MAKNET-1059  priority_high  api  search  
    search_api_feature.Search with keyword via api and Verify quantity   ${query['keyword_outofstock']}     ${list_product['Doppio-tech']['3P_5']}       ${0}
    
Search should be filtered by store : 804 , 08 , 3P
    [Tags]  MAKNET-2838  priority_high  api  search 
    search_api_feature.Search with keyword via api and verify product display      ${list_product['Commercial Test 1P MAKRO']['1P_1']}      ${list_product['Commercial Test 1P MAKRO']['1P_1']}     query_store=${store_code['st4']}
    search_api_feature.Search with keyword via api and verify product not display  ${list_product['1P Makro ST08']['1P_9']}                 ${list_product['1P Makro ST08']['1P_9']}                query_store=${store_code['st4']}
    search_api_feature.Search with keyword via api and verify product display      ${list_product['Sure Chemical Supply Co.,Ltd']['3P']}    ${list_product['Sure Chemical Supply Co.,Ltd']['3P']}   query_store=${store_code['st4']}
    
    search_api_feature.Search with keyword via api and verify product not display  ${list_product['Commercial Test 1P MAKRO']['1P_7']}      ${list_product['Commercial Test 1P MAKRO']['1P_7']}     query_store=${store_code['st8']}
    search_api_feature.Search with keyword via api and verify product display      ${list_product['1P Makro ST08']['1P_9']}                 ${list_product['1P Makro ST08']['1P_9']}                query_store=${store_code['st8']}
    search_api_feature.Search with keyword via api and verify product display      ${list_product['Sure Chemical Supply Co.,Ltd']['3P']}    ${list_product['Sure Chemical Supply Co.,Ltd']['3P']}   query_store=${store_code['st8']}

    search_api_feature.Search with keyword via api and verify product not display  ${list_product['Commercial Test 1P MAKRO']['1P_1']}      ${list_product['Commercial Test 1P MAKRO']['1P_1']}     query_store=${store_code['3p']}
    search_api_feature.Search with keyword via api and verify product not display  ${list_product['1P Makro ST08']['1P_9']}                 ${list_product['1P Makro ST08']['1P_9']}                query_store=${store_code['3p']}
    search_api_feature.Search with keyword via api and verify product display      ${list_product['Sure Chemical Supply Co.,Ltd']['3P']}    ${list_product['Sure Chemical Supply Co.,Ltd']['3P']}   query_store=${store_code['3p']}

User able to sort search result by relevant , price , promotion , recently added
    [Tags]  MAKNET-1062  MAKNET-1063  MAKNET-1064  MAKNET-1065  MAKNET-1066  priority_high  api  search
    ${search_result}=   search_typesense_api.Search and sort via typesense with keyword     ${query['product name keyword']}    sortBy=${search engine['typesense']['search option']['sort_by_relevance']}
    log    ${search_result}
    search_typesense_api.Verify typesense result sort by instock status  ${search_result}
    ${search_result}=   search_typesense_api.Search and sort via typesense with keyword     ${query['product name keyword']}    sortBy=${search engine['typesense']['search option']['sort_by_price_lowToHigh']}
    search_typesense_api.Verify typesense result sort by price low to high   ${search_result}
    ${search_result}=   search_typesense_api.Search and sort via typesense with keyword     ${query['product name keyword']}    sortBy=${search engine['typesense']['search option']['sort_by_price_highToLow']}
    search_typesense_api.Verify typesense result sort by price high to low   ${search_result}
    ${search_result}=   search_typesense_api.Search and sort via typesense with keyword     ${query['product name keyword']}    sortBy=${search engine['typesense']['search option']['sort_by_promotion']}
    search_typesense_api.Verify typesense result sort by promotion   ${search_result}
    log    ${search_result}
    ${search_result}=   search_typesense_api.Search and sort via typesense with keyword     ${query['product name keyword']}    sortBy=${search engine['typesense']['search option']['sort_by_recently']}
    search_typesense_api.Verify typesense result sort by recently added   ${search_result}

User able to filter search result by price 
    [Tags]  MAKNET-1067  priority_high  api  search
    @{list_filter} =   Create list   ${mobile_additional['my_address']['False']}  ${server_error_response}
    ${search_result}=   search_typesense_api.Search and filter via typesense with keyword   
    ...     querywording=${query['product name keyword']}    
    ...     filterType=${search engine['typesense']['search option']['filter']['price']}    
    ...     filterValue=@{list_filter}
    search_typesense_api.Verify typesense result filter by price     ${search_result}    ${mobile_additional['my_address']['False']}    ${server_error_response}

User able to filter search result by category 
    [Tags]  MAKNET-1068  priority_high  api  search
    @{list_filter} =   Create list   ${search engine['typesense']['search option']['filter']['collection_1']}  
    ${search_result}=   search_typesense_api.Search and filter via typesense with keyword   
    ...     querywording=${query['product name keyword']}    
    ...     filterType=${search engine['typesense']['search option']['filter']['collection']}    
    ...     filterValue=@{list_filter}
    search_typesense_api.Verify typesense result filter by category     ${search_result}    ${search engine['typesense']['search option']['filter']['collection_1']}   

User able to filter search result by brand 
    [Tags]  MAKNET-1069  priority_high  api  search
    @{list_filter} =   Create list   ${search engine['typesense']['search option']['filter']['brands_1']}   ${search engine['typesense']['search option']['filter']['brands_2']}
    ${search_result}=   search_typesense_api.Search and filter via typesense with keyword   
    ...     querywording=${query['product name keyword']}    
    ...     filterType=${search engine['typesense']['search option']['filter']['brand']}    
    ...     filterValue=@{list_filter}
    search_typesense_api.Verify typesense result filter by brand     ${search_result}    ${search engine['typesense']['search option']['filter']['brands_1']}   ${search engine['typesense']['search option']['filter']['brands_2']}

User able to filter search result by avaliable 
    [Tags]  MAKNET-1070  priority_high  api  search
    ${search_result}=   search_typesense_api.Search and filter via typesense with keyword   
    ...     querywording=${query['product name keyword']}    
    ...     filterType=${search engine['typesense']['search option']['filter']['availability']}    
    search_typesense_api.Verify typesense result filter by availability   ${search_result}

User able to filter search result by promotion 
    [Tags]  MAKNET-1071  priority_high  api  search
    ${search_result}=   search_typesense_api.Search and filter via typesense with keyword   
    ...     querywording=${query['product name keyword']}    
    ...     filterType=${search engine['typesense']['search option']['filter']['promotion']}    
    search_typesense_api.Verify typesense result filter by promotion     ${search_result}

User able to filter search results by many filter type
    [Tags]  MAKNET-1072  priority_high  api  search
    @{list_collection} =   Create list   ${search engine['typesense']['search option']['filter']['collection_1']}   ${search engine['typesense']['search option']['filter']['collection_2']}
    @{list_brand} =   Create list   ${search engine['typesense']['search option']['filter']['brands_3']}   ${search engine['typesense']['search option']['filter']['brands_4']}
    ${search_result}=   search_typesense_api.Search and sort and filter via typesense with keyword
    ...     querywording=${query['product name keyword2']} 
    ...     sortBy=${search engine['typesense']['search option']['sort_by_price_lowToHigh']}
    ...     priceRange_from=${mobile_additional['my_address']['False']}
    ...     priceRange_to=${server_error_response}
    ...     collection=@{list_collection}
    ...     brand=@{list_brand}
    search_typesense_api.Verify typesense result sort by price low to high   ${search_result}
    search_typesense_api.Verify typesense result filter by price         ${search_result}    ${mobile_additional['my_address']['False']}    ${server_error_response}
    search_typesense_api.Verify typesense result filter by category      ${search_result}    ${search engine['typesense']['search option']['filter']['collection_1']}    ${search engine['typesense']['search option']['filter']['collection_2']}
    search_typesense_api.Verify typesense result filter by brand         ${search_result}    ${search engine['typesense']['search option']['filter']['brands_3']}        ${search engine['typesense']['search option']['filter']['brands_4']}
    search_typesense_api.Verify typesense result filter by availability  ${search_result}
    search_typesense_api.Verify typesense result filter by promotion     ${search_result}
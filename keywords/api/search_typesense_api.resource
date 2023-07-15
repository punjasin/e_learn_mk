*** Settings ***
Resource        ../../common/api/api_common.resource

*** Keywords ***
Call typesense API
    [Arguments]     ${jsonfile}
    RequestsLibrary.Create session   Post Session      ${ROOT_URL['Typesense']}
    ${headers}      Create Dictionary   Content-Type=application/json
    ${file_data}=    OperatingSystem.Get binary file        ${CURDIR}/../../resources/data/json_template/${jsonfile}
    ${response}=     RequestsLibrary.Post on session        Post Session        /search/api/v1/indexes/products/search        data=${file_data}       headers=${headers}
    ...     expected_status=200
    [Return]        ${response}

Generate query typesense with keyword and store
    [Arguments]     ${querywording}   ${querystore}=${store_code['st4']}   ${search_option}=${search engine['typesense']['search option']['basic']}
    ${jsonfile} =  Set Variable If	
    ...     '${search_option}'=='${search engine['typesense']['search option']['basic']}'	                 search/typesense_without_filter_n_sort.json
    ...     '${search_option}'=='${search engine['typesense']['search option']['sort']}'                     search/typesense_with_sort.json
    ...     '${search_option}'=='${search engine['typesense']['search option']['filter']['availability']}'   search/typesense_with_filter_availability.json
    ...     '${search_option}'=='${search engine['typesense']['search option']['filter']['promotion']}'      search/typesense_with_filter_promotion.json
    ...     '${search_option}'=='${search engine['typesense']['search option']['filter']['price']}'          search/typesense_with_filter_price.json
    ...     '${search_option}'=='${search engine['typesense']['search option']['filter']['collection']}'     search/typesense_with_filter_collection.json
    ...     '${search_option}'=='${search engine['typesense']['search option']['filter']['brand']}'          search/typesense_with_filter_brand.json
    ...     '${search_option}'=='${search engine['typesense']['search option']['filter and sort']}'          search/typesense_with_filter_n_sort.json
    api_common.Update json Variable   ${jsonfile}     $.q                   ${querywording}
    api_common.Update json Variable   ${jsonfile}     $.filters.storeCode   ${querystore}
    [Return]    ${jsonfile}

### sort 
Generate query typesense with sort type
    [Arguments]     ${sortType}   ${search_option}=${search engine['typesense']['search option']['sort']}
    ${jsonfile} =  Set Variable If  
    ...     '${search_option}'=='${search engine['typesense']['search option']['sort']}'    search/typesense_with_sort.json
    ...     '${search_option}'=='${search engine['typesense']['search option']['filter and sort']}'    search/typesense_with_filter_n_sort.json
    api_common.Update json Variable   ${jsonfile}     $.sortBy              ${sortType}
    [Return]    ${jsonfile}

### filter 
Generate query typesense with filter price range
    [Arguments]     ${priceRange_from}=${search engine['typesense']['search option']['filter']['price_from_0']}    ${priceRange_to}=${search engine['typesense']['search option']['filter']['price_to_500']}  ${search_option}=${search engine['typesense']['search option']['filter']['price']}  
    ${jsonfile} =  Set Variable If  
    ...     '${search_option}' == '${search engine['typesense']['search option']['filter']['price']}'   search/typesense_with_filter_price.json 
    ...     '${search_option}' == '${search engine['typesense']['search option']['filter and sort']}'    search/typesense_with_filter_n_sort.json
    api_common.Update json Variable   ${jsonfile}     $.filters.priceRange.from     ${priceRange_from}
    api_common.Update json Variable   ${jsonfile}     $.filters.priceRange.to       ${priceRange_to} 
    [Return]    ${jsonfile}

Generate query typesense with filter collection
    [Arguments]    @{collection}     ${search_option}=${search engine['typesense']['search option']['filter']['collection']}   
    ${jsonfile} =  Set Variable If  
    ...     '${search_option}' == '${search engine['typesense']['search option']['filter']['collection']}'   search/typesense_with_filter_collection.json 
    ...     '${search_option}' == '${search engine['typesense']['search option']['filter and sort']}'    search/typesense_with_filter_n_sort.json
    api_common.Update json Variable   ${jsonfile}     $.filters.collections     @{collection}
    [Return]    ${jsonfile}

Generate query typesense with filter brand
    [Arguments]     @{brand}     ${search_option}=${search engine['typesense']['search option']['filter']['brand']}
    ${jsonfile} =  Set Variable If  
    ...     '${search_option}' == '${search engine['typesense']['search option']['filter']['brand']}'    search/typesense_with_filter_brand.json 
    ...     '${search_option}' == '${search engine['typesense']['search option']['filter and sort']}'    search/typesense_with_filter_n_sort.json
    api_common.Update json Variable   ${jsonfile}     $.filters.brands     @{brand} 
    [Return]    ${jsonfile}
    
Generate query typesense with filter type
    [Arguments]    ${search_option}     ${filterValue}
    ${jsonfile}=    Run keyword if  
    ...                 '${search_option}'=='${search engine['typesense']['search option']['filter']['price']}'         Generate query typesense with filter price range    ${filterValue}[0]   ${filterValue}[1]
    ...     ELSE IF     '${search_option}'=='${search engine['typesense']['search option']['filter']['collection']}'    Generate query typesense with filter collection     ${filterValue}
    ...     ELSE IF     '${search_option}'=='${search engine['typesense']['search option']['filter']['brand']}'         Generate query typesense with filter brand          ${filterValue}
    ...     ELSE IF     '${search_option}'=='${search engine['typesense']['search option']['filter']['availability']}'  Set variable   search/typesense_with_filter_availability.json
    ...     ELSE IF     '${search_option}'=='${search engine['typesense']['search option']['filter']['promotion']}'     Set variable   search/typesense_with_filter_promotion.json
    [Return]    ${jsonfile}

### search 
Search via typesense with keyword
    [Arguments]     ${querywording}   ${querystore}=${store_code['st4']}   ${jsonfile}=search/typesense_without_filter_n_sort.json    
    ${query_products}=  search_typesense_api.Generate query typesense with keyword and store     ${querywording}    ${querystore}
    ${response}=    search_typesense_api.Call typesense API     ${jsonfile}
    ${resp.body}        Set Variable           ${response.json()}
    [Return]    ${resp.body}

Search and sort via typesense with keyword
    [Arguments]     ${querywording}   ${querystore}=${store_code['st4']}   ${sortBy}=${search engine['typesense']['search option']['sort_by_relevance']}      ${jsonfile}=search/typesense_with_sort.json    
    ${query_products}=  search_typesense_api.Generate query typesense with keyword and store     ${querywording}    ${querystore}    search_option=${search engine['typesense']['search option']['sort']}
    ${query_products}=  search_typesense_api.Generate query typesense with sort type        ${sortBy}
    ${response}=    search_typesense_api.Call typesense API     ${jsonfile}
    ${resp.body}        Set Variable           ${response.json()}
    [Return]    ${resp.body}

Search and filter via typesense with keyword 
    [Arguments]     ${querywording}   ${querystore}=${store_code['st4']}  ${filterType}=${empty}  ${filterValue}=${empty}  
    ${query_products}=  search_typesense_api.Generate query typesense with keyword and store     ${querywording}    ${querystore}    search_option=${filterType}
    ${query_products}=  search_typesense_api.Generate query typesense with filter type    ${filterType}   ${filterValue}
    ${response}=    search_typesense_api.Call typesense API     ${query_products}
    ${resp.body}    Set Variable      ${response.json()}
    [Return]    ${resp.body}

Search and sort and filter via typesense with keyword
    [Arguments]     ${querywording}    
    ...     ${sortBy}
    ...     ${priceRange_from}  ${priceRange_to}
    ...     ${collection}
    ...     ${brand}
    ...     ${querystore}=${store_code['st4']}   
    ...     ${jsonfile}=search/typesense_with_filter_n_sort.json 
    ${query_products}=  search_typesense_api.Generate query typesense with keyword and store     ${querywording}        ${querystore}       search_option=${search engine['typesense']['search option']['filter and sort']}
    ${query_products}=  search_typesense_api.Generate query typesense with sort type             ${sortBy}                                  search_option=${search engine['typesense']['search option']['filter and sort']}
    ${query_products}=  search_typesense_api.Generate query typesense with filter price range    ${priceRange_from}     ${priceRange_to}    search_option=${search engine['typesense']['search option']['filter and sort']}
    ${query_products}=  search_typesense_api.Generate query typesense with filter collection     ${collection}     search_option=${search engine['typesense']['search option']['filter and sort']}
    ${query_products}=  search_typesense_api.Generate query typesense with filter brand          ${brand}           search_option=${search engine['typesense']['search option']['filter and sort']}
    ${response}=    search_typesense_api.Call typesense API     ${jsonfile}
    ${resp.body}        Set Variable           ${response.json()}
    [Return]    ${resp.body}

### Get resp body
Get total search result from resp   
    [Arguments]   ${queries_result}
    ${result}=  Get value from json       ${queries_result}   $.found
    ${result}=  Set Variable   ${result}[0] 
    [return]    ${result}

Get list search prediction result from resp 
    [Arguments]    ${queries_result}  
    ${result}=  Get value from json       ${queries_result}   $.querySuggestions..[document]..query
    [return]    ${result}

Get list product result from resp 
    [Arguments]    ${queries_result}  
    ${result}=  Get value from json       ${queries_result}   $.hits..document.title
    [return]    ${result}

Get inventory product search result from resp
    [Arguments]     ${queries_result}  ${productname}      
    ${result}=  Get value from json      ${queries_result}   $.hits[?(@.document.title=="${productname}")]..[inventoryQuantity]
    ${result}=  Set Variable   ${result}[0]
    [return]    ${result}

Get list barcode of product search result from resp
    [Arguments]     ${queries_result}   
    ${result}=  Get value from json      ${queries_result}    $.hits[?(@.document)]..[barcode]
    ${result}=  Set Variable   ${result}[0]
    [return]    ${result}

Get price and discont product search result from resp
    [Documentation]    
    [Arguments]     ${queries_result}  ${productname}      
    ${result}=  Get value from json      ${queries_result}      $.hits[?(@.document.title=="${productname}")]..[displayPrice,originalPrice]
    ${result}=  Set Variable   ${result}[0] 
    [return]    ${result}

Get promotion status of product search result from resp
    [Documentation]    hasPromotions = 0 > non-discount, hasPromotions = 1 > discount 
    [Arguments]     ${queries_result}  ${productname}      
    ${result}=  Get value from json      ${queries_result}      $.hits[?(@.document.title=="${productname}")]..[hasPromotions]
    ${result}=  Set Variable   ${result}[0] 
    [return]    ${result}

Get instock status of search result from resp
    [Arguments]     ${queries_result}
    ${result}=  Get value from json      ${queries_result}      $..inStock
    [return]    ${result}

Get price of search result from resp
    [Arguments]     ${queries_result}
    ${result}=  Get value from json      ${queries_result}      $..displayPrice
    log     ${result}
    [return]    ${result}

Get promotion status of search result from resp
    [Arguments]     ${queries_result}
    ${result}=  Get value from json      ${queries_result}      $..hasPromotions
    [return]    ${result}

Get publish at of search result from resp
    [Arguments]     ${queries_result}
    ${result}=  Get value from json      ${queries_result}      $..publishedAt
    [return]    ${result}

Get category of search result from resp
    [Arguments]     ${queries_result}
    ${result}=  Get value from json      ${queries_result}      $..collections
    [return]    ${result}

Get brand of search result from resp
    [Arguments]     ${queries_result}
    ${result}=  Get value from json      ${queries_result}      $..brand
    [return]    ${result}

### Verify result
Verify typesense suggestions result should contain keyword
    [Arguments]      ${queries_result}   ${querywording} 
    ${result_prediction}=  search_typesense_api.Get list search prediction result from resp  ${queries_result}
    FOR  ${predict}     IN    ${result_prediction}
        Should contain      ${predict}      ${querywording}
    END

Verify typesense products result should be equal
    [Arguments]    ${queries_result}    ${expected_result} 
    ${actual_total_result}=  search_typesense_api.Get total search result from resp     ${queries_result}   
    Should be equal     ${expected_result}      ${actual_total_result}

Verify typesense products result should not equal
    [Arguments]   ${queries_result}     ${expected_result}
    ${actual_total_result}=  search_typesense_api.Get total search result from resp     ${queries_result}
    Should not be equal     ${expected_result}      ${actual_total_result}

Verify typesense products result should contains product
    [Arguments]   ${queries_result}     ${expected_result} 
    ${actual_result_product}=   search_typesense_api.Get list product result from resp      ${queries_result}
    Should Contain Any      ${actual_result_product}    ${expected_result} 

Verify typesense products result should not contains product
    [Arguments]   ${queries_result}     ${expected_result} 
    ${actual_result_product}=   search_typesense_api.Get list product result from resp      ${queries_result}
    Should Not Contain Any    ${actual_result_product}      ${expected_result}

Verify typesense products result with quantity should be
    [Arguments]   ${queries_result}      ${productname}    ${expected_result}
    ${result_quantity}=  search_typesense_api.Get inventory product search result from resp    ${queries_result}  ${productname}
    Should be equal     ${expected_result}      ${result_quantity}

Verify typesense products result should match with barcode
    [Arguments]   ${queries_result}   ${expected_result}      
    ${actual_result_barcode}=     search_typesense_api.Get list barcode of product search result from resp      ${queries_result}
    FOR     ${item}    IN   ${actual_result_barcode}
        Should be equal	   ${item}    ${expected_result}
    END

Verify typesense result sort by instock status
    [Arguments]   ${queries_result}
    ${list_result}=    search_typesense_api.Get instock status of search result from resp   ${queries_result} 
    ${lengthList}=  Get Length      ${list_result}
    FOR  ${item}   IN RANGE   ${lengthList}
        Exit for loop if    ${${item}+${1}} == ${lengthList}   
        Should Be True	${list_result}[${item}]>=${list_result}[${${item}+${1}}]
    END

Verify typesense result sort by price low to high
    [Arguments]   ${queries_result} 
    ${list_result}=    search_typesense_api.Get price of search result from resp   ${queries_result} 
    ${lengthList}=  Get Length      ${list_result}
    FOR  ${item}   IN RANGE   ${lengthList}
        Exit for loop if    ${${item}+${1}} == ${lengthList}   
        Should Be True	${list_result}[${item}]<=${list_result}[${${item}+${1}}]
    END

Verify typesense result sort by price high to low 
    [Arguments]   ${queries_result} 
    ${list_result}=    search_typesense_api.Get price of search result from resp   ${queries_result} 
    ${lengthList}=  Get Length      ${list_result}
    FOR  ${item}   IN RANGE   ${lengthList}
        Exit for loop if    ${${item}+${1}} == ${lengthList}   
        Should Be True	${list_result}[${item}]>=${list_result}[${${item}+${1}}]
    END

Verify typesense result sort by promotion
    [Arguments]   ${queries_result} 
    ${list_result}=    search_typesense_api.Get promotion status of search result from resp   ${queries_result} 
    ${lengthList}=  Get Length      ${list_result}
    FOR  ${item}   IN RANGE   ${lengthList}
        Exit for loop if    ${${item}+${1}} == ${lengthList}   
        Should Be True	${list_result}[${item}]>=${list_result}[${${item}+${1}}]
    END

Verify typesense result sort by recently added
    [Arguments]   ${queries_result} 
    ${list_result}=    search_typesense_api.Get publish at of search result from resp   ${queries_result} 
    ${lengthList}=  Get Length      ${list_result}
    FOR  ${item}   IN RANGE   ${lengthList}
        Exit for loop if    ${${item}+${1}} == ${lengthList}  
        Should Be True	${list_result}[${item}]>=${list_result}[${${item}+${1}}]
    END

Verify typesense result filter by price 
    [Arguments]   ${queries_result}     ${expected_min}     ${expected_max}
    ${list_result}=    search_typesense_api.Get price of search result from resp   ${queries_result} 
    ${lengthList}=  Get Length      ${list_result}
    FOR  ${item}   IN RANGE   ${lengthList}
        Should Be True	${expected_min} < ${list_result}[${item}] < ${expected_max}
    END

Verify typesense result filter by category
    [Arguments]   ${queries_result}     @{expected}
    ${list_result}=    search_typesense_api.Get category of search result from resp   ${queries_result} 
    log  ${list_result}
    ${lengthList}=  Get Length      ${list_result}
    FOR  ${item}   IN RANGE   ${lengthList}
        Should Contain Any      ${list_result}[${item}]      @{expected}
    END

Verify typesense result filter by brand
    [Arguments]   ${queries_result}    @{expected}
    ${list_result}=    search_typesense_api.Get brand of search result from resp   ${queries_result} 
    log  ${list_result}
    ${lengthList}=  Get Length      ${list_result}
    FOR  ${item}   IN RANGE   ${lengthList}
        Should Contain Any      ${list_result}[${item}]      @{expected}
    END

Verify typesense result filter by availability
    [Documentation]  ${1} is true
    [Arguments]   ${queries_result}
    ${list_result}=    search_typesense_api.Get instock status of search result from resp   ${queries_result} 
    Should Not Contain Any    ${list_result}      ${0}

Verify typesense result filter by promotion
    [Documentation]  ${1} is true
    [Arguments]   ${queries_result}
    ${list_result}=    search_typesense_api.Get promotion status of search result from resp  ${queries_result} 
    Should Not Contain Any    ${list_result}      ${0}
*** Settings ***
Resource            ../../../resources/locators/web/search_makroproweb_locator.resource
Resource            ../../../common/web/web_common.resource

*** Keywords ***
Input search keyword
    [Arguments]     ${search_keyword}
    DobbyWebCommon.Click element when ready                ${search_makroproweb.txt_input_search} 
    search_makroproweb_page.Click x button clear input
    DobbyWebCommon.Input text to element when ready        ${search_makroproweb.txt_input_search}     ${search_keyword}

Click x button clear input
    [Documentation]     Cick x to clear input if x button display
    ${x_btn_display}    Run keyword and return status      DobbyWebCommon.Wait until element is visible except stale    ${search_makroproweb.btn_search_close}    timeout=${smallTimeout}
    IF    ${x_btn_display}==${True}
        DobbyWebCommon.Click element when ready            ${search_makroproweb.btn_search_close}
    END

Verify search topic highlight on all recommend keywords
    [Arguments]     ${highlight_keyword}
    ${suggest_list}      DobbyWebCommon.Get webelements when ready       ${search_makroproweb.txt_suggest_dropdown}
    ${total_suggest}     Get length              ${suggest_list}
    FOR    ${index}              IN RANGE              1             ${total_suggest}+1
        ${xpath_recom}           String.Remove string      ${search_makroproweb.txt_suggest_dropdown}       xpath=
        ${suggest_with_index}    Catenate    SEPARATOR=    (${xpath_recom})     [${index}]
        ${suggest_xpath}         Catenate    SEPARATOR=    xpath=    ${suggest_with_index}
        ${suggest_hightlight_text}      DobbyWebCommon.Get text from element when ready     ${suggest_with_index}       timeout=${halfTimeout}
        Should be equal     ${suggest_hightlight_text.lower()}           ${highlight_keyword.lower()}
    END

Get search recommend keyword
    SeleniumLibrary.Wait until element is visible    ${search_makroproweb.txt_result_list}
    ${recommend_element}      DobbyWebCommon.Get webelement when ready          ${search_makroproweb.txt_first_suggest}     timeout=${halfTimeout}
    ${recommend_text}         DobbyWebCommon.Get text from element when ready        ${recommend_element}       timeout=${halfTimeout}
    [Return]        ${recommend_text}
    
Click on search recommendation
    DobbyWebCommon.Click element when ready        ${search_makroproweb.txt_first_suggest}

Click product name on search result
    [Arguments]     ${product_name}
    ${product_locator}      String.Replace string       ${search_makroproweb.txt_product_name}   {{product_name}}     ${product_name}
    DobbyWebCommon.Click element when ready             ${product_locator}

Verify search result display search keyword correct
    [Arguments]     ${search_keyword}
    ${search_result_locator}    String.Replace string       ${search_makroproweb.txt_search_result}     {{search_keyword}}    ${search_keyword}
    DobbyWebCommon.Wait until element is visible except stale       ${search_result_locator}

Click add to basket by product name
    [Arguments]     ${product_name}
    ${product_name_add_btn_locator}     String.Replace string       ${search_makroproweb.btn_add_to_basket}     {{product_name}}     ${product_name}  
    DobbyWebCommon.Click element when ready        ${product_name_add_btn_locator}

Click see all button
    DobbyWebCommon.Click element when ready        ${search_makroproweb.btn_see_all}

Get qty product on search result
    [Arguments]     ${product_name}
    ${qty_locator}      String.Replace string      ${search_makroproweb.txt_qty}        {{product_name}}       ${product_name} 
    ${current_qty}      DobbyWebCommon.Get value from element when ready        ${qty_locator}
    [Return]            ${current_qty}
    
Verify out of stock button display
    [Arguments]     ${product_name}
    ${out_of_stock_locator}     String.Replace string       ${search_makroproweb.btn_of_product}      {{product_name}}     ${product_name}
    DobbyWebCommon.Wait until element is visible except stale       ${out_of_stock_locator}
    ${button_text}      DobbyWebCommon.Get text from element when ready     ${out_of_stock_locator}
    Should be equal     ${button_text.lower()}      ${web['labels']['outOfStock'].lower()}
    SeleniumLibrary.Element should be disabled                      ${out_of_stock_locator}

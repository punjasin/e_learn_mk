*** Settings ***
Resource            ../../../resources/locators/web/product_makroproweb_locator.resource
Resource            ../../../common/web/web_common.resource

*** Keywords ***
Click add to basket button
    [Arguments]     ${product_name}
    ${add_basket_btn_locator}       String.Replace string    ${product_makroproweb.btn_add_to_basket}       {{product_name}}    ${product_name}
    DobbyWebCommon.Click element when ready         ${add_basket_btn_locator}

Verify qty has been changed after clicked increase
    [Arguments]     ${add_amount}=1
    [Documentation]     KW allow multiple click + btn by ${add_amount} and get new_qty from current_qty+add_amount 
    ...                 to be expected value for compare with current value change correctly
    ${newqty}           web_common.Click increase qty  ${add_amount}  ${product_makroproweb.txt_quantity}  ${product_makroproweb.btn_add_item}
    ${current_qty}      product_makroproweb_page.Get current qty
    ${current_qty}      Convert to integer      ${current_qty}
    Should be equal     ${current_qty}      ${new_qty}

Verify qty has been changed after clicked decrease
    [Arguments]     ${del_amount}=1
    [Documentation]     KW allow multiple click - btn by ${del_amount} and get new_qty from current_qty-del_amount 
    ...                 to be expected value for compare with current value change correctly
    ${new_qty}          web_common.Click decrease qty  ${del_amount}  ${product_makroproweb.txt_quantity}  ${product_makroproweb.btn_decrease_item}
    ${current_qty}      product_makroproweb_page.Get current qty
    ${current_qty}      Convert to integer      ${current_qty}
    Should be equal    ${current_qty}      ${new_qty}

Get current qty
    ${current_qty}      DobbyWebCommon.Get value from element when ready        ${product_makroproweb.txt_quantity}
    [Return]            ${current_qty}

Verify out of stock button is display
    [Arguments]     ${product_name}
    ${out_of_stock_btn}     String.Replace string       ${product_makroproweb.btn_outofstock}     {{product_name}}     ${product_name}  
    DobbyWebCommon.Wait until element is visible except stale       ${out_of_stock_btn}

Verify delivery description product 1P display correct
    [Arguments]    ${product_name}
    ${banner_product_locator}        String.Replace string         ${product_makroproweb.txt_delivery_1P}    {{product_name}}    ${product_name}
    DobbyWebCommon.Wait until element is visible except stale      ${banner_product_locator}
    DobbyWebCommon.Wait until element is visible except stale      ${product_makroproweb.txt_order_before}
    DobbyWebCommon.Wait until element is visible except stale      ${product_makroproweb.txt_delivery1P_before}
    DobbyWebCommon.Wait until element is visible except stale      ${product_makroproweb.txt_order_after}
    DobbyWebCommon.Wait until element is visible except stale      ${product_makroproweb.txt_delivery1P_after}
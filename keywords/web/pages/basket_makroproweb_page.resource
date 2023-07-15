*** Settings ***
Resource            ../../../resources/locators/web/basket_makroproweb_locator.resource
Resource            ../../../common/web/web_common.resource

*** Keywords ***
Verify qty amount display as expected value
    [Arguments]    ${product_name}      ${expect}
    ${quantity}    basket_makroproweb_page.Get current qty  ${product_name}
    ${quantity}    Convert to integer      ${quantity}
    ${expect}      Convert to integer      ${expect}
    Should be equal    ${quantity}    ${expect}

Get current qty
    [Arguments]     ${product_name}
    ${qty_locator}      String.Replace string       ${basket_makroproweb.input_basket_item}     {{product_name}}    ${product_name}
    ${quantity}     DobbyWebCommon.Get value from element when ready    ${qty_locator}
    [Return]        ${quantity}

Wait until current qty show as expected value
    [Arguments]    ${product_name}    ${expected_qty}
    ${qty_locator}        String.Replace string     ${basket_makroproweb.txt_qty_value}    {{product_name}}    ${product_name}
    ${expected_qty}       Convert to string         ${expected_qty}
    ${qty_locator}        String.Replace string     ${qty_locator}        {{qty}}          ${expected_qty}
    DobbyWebCommon.Wait until element is visible except stale        ${qty_locator}        timeout=${halfTimeout}

Click add item icon
    [Arguments]     ${product_name}
    ${add_locator}      String.Replace string       ${basket_makroproweb.btn_add_item}     {{product_name}}    ${product_name}
    DobbyWebCommon.Click element when ready         ${add_locator}

Verify basket has been changed after quantity added
    [Arguments]         ${product_name}     ${add_amount}=1
    [Documentation]     KW allow multiple click + btn by ${add_amount} and get new_qty from current_qty+add_amount 
    ...                 to be expected value for compare with current value change correctly
    ${qty_locator}      String.Replace string       ${basket_makroproweb.input_basket_item}     {{product_name}}    ${product_name}
    ${add_locator}      String.Replace string       ${basket_makroproweb.btn_add_item}          {{product_name}}    ${product_name}
    ${new_qty}          web_common.Click increase qty  ${add_amount}  ${qty_locator}  ${add_locator}
    basket_makroproweb_page.Wait until current qty show as expected value    ${product_name}    ${new_qty}

Click remove item icon
    [Arguments]     ${product_name}
    ${del_locator}      String.Replace string       ${basket_makroproweb.btn_remove_item}     {{product_name}}    ${product_name}
    DobbyWebCommon.Click element when ready         ${del_locator}

Verify basket has been changed after quantity decreased
    [Arguments]    ${product_name}      ${del_amount}=1
    [Documentation]     KW allow multiple click - btn by ${del_amount} and get new_qty from current_qty-del_amount 
    ...                 to be expected value for compare with current value change correctly
    ${qty_locator}      String.Replace string       ${basket_makroproweb.input_basket_item}     {{product_name}}    ${product_name}
    ${del_locator}      String.Replace string       ${basket_makroproweb.btn_remove_item}       {{product_name}}    ${product_name}
    ${new_qty}          web_common.Click decrease qty  ${del_amount}  ${qty_locator}  ${del_locator}
    basket_makroproweb_page.Wait until current qty show as expected value    ${product_name}    ${new_qty}

Adjust input value to zero directly
    [Arguments]     ${product_name}
    ${qty_locator}      String.Replace string       ${basket_makroproweb.input_basket_item}     {{product_name}}    ${product_name}
    DobbyWebCommon.Click element when ready         ${qty_locator}
    SeleniumLibrary.Press keys    ${qty_locator}      DELETE
    SeleniumLibrary.Press keys    ${qty_locator}      TAB

Verify no items in basket
    DobbyWebCommon.Verify element text when ready    ${basket_makroproweb.txt_no_items}   ${web_additional['basket']['noBasket']} 

Close basket
    DobbyWebCommon.Click element when ready    ${basket_makroproweb.btn_close_basket}

Click bin icon
    [Arguments]     ${product_name}
    ${bin_locator}      String.Replace string       ${basket_makroproweb.btn_bin}     {{product_name}}    ${product_name}
    DobbyWebCommon.Click element when ready    ${bin_locator}

Verify basket header
    DobbyWebCommon.Wait until element is visible except stale     ${basket_makroproweb.basket_header}

Get total price
    ${total_price}    DobbyWebCommon.Get text from element when ready    ${basket_makroproweb.txt_total_price}
    [Return]          ${total_price}

Click make payment button
    DobbyWebCommon.Click element when ready        ${basket_makroproweb.btn_payment}

Verify vendor name with 1p
    [Arguments]    ${1p_vendor_name}
    ${vendor_locator}    String.Replace string    ${basket_makroproweb.txt_1p_vendor_name}    {{1p_vendor_name}}    ${1p_vendor_name}
    DobbyWebCommon.Wait until element is visible except stale     ${vendor_locator}  

Verify vendor name with 3p
    [Arguments]    ${3p_vendor_name}
    ${vendor_locator}    String.Replace string    ${basket_makroproweb.txt_3p_vendor_name}    {{3p_vendor_name}}    ${3p_vendor_name}
    DobbyWebCommon.Wait until element is visible except stale     ${vendor_locator}

Get product price
    [Arguments]    ${product_name}
    ${product_price_locator}        String.Replace string    ${basket_makroproweb.txt_product_price}    {{product_name}}    ${product_name}
    ${price_element}      DobbyWebCommon.Get webelement when ready             ${product_price_locator}
    ${price_text}         DobbyWebCommon.Get text from element when ready      ${price_element}
    [Return]              ${price_text}

Get total products by bin icon
    ${all_btn}        DobbyWebCommon.Get webelements when ready    ${basket_makroproweb.btn_all_bin}
    ${total_bin}      Get length        ${all_btn}
    [Return]          ${total_bin}
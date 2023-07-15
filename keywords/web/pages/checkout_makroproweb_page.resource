*** Settings ***
Resource            ../../../resources/locators/web/checkout_makroproweb_locator.resource
Resource            ../../../common/web/web_common.resource

*** Keywords ***
Verify checkout header
    DobbyWebCommon.Wait until element is visible except stale       ${checkout_makroproweb.checkout_header} 

Click target slot date
    ${full_date}    web_common.Get date by count day after today date
    ${full_date}    String.Split string      ${full_date}        ${space}
    ${slot_date}    Catenate    SEPARATOR=${space}    ${full_date[0]}    ${full_date[1]}
    ${slot_date_locator}    String.Replace String    ${checkout_makroproweb.txt_slot_date}    {{slot_date}}    ${slot_date}
    DobbyWebCommon.Click element when ready    ${slot_date_locator}

Click last deliverytime
    DobbyWebCommon.Click element when ready    ${checkout_makroproweb.last_deliverytime_timeslot}

Format full delivery date for product 1P
    [Documentation]      en: Wed 24 May 13:02 - 14:00, th: พุธ 24 พ.ค. 13:02 - 14:00
    [Arguments]        ${delivery_date}
    ${original_text}     String.Remove string    ${delivery_date}   ${web_additional['checkout']['deliveredBy']}${SPACE}
    ${parts}             String.Split string     ${original_text}   ${SPACE}
    ${day_with_week}     Catenate    SEPARATOR=${SPACE}    ${parts[0]}    ${parts[1]}
    ${format_date}       checkout_makroproweb_page.Convert delivery date format to be order history date format     ${day_with_week}
    ${delivery_time}     Catenate    SEPARATOR=${SPACE}    ${parts[2]}    ${parts[3]}    ${parts[4]}
    ${full_delivery_date}    Catenate    SEPARATOR=${space}    ${format_date}     ${delivery_time}
    [Return]            ${full_delivery_date}

Convert delivery date format to be order history date format
    [Arguments]        ${day_with_week}
    [Documentation]    input:  26 Fri, output en: Fri 26 May, output th: ศุกร์ 26 พ.ค.
    ${original_date}    String.Split string    ${day_with_week}    ${SPACE}
    IF  "${lang}"=="en"
        ${new_date}         Catenate    SEPARATOR=${SPACE}    ${original_date[1]}    ${original_date[0]}
    ELSE
        ${full_day_name}    web_common.Get full day of week by short day    ${original_date[1]}
        ${th_day}           DobbyCommon.Get day of week in thai    ${full_day_name}
        ${new_date}         Catenate    SEPARATOR=${SPACE}     ${th_day}    ${original_date[0]}
    END
    ${current_month}        web_common.Get delivery month
    ${new_format_date}      Catenate    SEPARATOR=${SPACE}    ${new_date}     ${current_month}
    [Return]            ${new_format_date}

Format full delivery date for product 3P
    [Arguments]        ${delivery_date}
    [Documentation]    convert from 'Deliver by 26 Fri - 28 Sun' to be
    ...       en: 'Fri 26 May - Sun 28 May' th: 'ศุกร์ 26 พ.ค. - อาทิตย์ 28 พ.ค.'
    ${original_text}     String.Remove string    ${delivery_date}   ${web_additional['checkout']['deliveredBy']}${SPACE} 
    ${parts}             String.Split string     ${original_text}   ${SPACE}-${SPACE}
    ${format_from_date}    checkout_makroproweb_page.Convert delivery date format to be order history date format    ${parts[0]}
    ${format_to_date}      checkout_makroproweb_page.Convert delivery date format to be order history date format    ${parts[1]}

    ${new_format_date}    Catenate    SEPARATOR=${SPACE}    ${format_from_date}     -    ${format_to_date}
    [Return]              ${new_format_date}
    
Get time from delivery date for product 3P
    [Arguments]    ${delivery_from}
    ${deliverydatefrom_locator}    String.Replace string    ${checkout_makroproweb.txt_selectyourdeliveryslot}   {{delivery_from_name}}    ${delivery_from}
    SeleniumLibrary.Wait until page does not contain element    ${deliverydatefrom_locator}
    ${deliverydate_locator}    String.Replace string    ${checkout_makroproweb.txt_deliverydate}   {{delivery_from_name}}    ${delivery_from}
    DobbyWebCommon.Scroll element into view when ready          ${deliverydate_locator}
    ${delivery_text}    DobbyWebCommon.Get text from element when ready    ${deliverydate_locator}
    [Return]    ${delivery_text}

Get time from delivery date for product 1P
    ${deliverydatefrom_locator}    String.Replace string    ${checkout_makroproweb.txt_selectyourdeliveryslot}   {{delivery_from_name}}    ${product_common['1P_basket_seller']}
    SeleniumLibrary.Wait until page does not contain element    ${deliverydatefrom_locator}
    DobbyWebCommon.Scroll element into view when ready      ${checkout_makroproweb.txt_1p_delivery_by}
    ${delivery_text}    DobbyWebCommon.Get text from element when ready     ${checkout_makroproweb.txt_1p_delivery_by}
    [Return]    ${delivery_text}

Verify order completed
    DobbyWebCommon.Wait until element is visible except stale      ${checkout_makroproweb.order_completed}        timeout=${longTimeout}

Click view my order button
    DobbyWebCommon.Click element when ready                        ${checkout_makroproweb.btn_view_my_order}
    web_common.Wait for page load

Verify total price is correct
    [Arguments]    ${expected_price}
    ${total_price}    DobbyWebCommon.Get text from element when ready    ${checkout_makroproweb.txt_total_price}
    Should be equal    ${total_price}    ${expected_price}

Click go to payment button
    DobbyWebCommon.Click element when ready       ${checkout_makroproweb.btn_gotopayment}
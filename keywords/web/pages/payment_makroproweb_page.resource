*** Settings ***
Resource            ../../../resources/locators/web/payment_makroproweb_locator.resource
Resource            ../../../common/web/web_common.resource

*** Keywords ***
Verify select payment channel header display
    DobbyWebCommon.Wait until element is visible except stale       ${payment_makroproweb.txt_payment_header}

Select payment channel
    [Arguments]    ${payment_channel}
    ${payment_channel_locator}        String.Replace string      ${payment_makroproweb.txt_payment_option}    {{payment_option}}    ${payment_channel}
    DobbyWebCommon.Click element when ready           ${payment_channel_locator}

Input credit/debit card number
    [Arguments]     ${card_number}
    DobbyWebCommon.Input text to element when ready      ${payment_makroproweb.txt_card_number}        ${card_number}

Input card holder name
    [Arguments]     ${card_name}
    DobbyWebCommon.Input text to element when ready      ${payment_makroproweb.txt_card_holder_name}    ${card_name}

Input expiry card
    [Arguments]    ${expiry}
    DobbyWebCommon.Input text to element when ready      ${payment_makroproweb.txt_expiry_date}         ${expiry}

Input cvv number
    [Arguments]    ${cvv}
    DobbyWebCommon.Input text to element when ready      ${payment_makroproweb.txt_cvv}            ${cvv}

Click toggle switch save card data
    DobbyWebCommon.Click element when ready             ${payment_makroproweb.btn_switch}
    DobbyWebCommon.Wait until element is visible except stale       ${payment_makroproweb.btn_switch_enable}

Click pay amount button
    [Arguments]    ${total_price}
    ${pay_amount_locator}    String.Replace string    ${payment_makroproweb.btn_pay_amount}    {{amount}}    ${total_price}
    DobbyWebCommon.Click element when ready           ${pay_amount_locator}

Verify your payment was decline display
    DobbyWebCommon.Wait until element is visible except stale       ${payment_makroproweb.txt_payment_was_declined}        timeout=${longTimeout}

Click back to merchant button
    DobbyWebCommon.Click element when ready           ${payment_makroproweb.btn_back_to_merchant}

Verify your payment unsuccessful display
    DobbyWebCommon.Wait until element is visible except stale       ${payment_makroproweb.txt_payment_unsuccessful}
    DobbyWebCommon.Wait until element is visible except stale       ${payment_makroproweb.txt_payment_unsuccessful_description}
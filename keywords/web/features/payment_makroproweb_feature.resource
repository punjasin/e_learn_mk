*** Settings ***
Resource            ../pages/payment_makroproweb_page.resource
Resource            ../features/2c2p_portal_feature.resource
Resource            ../pages/checkout_makroproweb_page.resource

*** Keywords ***
Select payment channel
    [Arguments]     ${payment_channel}
    payment_makroproweb_page.Verify select payment channel header display
    payment_makroproweb_page.Select payment channel            ${payment_channel}
    
Input credit/debit detail
    [Arguments]    ${card_data}        ${total_price}
    payment_makroproweb_page.Input credit/debit card number    ${card_data['credit_number']}
    payment_makroproweb_page.Input card holder name            ${card_data['credit_holder_name']}
    payment_makroproweb_page.Input expiry card                 ${card_data['credit_expiry']}
    payment_makroproweb_page.Input cvv number                  ${card_data['credit_cvv']}
    payment_makroproweb_page.Click toggle switch save card data
    payment_makroproweb_page.Click pay amount button           ${total_price}
    web_common.Wait for page load

Verify payment unsuccessful
    payment_makroproweb_page.Verify your payment was decline display
    payment_makroproweb_page.Click back to merchant button

Process to payment by credit card successful
    [Arguments]     ${credit_card_detail}     ${total_price}
    payment_makroproweb_feature.Select payment channel      ${web_additional['payment']['creditDebit']}
    payment_makroproweb_feature.Input credit/debit detail   ${credit_card_detail}    ${total_price}
    2c2p_portal_feature.Verify card information and submit
    2c2p_portal_feature.Input otp and submit                ${credit_card_detail['otp']}
    checkout_makroproweb_page.Verify order completed
*** Settings ***
Resource            ../pages/checkout_makroproweb_page.resource

*** Keywords ***
Verify different delivery date and time slot from vendor
    [Documentation]    delivery date of p1_vendor will change but p3_vendor will not change when click change deliverytime slot
    [Arguments]   ${p1_vendor}   ${p3_vendor}
    checkout_makroproweb_page.Verify checkout header

    ${before_delivery_from_makro_pro}    checkout_makroproweb_page.Get time from delivery date for product 1P
    ${before_delivery_from_doppio_tech}  checkout_makroproweb_page.Get time from delivery date for product 3P   ${p3_vendor}

    checkout_makroproweb_page.Click target slot date
    checkout_makroproweb_page.Click last deliverytime

    ${after_delivery_from_makro_pro}    checkout_makroproweb_page.Get time from delivery date for product 1P
    ${after_delivery_from_doppio_tech}  checkout_makroproweb_page.Get time from delivery date for product 3P   ${p3_vendor}

    Should be equal as strings        ${before_delivery_from_doppio_tech}    ${after_delivery_from_doppio_tech}  
    Should not be equal as strings    ${beforedelivery_from_makro_pro}       ${after_delivery_from_makro_pro}

    ${format_date_1P}    checkout_makroproweb_page.Format full delivery date for product 1P      ${after_delivery_from_makro_pro}
    ${format_date_3P}    checkout_makroproweb_page.Format full delivery date for product 3P      ${after_delivery_from_doppio_tech}
    [Return]             ${format_date_1P}        ${format_date_3P}
    
Verify total price and go to payment
    [Arguments]       ${total_price}
    checkout_makroproweb_page.Verify total price is correct    ${total_price}
    checkout_makroproweb_page.Click go to payment button
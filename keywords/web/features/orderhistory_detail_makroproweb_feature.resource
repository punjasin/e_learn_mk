*** Settings ***
Resource            ../pages/orderhistory_detail_makroproweb_page.resource
Resource            ../pages/orderhistory_makroproweb_page.resource

*** Keywords ***
Verify delivery information correct
    [Arguments]     ${order_detail}
    ${total_product}     Convert To integer    ${order_detail['total_product']}
    FOR    ${index}      IN RANGE    1    ${total_product}+1
        orderhistory_makroproweb_page.Verify order history header display
        ${seller_order}       Catenate      SEPARATOR=   seller_product_   ${index}
        ${order_id}    orderhistory_makroproweb_page.Get last order number by seller name    ${order_detail['${seller_order}']}
        orderhistory_makroproweb_page.Verify total orders should equal to total products     ${order_detail['total_product']}    ${order_id}
        orderhistory_makroproweb_page.Click target order by seller              ${order_detail['${seller_order}']}
        ${delivery_date}     Catenate      SEPARATOR=   delivery_product_   ${index}
        orderhistory_detail_makroproweb_page.Verify order number with delivery date display    ${order_id}    ${order_detail['${delivery_date}']}
        ${product_qty}       Catenate      SEPARATOR=   qty_product_   ${index}
        orderhistory_detail_makroproweb_page.Verify product quantity is correct   ${order_detail['${product_qty}']}
        orderhistory_detail_makroproweb_page.Verify payment method is correct     ${order_detail['payment_method']}
        orderhistory_detail_makroproweb_page.Verify payment status is correct     ${order_detail['payment_status']}
        orderhistory_detail_makroproweb_page.Click back to history page
        orderhistory_makroproweb_page.Verify order status should be expected      ${order_detail['${seller_order}']}    ${order_detail['order_status']}
    END
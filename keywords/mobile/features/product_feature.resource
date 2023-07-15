*** Settings ***
Resource        ../pages/product_page.resource
Resource        ../pages/productcard_page.resource
Resource        ../pages/search_page.resource
Resource        ../pages/home_page.resource

*** Keywords ***
Verify product detail
    [Arguments]     ${product_detail}       ${price}    ${volume_unit}=cm
    product_page.Verify product price at PDP    ${price}
    product_page.Verify product title at PDP    ${product_detail['productname']}
    product_page.Verify product unit at PDP     ${product_detail['size']}
    IF   "${product_detail['seller']}"=="${seller_name['1P_shop']}"
        product_page.Verify 1P delivery time at PDP
    ELSE
        product_page.Verify expected delivery date at PDP   ${product_detail['min_delivery_day']}     ${product_detail['max_delivery_day']}
    END
    product_page.Verify description at PDP      ${product_detail['long_description_${lang}']}
    product_page.Verify seller name at PDP      ${product_detail['seller']}
    product_page.Click expand detail button
    ${totalvolume}    Set variable    ${product_detail['packaging_width']} x ${product_detail['packaging_depth']} x ${product_detail['packaging_height']} ${volume_unit}, ${product_detail['weight']}${product_detail['weight_unit']}
    ${full_totalvolume}    String.Replace string    ${totalvolume}    .00    ${empty}  
    product_page.Verify total volume at PDP     ${full_totalvolume}
    product_page.Verify product code at PDP     ${product_detail['provider_code']}

Verify discount percentage is correct
    [Arguments]     ${original_price}       ${discount_price}
    product_page.Verify unit price at PDP          ${original_price}
    product_page.Verify discounted price at PDP    ${discount_price}
    product_page.Verify correct percentage of discount at PDP

Verify quantity in basket after click increase or decrease button
    [Arguments]     ${product_name}     ${increase_amount}      ${decrease_amount}      ${qty}=${default['qty_basket']}  
    [Documentation]  This kw can use verify product qty in search page, product page and cart page
    productcard_page.Verify qty product display correct         ${product_name}       ${qty}
    ${qty_after_added}    product_feature.Update and increase quantity    ${product_name}    ${increase_amount}    ${qty}
    ${qty_after_del}      product_feature.Update and decrease quantity    ${product_name}    ${decrease_amount}    ${qty_after_added}
    mobile_common.tap basket menu
    basket_page.Verify product and quantity display in basket   ${product_name}     ${qty_after_del}
    [Return]                ${qty_after_del}

Update and increase quantity
    [Arguments]    ${product_name}    ${increase_amount}    ${default_qty}=1
    productcard_page.Open update quantity    ${product_name}    ${default_qty}
    product_page.Increase quantity by clicking on PDP         ${product_name}   ${increase_amount}
    ${qty_after_added}      mobile_common.Get new qty after click increase button      ${default_qty}       ${increase_amount}
    productcard_page.Update basket    ${product_name}
    productcard_page.Verify qty product display correct         ${product_name}       ${qty_after_added}
    [Return]    ${qty_after_added}

Update and decrease quantity
    [Arguments]    ${product_name}    ${decrease_amount}    ${default_qty}=1
    productcard_page.Open update quantity    ${product_name}    ${default_qty}
    product_page.Decrease quantity by clicking on PDP   ${decrease_amount}
    ${qty_after_del}        mobile_common.Get new qty after click decrease button  ${default_qty}     ${decrease_amount}
    productcard_page.Update basket    ${product_name}
    productcard_page.Verify qty product display correct         ${product_name}      ${qty_after_del}
    [Return]    ${qty_after_del}

Verify error after input qty exceed stock at PDP
    [Arguments]     ${product_name}    ${product_qty_exceed}    ${product_qty}=1
    product_page.Adjust quantity by typing on PDP    ${product_qty_exceed}
    product_page.Verify alert product exceed display
    product_page.Verify product quantity at PDP not equal       ${product_name}       ${product_qty_exceed}

Verify error after input qty exceed stock at product card
    [Arguments]     ${product_name}    ${product_qty_exceed}    ${product_qty}=1
    productcard_page.Open update quantity    ${product_name}    ${product_qty}
    search_page.Adjust quantity by typing quantity at search results     ${product_name}   ${product_qty_exceed}
    productcard_page.Update basket    ${product_name}
    product_page.Verify alert product exceed display     
    product_page.Find product on list    ${product_name}
    productcard_page.Verify product quantity at product card not equal      ${product_name}        ${product_qty_exceed}

Verify error after input qty exceed stock after search at product card
    [Arguments]     ${product_name}    ${product_qty_exceed}    ${product_qty}=1
    productcard_page.Open update quantity    ${product_name}    ${product_qty}
    search_page.Adjust quantity by typing quantity after search    ${product_name}   ${product_qty_exceed}
    productcard_page.Update basket    ${product_name}
    product_page.Verify alert product exceed display      
    productcard_page.Verify product quantity at product card not equal      ${product_name}        ${product_qty_exceed}

Tap see all from home section and verify all product have target badge
    [Arguments]     ${badge_name}       ${promotion_product_name}   ${no_promotion_product_name}
    [Documentation]     Example: Tap see all fresh section on home page and verify fresh badge in product list
    mobile_common.Tap shopping menu  accept_popup=${FALSE}
    home_page.Verify target category name display on home page      ${badge_name}
    home_page.Tap see all category                                  ${badge_name}
    productcard_page.Verify target badge display on product card    ${badge_name}  ${no_promotion_product_name}
    productcard_page.Verify product not has percent discount        ${no_promotion_product_name}
    productcard_page.Verify target badge display on product card    ${badge_name}  ${promotion_product_name}
    productcard_page.Verify product has percent discount            ${promotion_product_name}
    productcard_page.Tap add to basket button                       ${promotion_product_name}
    productcard_page.Update basket                                  ${promotion_product_name}

Get discount price and original price from product
    [Arguments]     ${product}
    ${discount_price}       product_page.Get discount price from product        ${product}
    ${original_price}       product_page.Get original price from product        ${product}
    [Return]                ${discount_price}       ${original_price}
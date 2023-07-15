*** Settings ***
Resource        ../../../resources/locators/${platform}/voucher_locator.resource
Resource        ../../../resources/locators/${platform}/common_locator.resource
Resource        ../../../common/mobile/mobile_common.resource

*** Keywords ***
Click open voucher section
    DobbyAppCommon.Tap element when ready           ${voucher.icon_button}
    DobbyAppCommon.Wait until element is visible except stale  ${voucher.vocuher_input}     

Verify voucher form is display
    DobbyAppCommon.Wait until element is visible except stale   ${voucher.txt_voucher}      timeout=${shortTimeout}

Verify voucher form is not display
    ${is_visibled}     Run keyword and return status    voucher_page.Verify voucher form is display
    Should be equal     ${is_visibled}   ${False}

Click close voucher section
    IF   "${platform}" == "${platform_list['android']}"
        DobbyAppCommon.Tap element when ready  ${voucher.icon_button}
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        DobbyAppCommon.Tap element when ready  ${voucher.icon_button_2}
    END

Enter voucher code on basket page
    [Arguments]     ${code}
    DobbyAppCommon.Input text to element when ready  ${voucher.vocuher_input}  ${code}

Click apply voucher code on basket page
    DobbyAppCommon.Tap element when ready   ${voucher.vocuher_apply_button}
    mobile_common.Wait until loading complete

Toast message should display applied code success
    [Documentation]     please input ${discount} in 2 decimal like 99.00
    [Arguments]     ${code}     ${discount}
    ${code_locator}    String.Replace string    ${voucher.txt_toast_success}     {{code}}    ${code}
    ${txt_toast_success_locator}    String.Replace string    ${code_locator}     {{discount}}    ${discount}
    mobile_common.Toast message should display and close       ${txt_toast_success_locator}
    
Toast message should display applied code fail 
    [Arguments]     ${code}
    ${txt_code_cannot_use_locator}    String.Replace string    ${voucher.txt_code_cannot_use}     {{voucherName}}    ${code}
    mobile_common.Toast message should display and close   ${txt_code_cannot_use_locator}
    
Verify voucher code applied success
    [Documentation]     please input ${discount} in 2 decimal like 99.00
    [Arguments]     ${code}     ${discount}
    ${txt_code_voucher_badge_locator}    String.Replace string    ${voucher.txt_code_voucher_badge}     {{code}}    ${code}
    ${txt_discount_locator}    String.Replace string    ${voucher.txt_discount}     {{discount}}    ${discount}
    DobbyAppCommon.Find element      ${txt_code_voucher_badge_locator}   scroll_panel=${default_scroll_view}    moveto=Top    percent=${swipeLongScroll}      timeout=${shortTimeout}
    DobbyAppCommon.Find element      ${txt_discount_locator}   scroll_panel=${default_scroll_view}    moveto=Top    percent=${swipeLongScroll}      timeout=${shortTimeout}

Verify voucher code not applied on basket page
    mobile_common.Wait until loading complete
    AppiumLibrary.Wait until page does not contain element   ${voucher.basket_summary_section_voucher_badge}

Click x button to remove voucher code on basket page
    [Arguments]     ${code}
    IF   "${platform}" == "${platform_list['android']}"
        ${btn_delete_voucher_locator}    String.Replace string    ${voucher.btn_delete_voucher}     {{code}}    ${code}
        DobbyAppCommon.Tap element when ready   ${btn_delete_voucher_locator}
        voucher_page.Verify voucher code not applied on checkout page
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        DobbyAppCommon.Tap element when ready   ${voucher.basket_summary_section_voucher_badge}
        voucher_page.Verify voucher code not applied on checkout page
    END

### checkout - order summary 
Enter voucher code on checkout order summary page
    [Arguments]     ${code}
    IF   "${platform}" == "${platform_list['android']}"
        DobbyAppCommon.Input text to element when ready     ${voucher.checkout_reduction_code}      ${code}
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        DobbyAppCommon.Tap element when ready       ${voucher.complementary}
        DobbyAppCommon.Input text to element when ready     ${voucher.complementary}     ${code}
        ${complementary_code_locator}    String.Replace string    ${voucher.complementary_code}     {{code}}    ${code}
        DobbyAppCommon.Wait until element is visible except stale       ${complementary_code_locator}
    END

### checkout - step 3
Enter voucher code on checkout step 3 page
    [Arguments]     ${code}
    IF   "${platform}" == "${platform_list['android']}"
        DobbyAppCommon.Input text to element when ready     ${voucher.checkout_reduction_code_mobile}      ${code}
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        DobbyAppCommon.Input text to element when ready     ${voucher.main_voucher}      ${code}
    END

Click apply voucher code on checkout page
    IF   "${platform}" == "${platform_list['android']}"
        DobbyAppCommon.Tap element when ready   ${voucher.btn_checkout_submit}
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        DobbyAppCommon.Tap element when ready    ${voucher.use_voucher}
    END

Scroll to voucher section
    IF   "${platform}" == "${platform_list['android']}"
        mobile_common.Find element     ${voucher.checkout_reduction_code_mobile}
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        mobile_common.Find element     ${voucher.main_voucher}
    END

Verify voucher code applied on checkout page
    [Arguments]     ${code}
    IF   "${platform}" == "${platform_list['android']}"
        ${btn_delete_voucher_locator}    String.Replace string    ${voucher.btn_delete_voucher}     {{code}}    ${code}
        DobbyAppCommon.Wait until element is visible except stale   ${btn_delete_voucher_locator}
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        ${txt_code}    String.Replace string    ${voucher.txt_code}     {{code}}    ${code}
        mobile_common.Wait until loading complete
        DobbyAppCommon.Wait until page contain element except stale  ${txt_code}
    END

Verify voucher code applied to product in line item on order summary
    [Documentation]     please input ${discount}  ${beforediscount}  ${afterdiscount} in 2 decimal like 99.00
    [Arguments]     ${productname}      ${code}     ${discount}     ${beforediscount}       ${afterdiscount}
    ${productname_code_discount_locator}    String.Replace string    ${voucher.productname_code_discount}     {{productname}}    ${productname}
    ${productname_code_locator}    String.Replace string    ${productname_code_discount_locator}     {{code}}    ${code}
    ${productname_code_discount_full_locator}    String.Replace string    ${productname_code_locator}     {{discount}}    ${discount}

    ${before_baht_locator}    String.Replace string    ${voucher.before_discount_baht}     {{productname}}    ${productname}
    ${before_discount_baht_locator}    String.Replace string    ${before_baht_locator}     {{beforediscount}}    ${beforediscount}

    ${after_locator}    String.Replace string    ${voucher.after_discount}     {{productname}}    ${productname}
    ${after_discount_locator}    String.Replace string    ${after_locator}     {{afterdiscount}}    ${afterdiscount}

    DobbyAppCommon.Wait until element is visible except stale   ${productname_code_discount_full_locator}
    DobbyAppCommon.Wait until element is visible except stale   ${before_discount_baht_locator}
    DobbyAppCommon.Wait until element is visible except stale   ${after_discount_locator}

Verify voucher code not applied to product in line item on order summary
    [Arguments]     ${productname}      ${beforediscount}
    ${productname_locator}    String.Replace string    ${voucher.before_discount}     {{productname}}    ${productname}
    ${before_discount_locator}    String.Replace string    ${productname_locator}     {{beforediscount}}    ${beforediscount}
    DobbyAppCommon.Wait until element is visible except stale   ${before_discount_locator}
    
Verify amount total after applied voucher code on order summary
    [Documentation]     please input ${beforediscount}  ${afterdiscount} in 2 decimal like 99.00
    [Arguments]     ${beforediscount}       ${afterdiscount}
    IF   "${platform}" == "${platform_list['android']}"
        ${afterdiscount_locator}    String.Replace string    ${voucher.sale_price}     {{afterdiscount}}    ${afterdiscount}
        ${sale_price_locator}       String.Replace string    ${afterdiscount_locator}     {{beforediscount}}    ${beforediscount}
        DobbyAppCommon.Wait until element is visible except stale   ${sale_price_locator}
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        ${before_sale_price_locator}       String.Replace string    ${voucher.before_sale_price}     {{beforediscount}}    ${beforediscount}
        ${after_sale_price_locator}    String.Replace string    ${voucher.after_sale_price}     {{afterdiscount}}    ${afterdiscount}
        DobbyAppCommon.Wait until page contain element except stale   ${before_sale_price_locator}
        DobbyAppCommon.Wait until page contain element except stale   ${after_sale_price_locator}
    END

Error apply invalid code should display on checkout page
    DobbyAppCommon.Wait until element is visible except stale   ${voucher.error_for_reduction_code}
    
Alert apply code fail should display on checkout page
    [Arguments]     ${code}
    IF   "${platform}" == "${platform_list['android']}"
        ${conditions_not_met_locator}       String.Replace string    ${voucher.conditions_not_met}     {{code}}    ${code}
        DobbyAppCommon.Wait until element is visible except stale   ${conditions_not_met_locator}
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        ${status_code_locator}       String.Replace string    ${voucher.status_code}     {{code}}    ${code}
        DobbyAppCommon.Wait until element is visible except stale   ${voucher.code_discount}
        DobbyAppCommon.Wait until element is visible except stale   ${status_code_locator}
        DobbyAppCommon.Wait until element is visible except stale   ${voucher.conditions_not_met}
    END

Click x botton on alert apply code fail
    [Arguments]     ${code}
    IF   "${platform}" == "${platform_list['android']}"
        ${btn_remove_voucher_locator}       String.Replace string    ${voucher.btn_remove_voucher}     {{code}}    ${code}
        ${conditions_not_met_locator}       String.Replace string    ${voucher.conditions_not_met}     {{code}}    ${code}
        DobbyAppCommon.Tap element when ready   ${btn_remove_voucher_locator}
        AppiumLibrary.Wait until page does not contain element    ${conditions_not_met_locator}
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        DobbyAppCommon.Tap element when ready   ${voucher.btn_remove_voucher}
    END

Verify voucher code not applied on checkout page
    IF   "${platform}" == "${platform_list['android']}"
        AppiumLibrary.Wait until page does not contain element    ${voucher.btn_remove_discount}
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        AppiumLibrary.Wait until page does not contain element    ${voucher.basket_summary_section_voucher_badge}
    END

Verify incorrect code error message
    [Arguments]     ${error_message}
    ${error_message_locator}       String.Replace string    ${voucher.error_message}     {{error_message}}    ${error_message}
    DobbyAppCommon.Wait until element is visible except stale   ${error_message_locator}
    
# Android

# iOS
Click apply voucher code on checkout order summary page
    DobbyAppCommon.Tap element when ready     ${voucher.complementary_voucher}
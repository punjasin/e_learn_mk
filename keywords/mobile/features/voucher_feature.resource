*** Settings ***
Resource        ../pages/voucher_page.resource

*** Keywords ***
Apply voucher code on basket page
    [Arguments]    ${voucher_code}      ${voucher_price}=0      ${clear_text}=False
    IF  '${clear_text}'=='False'
        voucher_page.Click open voucher section
    END
    voucher_page.Enter voucher code on basket page  ${voucher_code}
    voucher_page.Click apply voucher code on basket page

Apply voucher code on order summary page
    [Arguments]    ${voucher_code}
    IF   "${platform}" == "${platform_list['android']}"
        voucher_page.Enter voucher code on checkout order summary page      ${voucher_code}
        DobbyAppCommon.Hide keyboard until success
        voucher_page.Click apply voucher code on checkout page
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        voucher_page.Enter voucher code on checkout order summary page      ${voucher_code}
        voucher_page.Click apply voucher code on checkout page
    END

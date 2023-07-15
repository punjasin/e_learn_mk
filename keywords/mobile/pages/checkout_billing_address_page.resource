*** Settings ***
Resource        ../../../resources/locators/${platform}/checkout_locator.resource
Resource        ../../../resources/locators/${platform}/common_locator.resource
Resource        ../../../resources/locators/${platform}/2c2p_locator.resource
Resource        ../../../common/mobile/mobile_common.resource

*** Keywords ***
Select same billing address
    DobbyAppCommon.Tap element when ready     ${checkout_billing.btn_same_as_shipping_address}

Tap change delivery slot
    DobbyAppCommon.Tap element when ready     ${checkout_billing.change_date_and_time}

Select different billing address
    [Documentation]     address slot 1 = first address
    [Arguments]     ${blllingslot}=2    ${addr2}=${empty}
    IF   "${platform}" == "${platform_list['android']}"
        DobbyAppCommon.Swipe down
        ${txt_blllingslot_locator}    String.Replace string    ${checkout_billing.txt_blllingslot}    {{blllingslot}}    ${blllingslot}
        DobbyAppCommon.Tap element when ready         ${checkout_billing.btn_use_other_for_tax_invoices}
        DobbyAppCommon.Tap element when ready         ${checkout_billing.spin_checkout_billing_address_id}
        DobbyAppCommon.Tap element when ready         ${txt_blllingslot_locator}
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        DobbyAppCommon.Tap element when ready   ${checkout_billing.tax_address}
        DobbyAppCommon.Tap element when ready   ${checkout_billing.address_saved}
        ${current_addr}=     mobile_common.Get element attribute when ready     ${checkout_billing.picker_wheel}  value
        IF  '${current_addr}' == '${blllingslot}'
            mobile_common.Input value to pickerwheel when ready    ${addr2}
        ELSE IF     '${current_addr}' == '${addr2}'
            mobile_common.Input value to pickerwheel when ready    ${blllingslot}
        END
    END

Tap go to payment button
    IF   "${platform}" == "${platform_list['android']}"
        FOR     ${i}    IN RANGE    0   3
            ${is_found}=    Run keyword and return status   DobbyAppCommon.Wait until page contain element except stale    ${checkout_billing.btn_complete_your_order}   timeout=5s
            IF  ${is_found}
                Exit for loop if    ${is_found}
            END
            DobbyAppCommon.Swipe down
        END
        FOR     ${i}    IN RANGE    0   3
            DobbyAppCommon.Tap element when ready     ${checkout_billing.btn_complete_your_order}
            ${is_found}=    Run keyword and return status   DobbyAppCommon.Wait until element is visible except stale  ${checkout_billing.select_payment}    timeout=30s
            IF  ${is_found}
                Exit for loop if    ${is_found}
            END
        END
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        FOR     ${i}    IN RANGE    0   4
            ${is_found}=    Run keyword and return status   DobbyAppCommon.Wait until element is visible except stale    ${checkout_billing.btn_complete_checkout}      timeout=10s
            Exit for loop if    ${is_found}
            DobbyAppCommon.Swipe down
        END
        DobbyAppCommon.Tap element when ready         ${checkout_billing.btn_complete_checkout}
        mobile_common.Wait until loading complete
    END

Select using new billing address
    IF   "${platform}" == "${platform_list['android']}" 
        DobbyAppCommon.Tap element when ready     ${checkout_billing.checkout_billing_address_id}
        DobbyAppCommon.Tap element when ready     ${checkout_billing.checked_change_address_for_delivery}
        DobbyAppCommon.Tap element when ready     ${checkout_billing.btn_checkout_different_billing_address}
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        mobile_common.Find element     ${checkout_billing.tax_address}
        DobbyAppCommon.Tap element when ready   ${checkout_billing.tax_address}
        DobbyAppCommon.Tap element when ready   ${checkout_billing.address_saved}
        IF  '${platformVersion}' == '15.0'
            DobbyAppCommon.Tap element when ready   ${checkout_billing.use_new_address_typeother}
        ELSE IF     '${platformVersion}' == '14.5'
            mobile_common.Input value to pickerwheel when ready    ใช้ที่อยู่ใหม่
        ELSE
            Should be true  ${FALSE}    msg='Cannot resolve ios version,please recheck'
        END
    END

Click change delivery address
    IF   "${platform}" == "${platform_list['android']}"
        DobbyAppCommon.Tap element when ready     ${checkout_billing.change_address_for_delivery}
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        FOR     ${i}    IN RANGE    0   4
            DobbyAppCommon.Tap element when ready   ${checkout_billing.change_address_for_delivery_typeother}
            ${is_shipping_page}=    Run keyword and return status   DobbyAppCommon.Wait until element is visible except stale   ${checkout_billing.txt_step1of3}
            Exit for loop if    ${is_shipping_page}
        END
        Should be true  ${is_shipping_page}     msg='App didn't navigate to shipping address after clicked change addr 3 times'
    END

Tap go to payment button when product out of stock
    IF   "${platform}" == "${platform_list['android']}"
        FOR     ${i}    IN RANGE    0   2
            DobbyAppCommon.Tap element when ready     ${checkout_billing.btn_complete_your_order}
            ${is_found}=    Run keyword and return status   DobbyAppCommon.Wait until element is visible except stale  ${checkout_billing.company_header}    timeout=10s
            IF  ${is_found}
                Fail        Product is not out of stock
            END
        END
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        FOR     ${i}    IN RANGE    0   2
            DobbyAppCommon.Tap element when ready     ${checkout_billing.btn_complete_checkout}
        END
        mobile_common.Wait until loading complete
    END

Verify current page is checkout billing address page
    IF   "${platform}" == "${platform_list['android']}"
        DobbyAppCommon.Wait until element is visible except stale       ${checkout_billing.confirm_order}      timeout=${short_timeout}
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        DobbyAppCommon.Wait until element is visible except stale       ${checkout_billing.confirm_order}
    END

Verify product out of stock error message
    mobile_common.Find element     ${checkout_billing.timeslot_error_container}
    DobbyAppCommon.Wait until element is visible except stale       ${checkout_billing.basket_are_out_of_stock}

# Android

Input billing address company name
    [Arguments]     ${billing_company}
    DobbyAppCommon.Input text to element when ready      ${checkout_billing.company}     ${billing_company}
    
Input billing address first name
    [Arguments]     ${billing_firstname}
    DobbyAppCommon.Input text to element when ready      ${checkout_billing.first_name}      ${billing_firstname}

Input billing address last name
    [Arguments]     ${billing_lastname}
    DobbyAppCommon.Input text to element when ready      ${checkout_billing.last_name}       ${billing_lastname}

Input billing address phone number
    [Arguments]     ${billing_phone}
    DobbyAppCommon.Input text to element when ready      ${checkout_billing.phone}       ${billing_phone}

Input billing address address line 1
    [Arguments]     ${billing_addr1}
    DobbyAppCommon.Input text to element when ready      ${checkout_billing.address1}      ${billing_addr1}

Input billing address address line 2
    [Arguments]     ${billing_addr2}
    DobbyAppCommon.Input text to element when ready      ${checkout_billing.address2}       ${billing_addr2}

Input billing address zip code
    [Arguments]     ${billing_zipcode}
    DobbyAppCommon.Input text to element when ready      ${checkout_billing.zip}       ${billing_zipcode}
    DobbyAppCommon.Hide keyboard until success

Select shipping address province
    [Arguments]     ${billing_province}
    ${billng_province_locator}    String.Replace string    ${checkout_billing.txt_billng_province}    {{billng_province}}    ${billng_province}
    DobbyAppCommon.Tap element when ready     ${billng_province_locator}    #native
    DobbyAppCommon.Tap element when ready     ${checkout_billing.province}     

Select shipping address district
    DobbyAppCommon.Tap element when ready        ${checkout_billing.city}     

Get locator from field name
    [Arguments]     ${field_name}
    ${field_name_re}=       Replace string  ${field_name}   ${SPACE}    ${EMPTY}
    ${field_name_lower}=    Convert to lower case   ${field_name_re}

    IF  '${field_name_lower}' == 'companyname'
        ${field_resource_id}=   Set variable    checkout_billing_address_company
    ELSE IF     '${field_name_lower}' == 'firstname'
        ${field_resource_id}=   Set variable    checkout_billing_address_first_name
    ELSE IF     '${field_name_lower}' == 'lastname'
        ${field_resource_id}=   Set variable    checkout_billing_address_last_name
    ELSE IF     '${field_name_lower}' == 'phonenumber'
        ${field_resource_id}=   Set variable    checkout_billing_address_phone
    ELSE IF     '${field_name_lower}' == 'address'
        ${field_resource_id}=   Set variable    checkout_billing_address_address1
    ELSE IF     '${field_name_lower}' == 'address2'
        ${field_resource_id}=   Set variable    checkout_billing_address_address2
    ELSE IF     '${field_name_lower}' == 'postalcode'
        ${field_resource_id}=   Set variable    checkout_billing_address_zip
    ELSE IF     '${field_name_lower}' == 'province'
        ${field_resource_id}=   Set variable    checkout_billing_address_province
    ELSE IF     '${field_name_lower}' == 'district'
        ${field_resource_id}=   Set variable    checkout_billing_address_city
    ELSE IF     '${field_name_lower}' == 'taxid'
        ${field_resource_id}=   Set variable    checkout_billing_taxId
    ELSE IF     '${field_name_lower}' == 'branchid'
        ${field_resource_id}=   Set variable    checkout_billing_branchId
    ELSE
        ${field_resource_id}=   Set variable    ${NONE}
    END

    Should be true  '${field_resource_id}' != '${NONE}'
    ...     msg="field name [${field_name}] doesn't match with any field. please, recheck. "

    [Return]    ${field_resource_id}

Tap on ${field_name} field
    ${field_resource_id}=   checkout_billing_address_page.Get locator from field name     ${field_name}
    IF  '${field_resource_id}' != '${NONE}'
        ${field_resource_id_locator}    String.Replace string    ${checkout_billing.txt_field_resource_id}    {{field_resource_id}}    ${field_resource_id}
        DobbyAppCommon.Tap element when ready   ${field_resource_id_locator}
        DobbyAppCommon.Hide keyboard until success
    ELSE
        Should be true  '${field_resource_id}' != '${NONE}'     msg="${field_name} doesn't match with any fields, please, recheck"
    END


Enter ${text} into ${field_name} field
    ${field_resource_id}=   checkout_billing_address_page.Get locator from field name     ${field_name}
    IF  '${field_resource_id}' != '${NONE}'
        ${field_resource_id_locator}    String.Replace string    ${checkout_billing.txt_field_resource_id}    {{field_resource_id}}    ${field_resource_id}
        DobbyAppCommon.Input text to element when ready     ${field_resource_id_locator}  ${text}
    ELSE
        Should be true  '${field_resource_id}' != '${NONE}'     msg="${field_name} doesn't match with any fields, please, recheck"
    END

No warning message on ${field_name} field
    [Documentation]  if there is an error message, the next element will be the error message element.
    ...     so to make sure there is no error msg, we have to do the negative.
    ...     the next element should not be error message, hence it should be the next field (position()=1)
    ...     next to taxid is branchid
    ...     next to branchid is company name
    ...     next to company name is first name
    ...     next to address2 is postal code

    ${field_name_re}=       Replace string  ${field_name}   ${SPACE}    ${EMPTY}
    ${field_name_lower}=    Convert to lower case   ${field_name_re}

    IF  '${field_name_lower}' == 'companyname'
        DobbyAppCommon.Wait until element is visible except stale     ${checkout_billing.checkout_billing_address_first_name}
    ELSE IF     '${field_name_lower}' == 'address2'
        DobbyAppCommon.Wait until element is visible except stale     ${checkout_billing.checkout_billing_address_zip}
    ELSE IF     '${field_name_lower}' == 'taxid'
        DobbyAppCommon.Wait until element is visible except stale     ${checkout_billing.checkout_billing_branchId_field}
    ELSE IF     '${field_name_lower}' == 'branchid'
        DobbyAppCommon.Wait until element is visible except stale     ${checkout_billing.checkout_billing_address_company}
    END

# iOS

No warning message on company name field
    DobbyAppCommon.Wait until page contain element except stale       ${checkout_billing.company_name}

Input tax id
    [Arguments]     ${tax_id}
    DobbyAppCommon.Clear text when ready    ${checkout_billing.tax_id}
    DobbyAppCommon.Input text to element when ready     ${checkout_billing.tax_id}      ${tax_id}

Verify error message in tax id field display
    DobbyAppCommon.Wait until element is visible except stale       ${checkout_billing.typeother_id}

Verify can click go to payment button
    DobbyAppCommon.Wait until element is visible except stale       ${checkout_billing.complete_order}
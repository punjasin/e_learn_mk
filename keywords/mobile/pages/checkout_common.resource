*** Settings ***
Resource        ../../../resources/locators/${platform}/checkout_locator.resource
Resource        ../../../resources/locators/${platform}/common_locator.resource
Resource        ../pages/checkout_common.resource
Resource        ../../../common/mobile/mobile_common.resource

*** Keywords ***
${field_name} validation message should be ${expected_msg}
    IF   "${platform}" == "${platform_list['android']}"
        ${field_resource_id}=   Get validation message locator from field name     ${field_name}

        IF  '${field_resource_id}' != '${NONE}'
            ${view_field_resource_id_locator}    String.Replace string    ${checkout_shipping_address.view_field_resource_id}    {{field_resource_id}}    ${field_resource_id}
            ${actual_msg}=  DobbyAppCommon.Get text from element when ready   ${view_field_resource_id_locator}
        ELSE
            log     ${field_name} doesn't match with any fields, please recheck field name
        END
    Should be equal     ${actual_msg.strip()}   ${expected_msg.strip()}
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        ${expected_msg_locator}    String.Replace string    ${checkout.expected_msg}    {{expected_msg}}    ${expected_msg}
        DobbyAppCommon.Wait until element is visible except stale   ${expected_msg_locator}
    END

# Android

Get validation message locator from field name
    [Arguments]     ${field_name}
    ${field_name_re}=       Replace string  ${field_name}   ${SPACE}    ${EMPTY}
    ${field_name_lower}=    Convert to lower case   ${field_name_re}

    IF  '${field_name_lower}' == 'firstname'
        ${field_resource_id}=   Set variable    first_name-validation-message
    ELSE IF     '${field_name_lower}' == 'lastname'
        ${field_resource_id}=   Set variable    last_name-validation-message
    ELSE IF     '${field_name_lower}' == 'phonenumber'
        ${field_resource_id}=   Set variable    phone-validation-message
    ELSE IF     '${field_name_lower}' == 'address'
        ${field_resource_id}=   Set variable    address1-validation-message
    ELSE IF     '${field_name_lower}' == 'postalcode'
        ${field_resource_id}=   Set variable    zip-validation-message
    ELSE IF     '${field_name_lower}' == 'province'
        ${field_resource_id}=   Set variable    province-validation-message
    ELSE IF     '${field_name_lower}' == 'district'
        ${field_resource_id}=   Set variable    city-validation-message
    ELSE
        ${field_resource_id}=   Set variable    ${NONE}
    END

    Should be true  '${field_resource_id}' != '${NONE}'
    ...     msg="${field_name} doesn't match with any fields, please recheck"

    [Return]    ${field_resource_id}

Enter postal code
    [Arguments]     ${page_name}         ${postal_code}
    ${checkout_address_zip_locator}    String.Replace string    ${checkout_common.checkout_address_zip}    {{expected_msg}}    ${expected_msg}
    DobbyAppCommon.Wait until element is visible except stale       ${checkout_address_zip_locator}
    DobbyAppCommon.Clear text when ready        ${checkout_address_zip_locator}
    DobbyAppCommon.Tap element when ready       ${checkout_address_zip_locator}
    ${string}=  Convert to string   ${postal_code}
    ${count}=   Get length  ${string}
    FOR     ${i}    IN RANGE   0   ${count}
        ${num}=         Convert to integer   ${string[${i}]}
        ${keycode}=     Evaluate    ${num}+7
        Press keycode   ${keycode}
    END
    mobile_common.Press enter on numpad keyboard

# iOS

Enter ${text} into ${field_name} field
    ${field_resource_id}=   checkout_common.Get locator from field name     ${field_name}
    IF  '${field_resource_id}' != '${NONE}'
        IF  '${field_name}' == 'province' or '${field_name}' == 'district' or '${field_name}' == 'address'
            ${field_resource_id_typeother_locator}    String.Replace string    ${checkout.field_resource_id_typeother}    {{field_resource_id}}    ${field_resource_id}
            DobbyAppCommon.Input text to element when ready    ${field_resource_id_typeother_locator}        ${text}
        ELSE IF     '${field_name}' == 'phonenumber'
            ${field_resource_id_textfield_locator}    String.Replace string    ${checkout.field_resource_id_textfield}    {{field_resource_id}}    ${field_resource_id}
            FOR     ${i}    IN RANGE    0   11
                DobbyAppCommon.Tap element when ready                                   ${field_resource_id_textfield_locator}
                DobbyAppCommon.Clear text when ready                            ${field_resource_id_textfield_locator}
                ${text_field}=      DobbyAppCommon.Get text from element when ready     ${field_resource_id_textfield_locator}
                ${result}=          Run keyword and return status   Should be equal     '${text_field}'   '${field_resource_id}'
                Exit for loop if    ${result}
            END
            Should be true  ${result}   msg='Failed to clear text from phonenumber field after 10 retry'
            DobbyAppCommon.Input text to element when ready    ${field_resource_id_textfield_locator}    ${text}
        ELSE
            ${field_resource_id_textfield_locator}    String.Replace string    ${checkout.field_resource_id_textfield}    {{field_resource_id}}    ${field_resource_id}
            DobbyAppCommon.Input text to element when ready    ${field_resource_id_textfield_locator}    ${text}
        END
    ELSE
        Should be true  '${field_resource_id}' != '${NONE}'     msg="${field_name} doesn't match with any fields, please, recheck"
    END

Tap on ${field_name} field
    ${field_resource_id}=   checkout_common.Get locator from field name     ${field_name}
    IF  '${field_resource_id}' != '${NONE}'
        ${field_resource_id_typeother_locator}    String.Replace string    ${checkout.field_resource_id_typeother}    {{field_resource_id}}    ${field_resource_id}
        IF  '${field_name}' == 'province' or '${field_name}' == 'district' or '${field_name}' == 'address'
            mobile_common.Swipe and tab element by locator     ${field_resource_id_typeother_locator}
        ELSE IF     '${field_name}' == 'taxid' or '${field_name}' == 'branchid'
            DobbyAppCommon.Tap element when ready    ${field_resource_id_typeother_locator}  only_contain=${TRUE}       
        ELSE
            ${field_resource_id_textfield_locator}    String.Replace string    ${checkout.field_resource_id_textfield}    {{field_resource_id}}    ${field_resource_id}
            mobile_common.Swipe and tab element by locator     ${field_resource_id_textfield_locator}
        END
    ELSE
        Should be true  '${field_resource_id}' != '${NONE}'     msg="${field_name} doesn't match with any fields, please, recheck"
    END


Get locator from field name
    [Arguments]     ${field_name}
    ${field_name_re}=       Replace string  ${field_name}   ${SPACE}    ${EMPTY}
    ${field_name_lower}=    Convert to lower case   ${field_name_re}

    IF  '${field_name_lower}' == 'companyname'
        ${field_resource_id}=   Set variable    ชื่อที่อยู่
    ELSE IF     '${field_name_lower}' == 'firstname'
        ${field_resource_id}=   Set variable    ชื่อ
    ELSE IF     '${field_name_lower}' == 'lastname'
        ${field_resource_id}=   Set variable    นามสกุล
    ELSE IF     '${field_name_lower}' == 'phonenumber'
        ${field_resource_id}=   Set variable    โทรศัพท์
    ELSE IF     '${field_name_lower}' == 'address'
        ${field_resource_id}=   Set variable    ที่อยู่
    ELSE IF     '${field_name_lower}' == 'address2'
        ${field_resource_id}=   Set variable    อพาร์ตเมนต์ ห้องชุด ฯลฯ (ไม่บังคับ)
    ELSE IF     '${field_name_lower}' == 'postalcode'
        ${field_resource_id}=   Set variable    รหัสไปรษณีย์
    ELSE IF     '${field_name_lower}' == 'province'
        ${field_resource_id}=   Set variable    จังหวัด
    ELSE IF     '${field_name_lower}' == 'district'
        ${field_resource_id}=   Set variable    เขต/อำเภอ
    ELSE IF     '${field_name_lower}' == 'deliveryinstruction'
        ${field_resource_id}=   Set variable    คำแนะนำการจัดส่ง
    ELSE IF     '${field_name_lower}' == 'taxid'
        ${field_resource_id}=   Set variable    เลขประจำตัวผู้เสียภาษี (ไม่บังคับ)
    ELSE IF     '${field_name_lower}' == 'branchid'
        ${field_resource_id}=   Set variable    เลขที่สาขา (ไม่บังคับ)
    ELSE
        ${field_resource_id}=   Set variable    ${NONE}
    END

    Should be true  '${field_resource_id}' != '${NONE}'
    ...     msg="field name [${field_name}] doesn't match with any field. please, recheck. "

    [Return]    ${field_resource_id}

No warning message on ${field_name} field
    [Documentation]  if there is an error message, the next element will be the error message element.
    ...     so to make sure there is no error msg, we have to do the negative.
    ...     the next element should not be error message, hence it should be the next field (position()=1)
    ...     next to company name is first name
    ...     next to address2 is postal code
    ...     next to delivery instruction is next button

    ${field_name_re}=       Replace string          ${field_name}   ${SPACE}    ${EMPTY}
    ${field_name_lower}=    Convert to lower case   ${field_name_re}

    IF  '${field_name_lower}' == 'companyname'
        DobbyAppCommon.Wait until page contain element except stale       ${checkout.name_address} 
    ELSE IF     '${field_name_lower}' == 'address2'
        DobbyAppCommon.Wait until page contain element except stale       ${checkout.zip_code}
    ELSE IF     '${field_name_lower}' == 'deliveryinstruction'
        AppiumLibrary.Page should not contain element     ${checkout.advice}
    ELSE IF     '${field_name_lower}' == 'phonenumber'
        AppiumLibrary.Page should not contain element     ${checkout.statictext_phone}
        AppiumLibrary.Page should not contain element     ${checkout.statictext_phone_completed}
    ELSE IF     '${field_name_lower}' == 'taxid'
        DobbyAppCommon.Wait until page contain element except stale    ${checkout.branch_code}
    ELSE IF     '${field_name_lower}' == 'branchid'
        DobbyAppCommon.Wait until page contain element except stale    ${checkout.company}
    ELSE
        Should be true  ${FALSE}    msg='cannot resolve ${field_name}, please recheck'
    END

Click button to exit check out process
    checkout_billing_address_page.Verify current page is checkout billing address page
    DobbyAppCommon.Tap element when ready       ${checkout.typeother}

Tap button go to payment
    [Documentation]    button go to payment is at the bottom of page, required to scroll very fast to button if scroll slow,payment page timeout and button grey
    IF  "${platform}" == "${platform_list['android']}"
        IF  ${browserstack}==${True}
            mobile_common.Find element and tap     ${checkout.btn_goToPayment}      scroll_panel=${checkout.layout}    percent=${swipeMediumScroll}    timeout=${very_short_timeout}
        ELSE
            mobile_common.Find element and tap     ${checkout.btn_goToPayment}     scroll_panel=${checkout.webview}    percent=${swipeMediumScroll}    timeout=${very_short_timeout}
        END
    ELSE IF  "${platform}" == "${platform_list['ios']}"         
        mobile_common.Find element and tap     ${checkout.btn_goToPayment}
    END
    mobile_common.Wait until loading complete
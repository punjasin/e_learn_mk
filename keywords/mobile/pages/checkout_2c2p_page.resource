*** Settings ***
Resource        ../../../resources/locators/${platform}/checkout_locator.resource
Resource        ../../../resources/locators/${platform}/common_locator.resource
Resource        ../../../resources/locators/${platform}/2c2p_locator.resource
Resource        ../../../common/mobile/mobile_common.resource

*** Keywords ***
Select credit card
    IF   "${platform}" == "${platform_list['android']}"
        DobbyAppCommon.Tap element when ready  ${checkout_2c2p.credit_debit}
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        Sleep  2s
        DobbyAppCommon.Wait until element is visible except stale   ${checkout_2c2p.global_card}
        DobbyAppCommon.Tap element when ready       ${checkout_2c2p.global_card}
    END

Select bank transfer option
    IF   "${platform}" == "${platform_list['android']}"
        mobile_common.Wait until loading complete
        IF  '${browserstack}'=='True'
            DobbyAppCommon.Tap element when ready   ${checkout_2c2p.bank_transfer}
        ELSE
            DobbyAppCommon.Tap element when ready   ${checkout_2c2p.bank_transfer_local}
        END
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        Sleep  2s
        DobbyAppCommon.Wait until element is visible except stale   ${2c2p.option_bank_transfer}
        DobbyAppCommon.Tap element when ready       ${2c2p.option_bank_transfer}
    END
    
Select digital payment
    IF   "${platform}" == "${platform_list['android']}"
        DobbyAppCommon.Tap element when ready  ${checkout_2c2p.true_wallet}
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        Sleep  2s
        DobbyAppCommon.Wait until element is visible except stale   ${checkout_2c2p.digital_payment}
        DobbyAppCommon.Tap element when ready       ${checkout_2c2p.digital_payment}
    END

Input credit card
    [Arguments]     ${2c2pcard}
    IF   "${platform}" == "${platform_list['android']}"
        DobbyAppCommon.Input text to element when ready      ${checkout_2c2p.card_number}      ${2c2pcard}     
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        DobbyAppCommon.Input text to element when ready     ${checkout_2c2p.card_number}
        ...  ${2c2pcard}
    END

Input expire date
    [Arguments]     ${2c2pexp}
    DobbyAppCommon.Input text to element when ready     ${checkout_2c2p.expiry_date}      ${2c2pexp}     

Input cvv
    [Arguments]     ${2c2pcvv}
    IF   "${platform}" == "${platform_list['android']}"
        DobbyAppCommon.Tap element when ready  ${checkout_2c2p.cvv}
        DobbyAppCommon.Input text to element when ready      ${checkout_2c2p.cvv}      ${2c2pcvv}     
        AppiumLibrary.Hide keyboard
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        DobbyAppCommon.Input text to element when ready     ${checkout_2c2p.cvv}     ${2c2pcvv}
    END

Input cardholder name
    [Arguments]     ${2c2pname}
    DobbyAppCommon.Input text to element when ready     ${checkout_2c2p.cardholder_name}     ${2c2pname}     
    

Tap continue payment
    IF   "${platform}" == "${platform_list['android']}"
        DobbyAppCommon.Tap element when ready     ${checkout_2c2p.btn_continue}
        AppiumLibrary.Wait until page does not contain element       ${checkout_2c2p.loading}
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        DobbyAppCommon.Tap element when ready       ${checkout_2c2p.continue_payment}
    END

Input otp
    [Arguments]     ${otp}
    IF   "${platform}" == "${platform_list['android']}"
        DobbyAppCommon.Input text to element when ready      ${checkout_2c2p.upper_otp_id}       ${otp}
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        DobbyAppCommon.Input text to element when ready     ${checkout_2c2p.input_2c2p_plus}
        ...     ${otp}
    END

Input truemoney otp
    [Arguments]     ${otp}
    IF   "${platform}" == "${platform_list['android']}"
        DobbyAppCommon.Input text to element when ready      ${checkout_2c2p.upper_otp_id}       ${otp}
        DobbyAppCommon.Hide keyboard until success
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        DobbyAppCommon.Input text to element when ready     ${checkout_2c2p.textfield}
        ...     ${otp}
    END

Tap verify button
    DobbyAppCommon.Tap element when ready        ${checkout_2c2p.btn_verify}

Tap proceed button
    DobbyAppCommon.Tap element when ready        ${checkout_2c2p.proceed}

Tap cancel button
    IF   "${platform}" == "${platform_list['android']}"
        DobbyAppCommon.Tap element when ready        ${checkout_2c2p.btn_cancel}
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        DobbyAppCommon.Tap element when ready       ${checkout_2c2p.Cancel}
    END

Tap cancel button on payment selection
    IF   "${platform}" == "${platform_list['android']}"
        DobbyAppCommon.Tap element when ready        ${checkout_2c2p.btn_txt_cancel}
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        DobbyAppCommon.Tap element when ready       ${checkout_2c2p.CANCEL}
    END

Transaction failed message should be displayed
    IF   "${platform}" == "${platform_list['android']}"
        DobbyAppCommon.Wait until element is visible except stale   ${checkout_2c2p.payment_has_been_declined}
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        DobbyAppCommon.Wait until element is visible except stale   ${checkout_2c2p.transaction_failed}
    END

Transaction is successful message should be displayed
    DobbyAppCommon.Wait until element is visible except stale   ${checkout_2c2p.transaction_successful}

Customer cancellation message should be displayed
    DobbyAppCommon.Wait until element is visible except stale   ${checkout_2c2p.customer_cancellation}

Tap back to merchant
    IF   "${platform}" == "${platform_list['android']}"
        ${order_created_time}=    Get Current Date
        Set Global Variable      ${order_created_time} 
        DobbyAppCommon.Tap element when ready       ${checkout_2c2p.btn_back_to_merchant}
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        ${order_created_time}=    Get Current Date
        Set Global Variable      ${order_created_time}      
        DobbyAppCommon.Tap element when ready       ${checkout_2c2p.back_to_merchant}
    END

Tap done button
    IF   "${platform}" == "${platform_list['android']}"
        DobbyAppCommon.Tap element when ready        ${checkout_2c2p.txt_successful}
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        FOR     ${i}        IN RANGE    0   10
            DobbyAppCommon.Tap element when ready        ${checkout_2c2p.successful}
            ${result}=   Run keyword and return status      AppiumLibrary.Page should not contain element         ${checkout_2c2p.successful}
            Exit for loop if    ${result}
        END
        Should be true      ${result}       msg='completed button still show after clicking'
    END

Input payer name
    [Arguments]     ${name}
    IF   "${platform}" == "${platform_list['android']}"
        DobbyAppCommon.Input text to element when ready      ${2c2p.input_payer_name}      ${name}
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        DobbyAppCommon.Input text to element when ready     ${checkout_2c2p.payer_name}
        ...      ${payer}
    END

Input email address
    [Arguments]     ${email}
    IF   "${platform}" == "${platform_list['android']}"
        DobbyAppCommon.Clear text when ready        ${2c2p.input_email}
        DobbyAppCommon.Input text to element when ready      ${2c2p.input_email}      ${email}
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        DobbyAppCommon.Input text to element when ready     ${checkout_2c2p.email_address}
        ...     ${email}
    END

Input phone number
    [Arguments]     ${phone}
    IF   "${platform}" == "${platform_list['android']}"
        DobbyAppCommon.Clear text when ready      ${2c2p.input_phone_number}
        DobbyAppCommon.Input text to element when ready      ${2c2p.input_phone_number}      ${phone}
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        DobbyAppCommon.Wait until element is visible except stale   ${checkout_2c2p.phone_number}
        ${getsize_basket} =   AppiumLibrary.Get Element Size          ${checkout_2c2p.phone_number}
        ${getcoor_basket} =   Get element location      ${checkout_2c2p.phone_number}
        ${center_x}   Evaluate    ${getcoor_basket['x']}+${getsize_basket['width']}/2
        ${center_y}   Evaluate    ${getcoor_basket['y']}+${getsize_basket['height']}/2
        AppiumLibrary.Click element at coordinates       coordinate_X=${center_x}    coordinate_Y=${center_y}
        ${old_text}     DobbyAppCommon.Get text from element when ready     ${checkout_2c2p.phone_number}
        ${text_count}       Get length      ${old_text}
        FOR     ${i}    IN RANGE    1   ${text_count}+1
            DobbyAppCommon.Tap element when ready       ${checkout_2c2p.delete}
        END
        DobbyAppCommon.Input text to element when ready     ${checkout_2c2p.phone_number}
            ...     ${phone}
    END

Tap return to merchant for bank transfer
    IF   "${platform}" == "${platform_list['android']}"
        DobbyAppCommon.Wait until element is visible except stale       ${2c2p.txt_bank_complete_company} 
        Swipe by percent    50  80  50  20     #swipe down
        DobbyAppCommon.Wait until element is visible except stale       ${2c2p.btn_bank_complete_return_to_merchant} 
        AppiumLibrary.Click element       ${2c2p.btn_bank_complete_return_to_merchant}
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        DobbyAppCommon.Tap element when ready       ${checkout_2c2p.return_to_merchant}
    END

Get payment ref code and amount from qr code page
    IF   "${platform}" == "${platform_list['android']}"
        DobbyAppCommon.Wait until element is visible except stale       ${checkout_2c2p.txt_bank_qr}
        ${payment_ref}=     DobbyAppCommon.Get text from element when ready    ${checkout_2c2p.txt_bank_payment_ref}
        ${amount}=     DobbyAppCommon.Get text from element when ready    ${checkout_2c2p.txt_bank_payment_amount}  
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        DobbyAppCommon.Wait until element is visible except stale       ${checkout_2c2p.qr_code}
        ${payment_ref}=     DobbyAppCommon.Get text from element when ready    ${checkout_2c2p.1_2_3_service_12}
        ${amount}=     DobbyAppCommon.Get text from element when ready    ${checkout_2c2p.1_2_3_service_22} 
    END
    [Return]    ${payment_ref}      ${amount}

Tap simulate success button
    IF   "${platform}" == "${platform_list['android']}"
        DobbyAppCommon.Tap element when ready        ${checkout_2c2p.btn_simulate_success}
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        DobbyAppCommon.Tap element when ready        ${checkout_2c2p.simulate_success}
    END

Verify total price in 2c2p page should be
    [Documentation]     Pass with .00 (ex. 697.00)
    [Arguments]     ${price}
    ${main_price_locator}    String.Replace string    ${checkout_2c2p.main_price}    {{price}}    ${price}
    IF   "${platform}" == "${platform_list['android']}"
        DobbyAppCommon.Wait until element is visible except stale       ${main_price_locator}
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        DobbyAppCommon.Wait until element is visible except stale       ${main_price_locator}
    END

# Android only

Tap back from bank transfer option
    DobbyAppCommon.Tap element when ready  ${checkout_2c2p.select_bank}

Tap on bank selection dropdown
    DobbyAppCommon.Tap element when ready        ${checkout_2c2p.kasikorn_bank}

Select bank option
    [Arguments]     ${bankoption}
    [Documentation]         kbank=Kasikorn
    ...     scb=Siam
    ...     bbl=Bangkok
    ...     ktb=Krung Thai
    ...     bay=Ayudhya
    IF  '${browserstack}'=='True'
        ${bankoption_locator}    String.Replace string    ${checkout_2c2p.bankoption}    {{bankoption}}    ${bankoption}
    ELSE
        ${bankoption_locator}    String.Replace string    ${checkout_2c2p.bankoption_local}    {{bankoption}}    ${bankoption}
    END
    DobbyAppCommon.Tap element when ready        ${bankoption_locator}

Input 2c2p email
    [Arguments]     ${2c2pemail}      ${view}=webview
    IF  '${view}' == 'webview'
        DobbyAppCommon.Input text to element when ready      ${checkout_2c2p.email}      ${2c2pemail}     
    ELSE IF     '${view}' == 'native'
        DobbyAppCommon.Input text to element when ready      ${2c2p.input_email}      ${2c2pemail} 
    ELSE
        Should be true  ${FALSE}    msg='unable to resolve view [${view}], please recheck'
    END

# iOS only

Take bank transfer QR code screenshot
    DobbyAppCommon.Wait until element is visible except stale       ${checkout_2c2p.txt_bank_qr}
    AppiumLibrary.Capture Page Screenshot

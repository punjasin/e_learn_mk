*** Settings ***
Resource        ../pages/ordersummary_page.resource
Resource        ../pages/checkout_shipping_address_page.resource
Resource        ../pages/checkout_delivery_slot_page.resource
Resource        ../pages/checkout_billing_address_page.resource
Resource        ../pages/checkout_common.resource
Resource        ../pages/checkout_2c2p_page.resource
Resource        ../pages/feedback_page.resource
Resource        ../pages/order_success_page.resource
Resource        feedback_feature.resource

*** Keywords ***
Checkout delivery page
    [Arguments]     ${productname}      ${totalamount}      ${instructions}=none    ${addressslot}=1
    ...     ${deliveryslot}=1       ${samebillingaddress}='yes'     ${billingslot}=2
    IF   "${platform}" == "${platform_list['android']}"
        ordersummary_page.Click to show order summary
        ordersummary_page.Verify product title in order summary     ${productname}
        ordersummary_page.Verify total amount in order summary      ${totalamount}
        checkout_shipping_address_page.Input delivery instructions     ${instructions}
        checkout_shipping_address_page.Select existing shipping address and continue to shipping date       ${addressslot}

        ordersummary_page.Click to show order summary
        ordersummary_page.Verify product title in order summary     ${productname}
        ordersummary_page.Verify total amount in order summary      ${totalamount}
        checkout_delivery_slot_page.Select deliveryslot     ${deliveryslot}
        checkout_delivery_slot_page.Tap continue to billing address button

        ordersummary_page.Click to show order summary
        ordersummary_page.Verify product title in order summary     ${productname}
        ordersummary_page.Verify total amount in order summary      ${totalamount}
        Run Keyword If      ${samebillingaddress}=='yes'     checkout_billing_address_page.Select same billing address
        Run Keyword If      ${samebillingaddress}=='no'      checkout_billing_address_page.Select different billing address     ${billingslot}
        checkout_billing_address_page.Tap go to payment button
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        ordersummary_page.Click to show order summary
        ordersummary_page.Verify product title in order summary     ${productname}
        ordersummary_page.Verify total amount in order summary      ${totalamount}
        checkout_shipping_address_page.Tap continue to shipping date button

        ordersummary_page.Click to show order summary
        ordersummary_page.Verify product title in order summary     ${productname}
        ordersummary_page.Verify total amount in order summary      ${totalamount}
        checkout_delivery_slot_page.Tap continue to billing address button

        ordersummary_page.Click to show order summary
        ordersummary_page.Verify product title in order summary     ${productname}
        ordersummary_page.Verify total amount in order summary      ${totalamount}
        Run Keyword If      ${samebillingaddress}=='yes'     checkout_billing_address_page.Select same billing address
        Run Keyword If      ${samebillingaddress}=='no'      checkout_billing_address_page.Select different billing address     ${billingslot}
        checkout_billing_address_page.Tap go to payment button
    END

Checkout using new shipping address input all field
    [Arguments]     ${productname}      ${totalamount}
    ...     ${shipping_company}     ${shipping_firstname}       ${shipping_lastname}        ${shipping_phone}
    ...     ${shipping_addr1}       ${shipping_addr2}       ${shipping_zipcode}     ${shipping_new_instruction}  
    ...     ${newaccount}='no'       
    IF   "${platform}" == "${platform_list['android']}"
        checkout_shipping_address_page.Click accept pindrop popup if exist
        Run Keyword If      ${newaccount}=='no'     ordersummary_page.Click to show order summary
        Run Keyword If      ${newaccount}=='no'     ordersummary_page.Verify product title in order summary     ${productname}
        Run Keyword If      ${newaccount}=='no'     ordersummary_page.Verify total amount in order summary      ${totalamount}
        checkout_shipping_address_page.Select using new shipping address
        checkout_shipping_address_page.Input shipping address company name      ${shipping_company}
        checkout_shipping_address_page.Input shipping address first name        ${shipping_firstname}
        checkout_shipping_address_page.Input shipping address last name         ${shipping_lastname}
        checkout_shipping_address_page.Input shipping address phone number      ${shipping_phone}
        checkout_shipping_address_page.Input shipping address address line 1    ${shipping_addr1}
        checkout_shipping_address_page.Input shipping address address line 2    ${shipping_addr2}
        checkout_common.Enter postal code   shipping   ${shipping_zipcode}
        checkout_shipping_address_page.Click to update location pin if exist
        # Hide keyboard
        # checkout_shipping_address_page.Input new shipping address delivery instructions     ${shipping_new_instruction}     #not ready
        Wait Until Keyword Succeeds  3x    200ms  checkout_shipping_address_page.Click save and continue at new address form
        checkout_shipping_address_page.Tap continue to shipping date button
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        Run Keyword If      ${newaccount}=='no'     ordersummary_page.Click to show order summary
        Run Keyword If      ${newaccount}=='no'     ordersummary_page.Verify product title in order summary     ${productname}
        Run Keyword If      ${newaccount}=='no'     ordersummary_page.Verify total amount in order summary      ${totalamount}

        Run Keyword If      ${newaccount}=='yes'     checkout_shipping_address_page.Select using new shipping address

        mobile_common.Swipe down 
        checkout_common.Enter ${shipping_new_instruction} into delivery instruction field
        mobile_common.Swipe up  3
        checkout_common.Enter ${shipping_company} into company name field
        checkout_common.Enter ${shipping_firstname} into firstname field
        checkout_common.Enter ${shipping_lastname} into lastname field
        checkout_common.Enter ${shipping_phone} into phonenumber field
        checkout_common.Enter ${shipping_addr1} into address field
        checkout_common.Enter ${shipping_addr2} into address2 field
        checkout_common.Enter ${shipping_zipcode}${\n} into postalcode field
        # checkout_common.Enter ${shipping_new_instruction} into delivery instruction field     #not ready 
        mobile_common.Wait until loading complete
        # checkout_shipping_address_page.Click confirm update location with address     #not ready
        checkout_shipping_address_page.Click to update location pin if exist
        checkout_shipping_address_page.Tap continue to shipping date button
    END

Checkout using new shipping address mandatory field
    [Arguments]     ${shipping_firstname}=${user['userforNew_address']['shipping_firstname']}       ${shipping_lastname}=${user['userforNew_address']['shipping_lastname']}        
    ...     ${shipping_phone}=${user['userforNew_address']['shipping_phone']}      ${shipping_addr1}=${user['userforNew_address']['shipping_addr1']}
    ...     ${shipping_zipcode}=${multistore_data['store4_zipcode']}   
    IF   "${platform}" == "${platform_list['android']}"
        checkout_shipping_address_page.Click accept pindrop popup if exist
        checkout_shipping_address_page.Click add new shipping address button
        checkout_shipping_address_page.Input shipping address first name        ${shipping_firstname}
        checkout_shipping_address_page.Input shipping address last name         ${shipping_lastname}
        checkout_shipping_address_page.Input shipping address phone number      ${shipping_phone}
        mobile_common.Swipe down
        checkout_shipping_address_page.Input shipping address address line 1    ${shipping_addr1}
        checkout_common.Enter postal code   shipping   ${shipping_zipcode}
        checkout_shipping_address_page.Click to update location pin if exist
        checkout_shipping_address_page.Click save and continue at new address form
        checkout_shipping_address_page.Tap continue to shipping date button
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        checkout_shipping_address_page.Click accept pindrop popup if exist
        checkout_shipping_address_page.Select using new shipping address
        checkout_shipping_address_page.Click accept pindrop popup if exist
        checkout_common.Enter ${shipping_firstname} into firstname field
        checkout_common.Enter ${shipping_lastname} into lastname field
        checkout_common.Enter ${shipping_phone} into phonenumber field
        checkout_common.Enter ${shipping_addr1} into address field
        checkout_common.Enter ${shipping_zipcode} into postalcode field
        mobile_common.Tap done on keyboard
        checkout_shipping_address_page.Click confirm update location with address
        checkout_shipping_address_page.Click to update location pin if exist
        checkout_shipping_address_page.Tap continue to shipping date button
    END

#Billing address
Checkout using existing billing address
    [Arguments]     ${productname}      ${totalamount}
    ...     ${samebillingaddress}='yes'     ${billingslot}=2
    ordersummary_page.Click to show order summary
    ordersummary_page.Verify product title in order summary     ${productname}
    ordersummary_page.Verify total amount in order summary      ${totalamount}
    Run Keyword If      ${samebillingaddress}=='yes'     checkout_billing_address_page.Select same billing address
    Run Keyword If      ${samebillingaddress}=='no'      checkout_billing_address_page.Select different billing address     ${billingslot}
    checkout_billing_address_page.Tap go to payment button

#2C2P page
Checkout by bank transfer
    [Arguments]    ${name}=${payment['banktransfer']['payername']}     ${bank}=${mobile_additional['2c2p']['kasikorn_bank']}     ${email}=${payment['banktransfer']['email']}   ${phone}=${payment['banktransfer']['phone']}
    ...       ${feedback}=${false}       ${feedback_data}=False    ${already_feedback}=False
    checkout_2c2p_page.Select bank transfer option
    checkout_2c2p_page.Select bank option       ${bank}
    ${payment_ref}      ${amount}       checkout_2c2p_page.Get payment ref code and amount from qr code page
    checkout_2c2p_page.Tap return to merchant for bank transfer  # 2c2p page
    mobile_common.Wait until loading complete
    Run keyword if  '${feedback}'=='${false}' and '${already_feedback}'=='${false}'      feedback_feature.Skip to feedback if popup display
    ...     ELSE IF     '${feedback}'           feedback_feature.Give a feedback    ${feedback}     ${feedback_data}
    ...     ELSE IF     '${feedback}'=='False' and '${already_feedback}'   feedback_page.Verify feedback popup not display
    checkout_2c2p_page.Tap done button
    [Return]    ${payment_ref}      ${amount}

Checkout by credit card
    [Arguments]    ${givefeedback}=no    ${message}=${feedback_data["feedback-good"]}    ${thumbs}=${feedback_data["thumbs-up"]}    ${creditcard}=${payment['creditcard_cc']['cardnumber']}      ${expiredate}=${payment['creditcard_cc']['expiredate']}      
    ...     ${cvv}=${payment['creditcard_cc']['cvv']}     ${cardholder}=${payment['creditcard_cc']['cardholder']}      ${email}=${payment['creditcard_cc']['email']}      ${otp}=${payment['creditcard_cc']['otp']}
    IF   "${platform}" == "${platform_list['android']}"
        checkout_2c2p_page.Select credit card
        checkout_2c2p_page.Input credit card          ${creditcard}
        checkout_2c2p_page.Input cardholder name      ${cardholder}
        checkout_2c2p_page.Input expire date          ${expiredate}
        checkout_2c2p_page.Input cvv                  ${cvv}
        checkout_2c2p_page.Tap continue payment
        checkout_2c2p_page.Input otp                  ${otp}
        checkout_2c2p_page.Tap proceed button
        IF  '${givefeedback}'=='no'    
            feedback_feature.Skip to feedback if popup display
        ELSE
            feedback_feature.Give a feedback  ${thumbs}  ${message}
        END
        checkout_2c2p_page.Tap done button
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        checkout_2c2p_page.Select credit card
        checkout_2c2p_page.Input credit card          ${creditcard}         
        checkout_2c2p_page.Input expire date          ${expiredate}         
        checkout_2c2p_page.Input cvv                  ${cvv}               
        mobile_common.Tap done on keyboard
        checkout_2c2p_page.Input cardholder name      ${cardholder}          
        checkout_2c2p_page.Input email address        ${email}     
        mobile_common.Tap done on keyboard         
        checkout_2c2p_page.Tap continue payment
        checkout_2c2p_page.Input otp                  ${otp}
        checkout_2c2p_page.Tap proceed button
        checkout_2c2p_page.Tap back to merchant
        IF  '${autoskip_feedback}'=='${True}'
            feedback_feature.Skip to feedback if popup display
            order_success_page.Click completed button
        ELSE
            feedback_feature.Give a feedback       ${feedback_thumbs}   ${feedback_text}
            order_success_page.Click completed button
        END
    END

Checkout by truemoney
    [Arguments]     ${name}=${truemoney['payername']}       ${email}=${truemoney['email']}       ${phone}=${truemoney['truewallet']}       ${otp}=${truemoney['otp']}     ${simulate}=True
    IF   "${platform}" == "${platform_list['android']}"
        checkout_2c2p_page.Select digital payment
        checkout_2c2p_page.Input payer name         ${name}
        checkout_2c2p_page.Input email address        ${email}
        checkout_2c2p_page.Input phone number        ${phone}
        checkout_2c2p_page.Tap continue payment
        IF  '${simulate}'=='True'
            checkout_2c2p_page.Tap simulate success button
        ELSE
            checkout_2c2p_page.Input truemoney otp      ${otp}
            checkout_2c2p_page.Tap verify button
        END
        checkout_2c2p_page.Tap back to merchant
        order_success_page.Order success message should be displayed
        feedback_feature.Skip to feedback if popup display
        checkout_2c2p_page.Tap done button
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        checkout_2c2p_page.Select digital payment
        checkout_2c2p_page.Input payer name         ${name}
        checkout_2c2p_page.Input email address        ${email}
        checkout_2c2p_page.Input phone number        ${phone}
        checkout_2c2p_page.Tap continue payment
        IF  '${simulate}'=='True'
            checkout_2c2p_page.Tap simulate success button
        ELSE
            checkout_2c2p_page.Input truemoney otp      ${otp}
            checkout_2c2p_page.Tap verify button
        END
        checkout_2c2p_page.Tap back to merchant
        order_success_page.Order success message should be displayed
        IF  '${autoskip_feedback}'=='${True}'
            feedback_feature.Skip to feedback if popup display
            order_success_page.Click completed button
        ELSE
            feedback_feature.Give a feedback       ${feedback_thumbs}   ${feedback_text}
            order_success_page.Click completed button
        END
    END
    
Complete checkout for the products added in basket without verifying amount
    [Documentation]     Add options to checkout by credit card or true money later
    mobile_common.Wait until loading complete
    basket_page.Tap checkout button
    mobile_common.Wait until loading complete
    checkout_common.Tap button go to payment
    ${payment_ref}      ${amount}       checkout_feature.Checkout by bank transfer
    [Return]    ${payment_ref}      ${amount}

# Android

Checkout using existing shipping address
    [Arguments]     ${productname}      ${totalamount}      ${instructions}=none    ${addressslot}=1
    ordersummary_page.Click to show order summary
    ordersummary_page.Verify product title in order summary     ${productname}
    ordersummary_page.Verify total amount in order summary      ${totalamount}
    checkout_shipping_address_page.Input delivery instructions     ${instructions}
    checkout_shipping_address_page.Select existing shipping address and continue to shipping date       ${addressslot}

Fill-in mandatory field for shipping address
    [Arguments]     ${shipping_firstname}       ${shipping_lastname}        ${shipping_phone}
    ...     ${shipping_addr1}       ${shipping_zipcode}
    checkout_shipping_address_page.Click add new shipping address button
    checkout_shipping_address_page.Input shipping address first name        ${shipping_firstname}
    checkout_shipping_address_page.Input shipping address last name         ${shipping_lastname}
    checkout_shipping_address_page.Input shipping address phone number      ${shipping_phone} 
    checkout_shipping_address_page.Input shipping address address line 1    ${shipping_addr1}
    checkout_shipping_address_page.Input shipping address zip code          ${shipping_zipcode}
    DobbyAppCommon.Hide keyboard until success

#Delivery slot
Select delviery slot if exist
    [Arguments]     ${productname}      ${totalamount}      ${deliveryslot}=1
    ordersummary_page.Click to show order summary
    ordersummary_page.Verify product title in order summary     ${productname}
    ordersummary_page.Verify total amount in order summary      ${totalamount}
    checkout_delivery_slot_page.Select deliveryslot     ${deliveryslot}     #
    checkout_delivery_slot_page.Tap continue to billing address button

#Billing address
Checkout using new billing address input all field
    [Arguments]     ${productname}      ${totalamount}
    ...     ${billing_company}     ${billing_firstname}       ${billing_lastname}        ${billing_phone}
    ...     ${billing_addr1}       ${billing_addr2}       ${billing_zipcode}
    checkout_billing_address_page.Select using new billing address
    ordersummary_page.Click to show order summary
    ordersummary_page.Verify product title in order summary     ${productname}
    ordersummary_page.Verify total amount in order summary      ${totalamount}
    checkout_billing_address_page.Input billing address company name      ${billing_company}
    checkout_billing_address_page.Input billing address first name        ${billing_firstname}
    checkout_billing_address_page.Input billing address last name         ${billing_lastname}
    checkout_billing_address_page.Input billing address phone number      ${billing_phone}   
    checkout_billing_address_page.Input billing address address line 1    ${billing_addr1}
    checkout_billing_address_page.Input billing address address line 2    ${billing_addr2}
    checkout_billing_address_page.Input billing address zip code          ${billing_zipcode}
    checkout_billing_address_page.Tap go to payment button

Checkout using new billing address mandatory field
    [Arguments]     ${productname}      ${totalamount}
    ...     ${billing_firstname}       ${billing_lastname}        ${billing_phone}
    ...     ${billing_addr1}        ${billing_zipcode}
    checkout_billing_address_page.Select using new billing address
    ordersummary_page.Click to show order summary
    ordersummary_page.Verify product title in order summary     ${productname}
    ordersummary_page.Verify total amount in order summary      ${totalamount}
    checkout_billing_address_page.Input billing address first name        ${billing_firstname}
    checkout_billing_address_page.Input billing address last name         ${billing_lastname}
    checkout_billing_address_page.Input billing address phone number      ${billing_phone}   
    checkout_billing_address_page.Input billing address address line 1    ${billing_addr1}
    checkout_billing_address_page.Input billing address zip code          ${billing_zipcode}
    checkout_billing_address_page.Tap go to payment button

# Checkout with existing address & payment 
Complete checkout for the products added in basket
    [Arguments]     ${totalamount}    ${instructions}=none    ${payment_method}=CC    ${addressslot}=1    ${deliveryslot}=1    
    basket_page.Tap checkout button
    #Delivery address
    mobile_common.Wait until loading complete    ${long_timeout}
    ordersummary_page.Click to show order summary
    ordersummary_page.Verify total amount in order summary    ${totalamount}
    checkout_shipping_address_page.Clicking on edit button of existing shipping addresss    ${addressslot}
    checkout_shipping_address_page.Input new shipping address delivery instructions    ${instructions}
    checkout_shipping_address_page.Click save and continue at new address form
    checkout_shipping_address_page.Select existing shipping address and continue to shipping date    ${addressslot}
    #Delivery slot
    ordersummary_page.Click to show order summary
    ordersummary_page.Verify total amount in order summary    ${totalamount}
    checkout_delivery_slot_page.Select deliveryslot    ${deliveryslot} 
    checkout_delivery_slot_page.Tap continue to billing address button
    #Billing address
    ordersummary_page.Click to show order summary
    ordersummary_page.Verify total amount in order summary    ${totalamount}
    checkout_billing_address_page.Tap go to payment button   
    IF  '${payment_method}' == 'CC' 
        checkout_feature.Checkout by credit card
    ELSE IF     '${payment_method}' == 'TMW'
        checkout_feature.Checkout by truemoney
    ELSE IF     '${payment_method}' == 'BT'
        checkout_feature.Checkout by bank transfer
    END

Enter shipping detail
    [Arguments]     ${shipping_firstname}   ${shipping_lastname}    ${shipping_phone}   ${shipping_addr1}
    checkout_shipping_address_page.Click add new shipping address button
    checkout_shipping_address_page.Input shipping address first name        ${shipping_firstname}
    checkout_shipping_address_page.Input shipping address last name         ${shipping_lastname}
    checkout_shipping_address_page.Input shipping address phone number      ${shipping_phone}
    checkout_shipping_address_page.Input shipping address address line 1    ${shipping_addr1}
       
Verifying save and continue button is enabled
    [Documentation]     Selecting zipcode, province & district from Json
    ${json}=    Get file    ${CURDIR}/../resources/JSON/zipcode.json       
    ${object}=  Evaluate    json.loads('''${json}''')   json
    ${all data members}=    Set Variable     ${object['data']}
    ${thailandZipCodes}=    Set Variable     ${all data members['thailandZipCodes']}
    FOR    ${allpincode}     IN      @{thailandZipCodes}
        ${id}=    Get From Dictionary   ${allpincode}     id
        ${province}=    Set Variable     ${allpincode['province']['nameTh']}
        checkout_shipping_address_page.Input shipping address zip code          ${id}       #Entering Zipcode
        checkout_shipping_address_page.Select shipping address province     ${province}     
        checkout_shipping_address_page.Select radio option      ${province}                 #Selecting Province
        ${district}=    Set Variable    ${allpincode['districts']}
        FOR    ${alldistricts}     IN      @{district}
            ${dist}=    Get From Dictionary   ${alldistricts}   nameTh
            checkout_shipping_address_page.Select shipping address district     
            checkout_shipping_address_page.Select radio option      ${dist}             #Selecting district
            Element Should Be Enabled       ${checkout.btn_saveAndContinue}                         #Verifying button is enabled
        END
    END

Add new shipping address till Zip Code and verify autopopulated province and district
    [Arguments]    ${shipping_phone}    ${shipping_zipcode}     ${expected_province}    ${expected_district}
    ${random_text}=    Generate Random String    8    [LETTERS]
    checkout_shipping_address_page.Click add new shipping address button
    checkout_shipping_address_page.Input shipping address company name      Address ${random_text}
    checkout_shipping_address_page.Input shipping address first name        FirstName_${random_text}
    checkout_shipping_address_page.Input shipping address last name         LastName_${random_text}
    checkout_shipping_address_page.Input shipping address phone number      ${shipping_phone}
    checkout_shipping_address_page.Input shipping address address line 1    Line 1_${random_text}
    checkout_shipping_address_page.Input shipping address address line 2    Line 2 ${random_text}
    checkout_common.Enter postal code   shipping   ${shipping_zipcode}
    checkout_shipping_address_page.Click to update location pin if exist
    checkout_shipping_address_page.Click edit address by address name  Line 1
    ${field_name}=  Set Variable    province
    checkout_shipping_address_page.Verify the autopopulated address field ${field_name} value is same as ${expected_province}
    ${field_name}=  Set Variable    district
    checkout_shipping_address_page.Verify the autopopulated address field ${field_name} value is same as ${expected_district}

Verify tax id contains 13 or 10 digits number on check out step 3   
    [Arguments]    ${tax_no}   
    ${tax_no}   Convert To String   ${tax_no}
    ${length}   Get Length     ${tax_no} 
    IF  ${length} == 10
        Element Should Be Enabled      ${checkout.btn_completeorder}
    ELSE IF  ${length} == 13
        Element Should Be Enabled       ${checkout.btn_completeorder}
    ELSE    
        Verify error msg display on tax id field        ${mobile_additional['checkout']['message']['error_msg']}
    END

Verify branch id contains 5 digits number on Check out step 3     
    [Arguments]    ${branch_no}  
    ${branch_no}   Convert To String   ${branch_no}
    ${length}   Get Length     ${branch_no}
    IF  ${length} == 5
        Element Should Be Enabled       ${checkout.btn_completeorder}
    ELSE    
        Verify error msg display on branch id field     ${mobile_additional['other_label']['branch_error_msg']}
    END
    
Verify error msg display on tax id field
    [Arguments]    ${error_msg}
    checkout_billing_address_page.Tap on branchid field
        ${errormsg_text} =  DobbyAppCommon.Tap element when ready     ${checkout.tax_id_validation_message}
        Should be equal     ${errormsg_text}   ${error_msg}

Verify error msg display on branch id field
    [Arguments]    ${error_msg}   
        checkout_billing_address_page.Tap on taxid field
        ${errormsg_text} =  DobbyAppCommon.Tap element when ready     ${checkout.branch_id_validation_message}
        Should be equal     ${errormsg_text}   ${error_msg}  
    
Verify default address is same to previous order
    [Arguments]    ${text}
    mobile_common.Wait until loading complete    ${long_timeout}
    checkout_shipping_address_page.Shipping address page should be displayed
    checkout_shipping_address_page.Verify default shipping address    ${text}

Verify map get expand after click on fix pin
    DobbyAppCommon.Swipe down    2
    checkout_shipping_address_page.Click on fix pin
    checkout_shipping_address_page.Verify map get expand

Add new shipping address
    [Arguments]    ${shipping_phone}    ${shipping_zipcode}
    ${random_text}=    Generate Random String    8    [LETTERS]
    checkout_shipping_address_page.Click add new shipping address button
    checkout_shipping_address_page.Input shipping address company name      Company_${random_text}
    checkout_shipping_address_page.Input shipping address first name        FirstName_${random_text}
    checkout_shipping_address_page.Input shipping address last name         LastName_${random_text}
    checkout_shipping_address_page.Input shipping address phone number      ${shipping_phone}
    checkout_shipping_address_page.Input shipping address address line 1    Line 1_${random_text}
    checkout_common.Enter postal code   shipping   ${shipping_zipcode}

Input shipping address when zipcode selected   
    [Arguments]    ${shipping_phone}
    ${random_text}=    Generate Random String    8    [LETTERS]
    checkout_shipping_address_page.Input shipping address company name      Company_${random_text}
    checkout_shipping_address_page.Input shipping address first name        FirstName_${random_text}
    checkout_shipping_address_page.Input shipping address last name         LastName_${random_text}
    checkout_shipping_address_page.Input shipping address phone number      ${shipping_phone}
    checkout_shipping_address_page.Input shipping address address line 1    Line 1_${random_text}
    checkout_shipping_address_page.Input shipping address address line 2    Line 2 ${random_text}

# iOS

#Delivery slot
Select delviery defualt slot if exist
    [Arguments]     ${productname}      ${totalamount}      ${deliveryslot}=1
    ordersummary_page.Click to show order summary
    ordersummary_page.Verify product title in order summary     ${productname}
    ordersummary_page.Verify total amount in order summary      ${totalamount}
    checkout_delivery_slot_page.Verify deliveryslot display
    checkout_delivery_slot_page.Tap continue to billing address button

Checkout by bank transfer until qr code
    [Arguments]    ${bank}=${mobile_additional['2c2p']['kasikorn_bank']} 
    basket_page.Tap checkout button
    checkout_common.Tap button go to payment
    checkout_2c2p_page.Select bank transfer option
    checkout_2c2p_page.Select bank option       ${bank}
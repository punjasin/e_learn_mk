*** Settings ***
Resource        ../../../resources/locators/${platform}/kyc_locator.resource
Resource        ../../../resources/locators/${platform}/common_locator.resource
Resource        ../../../common/mobile/mobile_common.resource

*** Keywords ***
Verify current page is KYC
    DobbyAppCommon.Wait until element is visible except stale       ${kyc.txt_we_here_to_grow_your_business}      timeout=10s

Click fill out detail
    DobbyAppCommon.Tap element when ready       ${kyc.txt_start_filling_in_details}
    
Click do later
    DobbyAppCommon.Tap element when ready       ${kyc.txt_do_it_later}
    
Verify current page is KYC step 1
    DobbyAppCommon.Wait until element is visible except stale       ${kyc.txt_enter_business_details}
    
Fill name and surname
    [Arguments]     ${text}
    IF   "${platform}" == "${platform_list['android']}"
        DobbyAppCommon.Input text to element when ready     ${kyc.name_surname_input}     ${text}
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        DobbyAppCommon.Input text to element when ready     ${kyc.name_surname_input}     ${text}
    END

Fill business name
    [Arguments]     ${text}
    IF   "${platform}" == "${platform_list['android']}"
        DobbyAppCommon.Input text to element when ready     ${kyc.business_name_input}     ${text}
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        DobbyAppCommon.Input text to element when ready     ${kyc.business_name_input}     ${text}
    END

Fill phone number
    [Arguments]     ${text}
    IF   "${platform}" == "${platform_list['android']}"
        DobbyAppCommon.Input text to element when ready     ${kyc.phone_number_input}     ${text}
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        DobbyAppCommon.Input text to element when ready     ${kyc.phone_number_input}     ${text}
    END

Clear phone number
    clear text      ${kyc.input_phone_number}
    
Verify mobile number error message
    DobbyAppCommon.Wait until element is visible except stale       ${kyc.txt_phone_number_must_be}
    Verify continue button is enabled      false

Verify no mobile number error message
    AppiumLibrary.Wait until page does not contain element        ${kyc.txt_phone_number_must_be}
    
Tap continue
    IF   "${platform}" == "${platform_list['android']}"
        DobbyAppCommon.Tap element when ready       ${kyc.txt_continue}
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        DobbyAppCommon.Tap element when ready       ${kyc.continue_true}
    END

Verify current page is KYC step 2
    DobbyAppCommon.Wait until element is visible except stale       ${kyc.txt_choose_your_business_type}
    
Click select business type
    [Arguments]     ${name}
    IF   "${platform}" == "${platform_list['android']}"
        DobbyAppCommon.Tap element when ready       ${kyc.android_touchable_wrapper}
        ${select_dialog_listview_locator}    String.Replace string    ${kyc.select_dialog_listview}    {{name}}    ${name}
        DobbyAppCommon.Tap element when ready       ${select_dialog_listview_locator}
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        DobbyAppCommon.Tap element when ready       ${kyc.ios_touchable_wrapper}
        mobile_common.Input value to pickerwheel in kyc page when ready    ${name}
    END

Click select kyc detail
    [Arguments]     ${topic}    ${name}
    IF   "${platform}" == "${platform_list['android']}"
        ${topic_android_touchable_wrapper_locator}    String.Replace string    ${kyc.topic_android_touchable_wrapper}    {{topic}}    ${topic}
        DobbyAppCommon.Tap element when ready       ${topic_android_touchable_wrapper_locator}
        ${select_dialog_listview_locator}    String.Replace string    ${kyc.select_dialog_listview}    {{name}}    ${name}
        DobbyAppCommon.Tap element when ready       ${select_dialog_listview_locator}
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        ${topic_android_touchable_wrapper_locator}    String.Replace string    ${kyc.topic_android_touchable_wrapper}    {{topic}}    ${topic}
        DobbyAppCommon.Tap element when ready       ${topic_android_touchable_wrapper_locator}
        mobile_common.Input value to pickerwheel in kyc page when ready    ${name}
    END

Fill optional field when select other
    [Arguments]     ${topic}    ${name}
    IF   "${platform}" == "${platform_list['android']}"
        ${topic_business_label_other_locator}    String.Replace string    ${kyc.topic_business_label_other}    {{topic}}    ${topic}
        DobbyAppCommon.Input text to element when ready     ${topic_business_label_other_locator}      ${name}
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        ${business_label_other_locator}    String.Replace string    ${kyc.business_label_other}    {{topic}}    ${topic}
        DobbyAppCommon.Input text to element when ready     ${business_label_other_locator}     ${text}
    END

Verify current page is KYC step additional detail
    [Arguments]     ${businessType}     @{business_details}
    IF   "${platform}" == "${platform_list['android']}"
        FOR   ${topic_detail}  IN      @{business_details}
            ${txt_topic_detail_locator}    String.Replace string    ${kyc.txt_topic_detail}    {{topic_detail}}    ${topic_detail}
            DobbyAppCommon.Wait until element is visible except stale       ${txt_topic_detail_locator}      timeout=${short_timeout}
        END
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        FOR   ${topic_detail}  IN      @{business_details}
            ${txt_topic_detail_locator}    String.Replace string    ${kyc.txt_topic_detail}    {{topic_detail}}    ${topic_detail}
            DobbyAppCommon.Wait until element is visible except stale      ${txt_topic_detail_locator}      timeout=${short_timeout}
        END
    END

Verify current page is KYC step 3 other business
    DobbyAppCommon.Wait until element is visible except stale       ${kyc.txt_other_types_of_businesses}
    
Input detail in step 3 other business
    [Arguments]     ${text}
    IF   "${platform}" == "${platform_list['android']}"
        DobbyAppCommon.Input text to element when ready     ${kyc.input}     ${text}
        DobbyAppCommon.Hide keyboard until success
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        DobbyAppCommon.Input text to element when ready     ${kyc.input}     ${text}
        mobile_common.Tap finish to hide keyboard
    END

Tap finish fill information
    IF   "${platform}" == "${platform_list['android']}"
        DobbyAppCommon.Tap element when ready       ${kyc.txt_done}
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        DobbyAppCommon.Tap element when ready       ${kyc.true_done}
    END

Verify thank you popup
    IF   "${platform}" == "${platform_list['android']}"
        DobbyAppCommon.Wait until element is visible except stale       ${kyc.txt_received_your_business_details}
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        DobbyAppCommon.Wait until element is visible except stale       ${kyc.thank_received_your_business_details}
    END

Verify KYC field is require
    [Arguments]     ${kyc_field}
    ${required_information_locator}    String.Replace string    ${kyc.required_information}    {{kyc_field}}    ${kyc_field}
    DobbyAppCommon.Wait until element is visible except stale   ${required_information_locator}

Verify KYC field is not require
    [Arguments]     ${kyc_field}
    ${unnecessary_locator}    String.Replace string    ${kyc.unnecessary}    {{kyc_field}}    ${kyc_field}
    DobbyAppCommon.Wait until element is visible except stale   ${unnecessary_locator}

Verify continue button is enabled
    [Documentation]     input value = [true ,false]
    [Arguments]     ${enabled}=true
    IF   "${platform}" == "${platform_list['android']}"
        ${txt_enabled_continue_locator}    String.Replace string    ${kyc.txt_enabled_continue}    {{enabled}}    ${enabled}
        DobbyAppCommon.Wait until element is visible except stale   ${txt_enabled_continue_locator}
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        ${txt_enabled_continue_locator}    String.Replace string    ${kyc.continue_by_enable}    {{enabled}}    ${enabled}
        DobbyAppCommon.Wait until element is visible except stale       ${txt_enabled_continue_locator}
    END

Verify finish button is enabled
    [Documentation]     input value = [true ,false]
    [Arguments]     ${enabled}=true
    IF   "${platform}" == "${platform_list['android']}"
        ${txt_enabled_done_locator}    String.Replace string    ${kyc.txt_enabled_done}    {{enabled}}    ${enabled}
        DobbyAppCommon.Wait until element is visible except stale   ${txt_enabled_done_locator}
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        ${txt_enabled_continue_locator}    String.Replace string    ${kyc.txt_enabled_done}    {{enabled}}    ${enabled}
        DobbyAppCommon.Wait until element is visible except stale       ${txt_enabled_continue_locator}
    END

# iOS

Verify continue button is disabled
    ${continue_by_enable_locator}    String.Replace string    ${kyc.continue_by_enable}    {{enabled}}    ${false}
    DobbyAppCommon.Wait until element is visible except stale       ${continue_by_enable_locator}
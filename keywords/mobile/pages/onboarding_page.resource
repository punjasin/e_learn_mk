*** Settings ***
Resource        ../../../resources/locators/${platform}/onboarding_locator.resource
Resource        ../../../resources/locators/${platform}/common_locator.resource
Resource        ../../../common/mobile/mobile_common.resource

*** Keywords ***
Verify CVP page appear
    [Arguments]     ${timeout}=${short_timeout}
    DobbyAppCommon.Wait until element is visible except stale      ${onboarding.txt_online_marketplace}     ${timeout}
    
Verify CVP content
    [Arguments]     ${content}
    ${txt_contains_cvp_content_locator}    String.Replace string    ${onboarding.txt_contains_cvp_content}    {{content}}    ${content}     
    DobbyAppCommon.Wait until page contain element except stale     ${txt_contains_cvp_content_locator}    timeout=${shortTimeout}

Click skip
    DobbyAppCommon.Tap element when ready    ${onboarding.btn_skip}
    
Click back
    DobbyAppCommon.Tap element when ready    ${onboarding.txt_back}
    
Click get start
    DobbyAppCommon.Tap element when ready    ${onboarding.txt_start}
    
Click start shoppping
    DobbyAppCommon.Tap element when ready    ${onboarding.txt_start_order}
    
Click create account
    DobbyAppCommon.Tap element when ready    ${onboarding.txt_create_new_account}

Verify Privacy and content page display
    [Arguments]     ${timeout}=${short_timeout}
    IF   "${platform}" == "${platform_list['android']}"
        DobbyAppCommon.Wait until element is visible except stale  ${onboarding.txt_privacy_policy}      ${timeout}
        DobbyAppCommon.Wait until element is visible except stale  ${onboarding.txt_consent}       ${timeout}
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        DobbyAppCommon.Wait until element is visible except stale  ${onboarding.txt_privacy_policy}      ${timeout}
    END

Click accept all privacy content
    DobbyAppCommon.Tap element when ready     ${onboarding.txt_all_accept}
    
Click see privacy setting page
    DobbyAppCommon.Tap element when ready     ${onboarding.txt_setting}
    
# Seller
    
Click next on seller page
    DobbyAppCommon.Tap element when ready     ${onboarding.btn_next}
    
Input name on seller page
    [Arguments]     ${name}
    DobbyAppCommon.Input text to element when ready     ${onboarding.input_contact_name}  ${name}
    
Input company on seller page
    [Arguments]     ${company}
    DobbyAppCommon.Input text to element when ready     ${onboarding.input_company_name}  ${company}

Input email on seller page
    [Arguments]     ${email}
    DobbyAppCommon.Input text to element when ready     ${onboarding.input_email}  ${email}
    
Input phone number on seller page
    [Arguments]     ${number}
    IF   "${platform}" == "${platform_list['android']}"
        DobbyAppCommon.Input text to element when ready     ${onboarding.input_phone}  ${number}
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        DobbyAppCommon.Input text to element when ready     ${onboarding.phone_number_input}  ${number}
    END

Click category by name
    [Arguments]     ${category}=อาหารสด
    IF   "${platform}" == "${platform_list['android']}"
        ${checkbox_true_category_locator}    String.Replace string    ${onboarding.checkbox_true_category}    {{category}}    ${category}
        ${checkbox_false_category_locator}    String.Replace string    ${onboarding.checkbox_false_category}    {{category}}    ${category}
        ${checkbox_category_locator}    String.Replace string    ${onboarding.checkbox_category}    {{category}}    ${category}
        ${status}       Run keyword and return status       DobbyAppCommon.Wait until element is visible except stale       ${checkbox_true_category_locator}      timeout=${short_timeout}
        IF  ${status}
            DobbyAppCommon.Tap element when ready     ${checkbox_category_locator}
            DobbyAppCommon.Wait until element is visible except stale       ${checkbox_false_category_locator}
        END
        DobbyAppCommon.Tap element when ready     ${checkbox_category_locator}
        DobbyAppCommon.Wait until element is visible except stale   ${checkbox_true_category_locator}
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        ${checkbox_true_category_locator}    String.Replace string    ${onboarding.checkbox_true_category}    {{category}}    ${category}
        ${checkbox_false_category_locator}    String.Replace string    ${onboarding.checkbox_false_category}    {{category}}    ${category}
        DobbyAppCommon.Tap element when ready     ${checkbox_false_category_locator}
        DobbyAppCommon.Wait until element is visible except stale   ${checkbox_true_category_locator}
    END

Click link on seller page
    [Arguments]     ${link}=${moremenu['privacy_seller_url']}
    IF   "${platform}" == "${platform_list['android']}"
        ${link_locator}    String.Replace string    ${onboarding.link}    {{link}}    ${link}
        DobbyAppCommon.Tap element when ready   ${link_locator}
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        ${link_locator}    String.Replace string    ${onboarding.link}    {{link}}    ${link}
        DobbyAppCommon.Tap element when ready     ${link_locator}
        AppiumLibrary.Wait until page does not contain element    ${link_locator}
    END

Click ok button on seller page
    DobbyAppCommon.Tap element when ready     ${onboarding.btn_ok}
    
Current page should be policy web page
    DobbyAppCommon.Wait until element is visible except stale   ${onboarding.txt_main_content_consent}
    
# Android

Click next
    DobbyAppCommon.Tap element when ready    ${onboarding.txt_next}

# # Android Seller

Scroll to bottom page
    FOR     ${i}    IN RANGE    1       30
        ${status}       Run keyword and return status       DobbyAppCommon.Wait until element is visible except stale   ${onboarding.btn_ok}       timeout=3s
        Exit for loop if    ${status}
        DobbyAppCommon.Swipe down
    END

# iOS

Click next at step X
    [Arguments]     ${step}
    ${next_step_locator}    String.Replace string    ${onboarding.next_step}    {{step}}    ${step}
    DobbyAppCommon.Tap element when ready    ${next_step_locator}

# # iOS Seller

Click go to next question
    DobbyAppCommon.Tap element when ready     ${onboarding.navigate_to_next_question}
*** Settings ***
Resource            ../../../resources/locators/web/home_makroproweb_locator.resource
Resource            ../../../common/web/web_common.resource

*** Keywords ***
Click accept browser cookie
    DobbyWebCommon.Click element when ready     ${home_makroproweb.btn_cookie}      timeout=${longTimeout}

Verify provide your zip code & sub district title display
    DobbyWebCommon.Wait until element is visible except stale       ${home_makroproweb.txt_zipcode_title}

Select language
    ${target_lang}      String.Replace string     ${home_makroproweb.btn_lang}       {{lang}}       ${lang.upper()}
    ${lang_button_enable}       Run keyword and return status   SeleniumLibrary.Element should be enabled    ${target_lang}
    IF  "${lang_button_enable}"=="${True}"
        DobbyWebCommon.Click element when ready       ${target_lang}
    END

Input zipcode
    [Arguments]         ${zipcode}
    DobbyWebCommon.Input text to element when ready      ${home_makroproweb.txt_zipcode_input}       ${zipcode}

Select subdistrict
    [Arguments]         ${subdistrict}
    ${subdistrict_locator}    String.Replace string         ${home_makroproweb.zipcode_select_subdistrict}    {{subdistrict}}    ${subdistrict}
    DobbyWebCommon.Scroll element into view when ready      ${subdistrict_locator}
    DobbyWebCommon.Click element when ready        ${subdistrict_locator}

Click save zipcode
    DobbyWebCommon.Click element when ready     ${home_makroproweb.btn_save}

Click on user account icon
    DobbyWebCommon.Click element when ready     ${home_makroproweb.user_icon}

Verify zipcode is outside of MakroPRO delivery area error display
    DobbyWebCommon.Wait until element is visible except stale       ${home_makroproweb.txt_outside_area_error}

Verify save button is disabled
    SeleniumLibrary.Element should be disabled      ${home_makroproweb.btn_save}

Verify cart label
    [Arguments]    ${expect}
    Wait until keyword succeeds  2x   2s    DobbyWebCommon.Verify element text when ready    ${home_makroproweb.txt_cart_total}    ${expect}

Click cart icon
    DobbyWebCommon.Click element when ready    ${home_makroproweb.btn_cart}

Get all sub district
    ${sub_district_list}      DobbyWebCommon.Get webelements when ready      ${home_makroproweb.txt_all_subdistrict}
    ${total_subdistrict}      Get Length              ${sub_district_list}
    ${all_subdistrict}        Create list
    FOR    ${index}              IN RANGE             1         ${total_subdistrict}+1
        ${subdistrict_with_index}    Catenate    SEPARATOR=     ${home_makroproweb.txt_all_subdistrict}     [${index}]
        ${subdistrict_text}      DobbyWebCommon.Get text from element when ready     ${subdistrict_with_index}       timeout=${halfTimeout}
        Collections.Append to list      ${all_subdistrict}      ${subdistrict_text}
    END
    [Return]        ${all_subdistrict}

Verify youtube display
    SeleniumLibrary.Wait until location contains        ${web_additional['global_text']['youtube']}      timeout=${longTimeout}
    ${all_title}       SeleniumLibrary.Get window titles
    ${length}          Get length   ${all_title}
    ${current_index}   Evaluate     ${length}-1
    Should be equal    ${all_title}[${current_index}]    ${youtube_tab}

Verify information page display
    SeleniumLibrary.Wait until location contains     ${web_additional['url']['partnerPromotion']}     timeout=${longTimeout}

Find target banner
    [Arguments]     ${banner_alt_name}
    DobbyWebCommon.Wait until element is visible except stale          ${home_makroproweb.banner_image}        timeout=${halfTimeout}
    DobbyWebCommon.Wait until element is visible except stale          ${home_makroproweb.all_banner_image}    timeout=${halfTimeout} 
    ${banner_list}      DobbyWebCommon.Get webelements when ready      ${home_makroproweb.all_banner_image}
    ${total_banner}     Get Length              ${banner_list}
    FOR    ${index}     IN RANGE             1         ${total_banner}+1
        DobbyWebCommon.Mouse over when ready   ${home_makroproweb.banner_image}
        ${image_attribute}  DobbyWebCommon.Get element attribute when ready    ${home_makroproweb.banner_image}    alt
        ${found_target}     Run keyword and return status   Should be equal     ${image_attribute}      ${banner_alt_name}
        IF   "${found_target}"=="${True}"
            DobbyWebCommon.Click element when ready     ${home_makroproweb.banner_image}
            Exit for loop
        ELSE
            IF  '${index}'=='1'
                DobbyWebCommon.Click element when ready     ${home_makroproweb.banner_left_arrow}
            ELSE
                DobbyWebCommon.Click element when ready     ${home_makroproweb.banner_right_arrow}
            END
        END
    END

Click on makro logo
    DobbyWebCommon.Click element when ready     ${home_makroproweb.makro_logo}

Click categories menu
    DobbyWebCommon.Click element when ready     ${home_makroproweb.btn_categories}

Select main categories
    [Arguments]     ${main_category}
    ${main_category_locator}        String.Replace string       ${home_makroproweb.btn_main_category}     {{main_category}}       ${main_category}
    DobbyWebCommon.Scroll element into view when ready          ${main_category_locator}
    DobbyWebCommon.Mouse over when ready                        ${main_category_locator}

Select sub category
    [Arguments]     ${main_category}       ${sub_category}
    ${main_category_locator}        String.Replace string       ${home_makroproweb.btn_sub_category}    {{main_category}}       ${main_category}
    ${main_with_sub_category_locator}       String.Replace string      ${main_category_locator}     {{sub_category}}     ${sub_category}
    DobbyWebCommon.Mouse over when ready                        ${main_with_sub_category_locator}
    DobbyWebCommon.Click element when ready                     ${main_with_sub_category_locator}

Verify selected zipcode display on header
    [Arguments]     ${zipcode}
    ${zipcode}              Convert to string           ${zipcode}
    ${selected_zipcode}     String.Replace string       ${home_makroproweb.txt_zipcode_selected}    {{zipcode}}     ${zipcode}
    DobbyWebCommon.Wait until element is visible except stale           ${selected_zipcode}       timeout=${longTimeout}

Verify delivery within 24hr product banner display
    [Arguments]    ${category_name}        ${product_name}
    ${banner_product_locator}        String.Replace string     ${home_makroproweb.txt_delivery_1P_product}    {{category_name}}    ${category_name}
    ${banner_product_locator}        String.Replace string     ${banner_product_locator}    {{product_name}}    ${product_name}
    DobbyWebCommon.Scroll element into view when ready         ${banner_product_locator}
***Settings***
Library         SeleniumLibrary     run_on_failure=NOTHING
Library         String
Library         Collections
Library         DateTime
Library         OperatingSystem
Library         pabot.PabotLib
Library         ImapLibrary2
Library         Dialogs
Library         JSONLibrary
Library         ../../resources/library/ReportportalUtils.py
Variables       ../../resources/settings/web.yaml
Variables       ../../resources/data/common.yaml
Variables       ../../resources/data/web.yaml
Variables       ../../resources/data/web/testdata.yaml
Variables       ../../resources/localisation/web/${lang}.yaml
Variables       ../../resources/localisation/web/${lang}_additional.yaml

Resource        ../../resources/locators/web/common_makroproweb_locator.resource
Resource        ../../keywords/web/features/home_makroproweb_feature.resource
Resource        ../../keywords/web/features/123_portal_feature.resource
Resource        ../../keywords/web/features/basket_makroproweb_feature.resource
Resource        ../../keywords/web/features/login_makroproweb_feature.resource
Resource        ../../keywords/web/features/pickpack_feature.resource
Resource        ../../keywords/web/features/product_makroproweb_feature.resource
Resource        ../../keywords/web/features/productlist_makroproweb_feature.resource
Resource        ../../keywords/web/features/search_makroproweb_feature.resource
Resource        ../../keywords/web/features/checkout_makroproweb_feature.resource
Resource        ../../keywords/web/features/payment_makroproweb_feature.resource
Resource        ../../keywords/web/features/2c2p_portal_feature.resource
Resource        ../../keywords/web/features/orderhistory_detail_makroproweb_feature.resource

Resource       DobbyCommonLibrary/DobbyCommon.robot
Resource       DobbyCommonLibrary/DobbyWebCommon.robot

*** Keywords ***
Open website
    [Arguments]     ${url}
    Set Library search order    DobbyWebCommon    SeleniumLibrary
    SeleniumLibrary.Set selenium timeout      ${minTimeout}
    DobbyWebCommon.Open chrome browser        ${url}            ${chrome_browser}
    SeleniumLibrary.Maximize browser window

Makro pro web setup
    [Arguments]     ${zipcode}=${multistore_data['samaedam_zipcode']}   ${subdistrict}=${multistore_data['samaedam_subdistrict']['${lang}']}
    web_common.Open makro pro web
    home_makroproweb_feature.Enter zip code when open new session      ${zipcode}      ${subdistrict}
    home_makroproweb_page.Select language
    web_common.Wait for page load
    SeleniumLibrary.Reload page
    home_makroproweb_page.Verify selected zipcode display on header    ${zipcode}

Open makro pro web
    web_common.Open website     ${maknet_url}
    home_makroproweb_page.Click accept browser cookie
    web_common.Set language cookie

Close browser
    Run keyword if test failed      Run keyword and ignore error    SeleniumLibrary.Log source
    Run keyword if test failed              web_common.Capture screenshot path
    SeleniumLibrary.Close all browsers

Capture screenshot path
    ${current_date_time}=   DateTime.Get current date   result_format=epoch
    ${IMG_PATH}    SeleniumLibrary.Capture page screenshot    screenshot-${current_date_time}.png

Set language cookie
    SeleniumLibrary.Add cookie    lang       ${lang}
    SeleniumLibrary.Reload page
    web_common.Wait for page load

Wait for page load
    ${readyState}=    Execute Javascript    return document.readyState
    WHILE    '${readyState}' != 'complete'
        ${readyState}=    Execute Javascript    return document.readyState
    END
    Sleep    1s

Capture test status
    [Arguments]    ${suiteDirectory}=${EXECDIR}    ${metadata}= 
    ${currentTime}=     Get Current Date
    ${currentTime}=     Replace String      ${currentTime}    :   .
    ${currentTime}=     Replace String      ${currentTime}    ${SPACE}  T

    ${ScreenshotDirectory}=     Set Variable    ${suiteDirectory}${/}Screenshots${/}
    Set screenshot directory   ${ScreenshotDirectory}
    Run keyword and return status    SeleniumLibrary.Capture page screenshot    ${TEST NAME}${metadata}_${currentTime}_${TEST STATUS}.png
    [Return]     ${suiteDirectory}${/}Screenshots${/}${TEST NAME}${metadata}_${currentTime}_${TEST STATUS}.png

Select from list by label
    [Arguments]     ${locator}     ${label}     ${timeout}=60s
    SeleniumLibrary.Wait until element is visible    ${locator}     ${timeout}
    SeleniumLibrary.Select from list by Label        ${locator}     ${label}

Get timestamp
    ${current_time}=   Get current date    result_format=epoch    exclude_millis=true
    ${current_time}=    Convert to string   ${current_time}
    ${current_time_epoch}=      Get Substring    ${current_time}    0  10
    [Return]       ${current_time_epoch}

Random phone
    ${randomPhone}  Get Current Date
    ${randomPhone}  Convert Date        ${randomPhone}  result_format=%d%H%M%S%ms
    ${randomPhone}  Remove String       ${randomPhone}  s
    Set global variable     ${randomPhone}
    [Return]    ${randomPhone}

Convert month to index
    [Arguments]   ${month}
    IF    '${month}' == 'ม.ค.' or '${month}' == 'Jan'
        ${month_index}  Set variable  1
    ELSE IF    '${month}' == 'ก.พ.' or '${month}' == 'Feb'
        ${month_index}  Set variable  2
    ELSE IF    '${month}' == 'มี.ค.' or '${month}' == 'Mar'
        ${month_index}  Set variable  3
    ELSE IF    '${month}' == 'เม.ย.' or '${month}' == 'Apr'
        ${month_index}  Set variable  4
    ELSE IF    '${month}' == 'พ.ค.' or '${month}' == 'May'
        ${month_index}  Set variable  5
    ELSE IF    '${month}' == 'มิ.ย.' or '${month}' == 'Jun'
        ${month_index}  Set variable  6
    ELSE IF    '${month}' == 'ก.ค.' or '${month}' == 'Jul'
        ${month_index}  Set variable  7
    ELSE IF    '${month}' == 'ส.ค.' or '${month}' == 'Aug'
        ${month_index}  Set variable  8
    ELSE IF    '${month}' == 'ก.ย.' or '${month}' == 'Sep'
        ${month_index}  Set variable  9
    ELSE IF    '${month}' == 'ต.ค.' or '${month}' == 'Oct'
        ${month_index}  Set variable  10
    ELSE IF    '${month}' == 'พ.ย.' or '${month}' == 'Nov'
        ${month_index}  Set variable  11
    ELSE IF    '${month}' == 'ธ.ค.' or '${month}' == 'Dec'
        ${month_index}  Set variable  12
    END
    [Return]  ${month_index}

Convert month in thai
    [Arguments]   ${month}
    IF    '${month}' == '1'
        ${month_thai}  Set variable  ม.ค.
    ELSE IF    '${month}' == '2'
        ${month_thai}  Set variable  ก.พ.
    ELSE IF    '${month}' == '3'
        ${month_thai}  Set variable  มี.ค.
    ELSE IF    '${month}' == '4'
        ${month_thai}  Set variable  เม.ย.
    ELSE IF    '${month}' == '5'
        ${month_thai}  Set variable  พ.ค.
    ELSE IF    '${month}' == '6'
        ${month_thai}  Set variable  มิ.ย.
    ELSE IF    '${month}' == '7'
        ${month_thai}  Set variable  ก.ค.
    ELSE IF    '${month}' == '8'
        ${month_thai}  Set variable  ส.ค.
    ELSE IF    '${month}' == '9'
        ${month_thai}  Set variable  ก.ย.
    ELSE IF    '${month}' == '10'
        ${month_thai}  Set variable  ต.ค.
    ELSE IF    '${month}' == '11'
        ${month_thai}  Set variable  พ.ย.
    ELSE
        ${month_thai}  Set variable  ธ.ค.
    END
    [Return]  ${month_thai}

Switch to last tab
    ${handles}      SeleniumLibrary.Get window handles
    ${length}       Get length  ${handles}
    ${last_index}   Evaluate   ${length}-1
    SeleniumLibrary.Switch Window  ${handles}[${last_index}]

Set product name from api data
    [Arguments]   ${product_info}
    [Documentation]     When open device lang en, product name is en but sometime found empty string in product en from api result
    ...     so,it need to check if it is empty string or not
     IF  "${lang}"=="en"
        ${product_name}       Set variable        ${product_info['productname_en']}
        IF   "${product_name}"=="${empty}"
            ${product_name}     Set variable      ${product_info['productname']}
        END
    ELSE
        ${product_name}       Set variable        ${product_info['productname']}
    END
    Collections.Set to dictionary   ${product_info}      productname=${product_name}
    [Return]    ${product_info}

Switch back to first tab
    ${handles}      SeleniumLibrary.Get window handles
    SeleniumLibrary.Switch window  ${handles}[0]

Get price without currency
    [Arguments]     ${price_locator}    ${decimal}=.00    ${currency}=฿
    ${price_text}       DobbyWebCommon.Get text from element when ready     ${price_locator}
    ${price_text}       String.Remove string      ${price_text}    ${decimal}   ${space}   ${currency}
    [Return]            ${price_text}

Click increase qty
    [Arguments]     ${add_amount}       ${qty_locator}      ${increase_btn_locator}
    ${current_qty}      DobbyWebCommon.Get value from element when ready        ${qty_locator}
    ${newqty}    Evaluate   ${current_qty}+${add_amount}
    FOR     ${round}    IN RANGE    ${add_amount} 
       DobbyWebCommon.Click element when ready         ${increase_btn_locator}
       web_common.Wait for page load
    END
    [Return]    ${newqty}

Click decrease qty
    [Arguments]     ${del_amount}      ${qty_locator}      ${decrease_btn_locator}
    ${current_qty}      DobbyWebCommon.Get value from element when ready        ${qty_locator}
    ${newqty}       Evaluate    ${current_qty}-${del_amount}  
    FOR     ${round}    IN RANGE    ${del_amount}
        DobbyWebCommon.Click element when ready          ${decrease_btn_locator}
        web_common.Wait for page load
    END
    [Return]       ${newqty}

Wait until toast message dissapear
    DobbyWebCommon.Wait until element is visible except stale    ${common_makroproweb.txt_alert}
    SeleniumLibrary.Wait until element is not visible      ${common_makroproweb.txt_alert}      timeout=${longTimeout}

Set seller name from api data
    [Arguments]    ${dynamic_productinfo}
    IF    "${dynamic_productinfo['seller']}" == "${seller_name['1P_shop']}"
        Collections.Set to dictionary   ${dynamic_productinfo}      seller=${product_common['1P_basket_seller']}
    END
    [Return]    ${dynamic_productinfo}

Get full day of week by short day
    [Arguments]           ${short_day}
    [Documentation]       Input: Wed, Output:Wednesday
    ${day_mapping}        Create Dictionary    Mon=Monday    Tue=Tuesday    Wed=Wednesday    Thu=Thursday    Fri=Friday    Sat=Saturday    Sun=Sunday
    ${full_day_name}      Set Variable    ${day_mapping}[${short_day}]
    [Return]              ${full_day_name}

Get delivery month
    [Documentation]      output return en: May, th: พ.ค.
    ${full_date}    web_common.Get date by count day after today date
    ${full_date}    String.Split string      ${full_date}        ${space}
    ${month}        Set variable          ${full_date[2]}  
    IF   "${lang}"=="th"
        ${month_index}    web_common.Convert month to index    ${month}
        ${month}          web_common.Convert month in thai     ${month_index}
    END
    [Return]         ${month}

Get date by count day after today date
    [Arguments]         ${total_day_after_today}=1
    [Documentation]     Example: if today is 23 May+1 day, output will be Wed 24 May
    ${today}            DateTime.Get current date
    ${new_date}         DateTime.Add time to date      ${today}           ${total_day_after_today} days
    ${new_date}         DateTime.Convert date          ${new_date}        result_format=%a %d %B
    [Return]            ${new_date}
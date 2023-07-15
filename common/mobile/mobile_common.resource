*** Settings ***
Library         AppiumLibrary       run_on_failure=No Operation
Library         DebugLibrary
Library         String
Library         Collections
Library         DateTime
Library         OperatingSystem
Library         pabot.PabotLib
Library         ../../resources/library/AppiumUtils.py
Library         ../../resources/library/RobotUtils.py
Library         ../../resources/library/ReportportalUtils.py
Library         ../../resources/library/DeleteRegisteredUsers.py
Library         ../../resources/library/email_utils.py
Resource       DobbyCommonLibrary/DobbyCommon.robot
Resource       DobbyCommonLibrary/DobbyAppCommon.robot
Resource       ../../keywords/mobile/features/basket_feature.resource
Resource       ../../keywords/mobile/features/checkout_feature.resource
Resource       ../../keywords/mobile/features/debug_feature.resource
Resource       ../../keywords/mobile/features/favourite_feature.resource
Resource       ../../keywords/mobile/features/feedback_feature.resource
Resource       ../../keywords/mobile/features/homepage_feature.resource
Resource       ../../keywords/mobile/features/kyc_feature.resource
Resource       ../../keywords/mobile/features/login_feature.resource
Resource       ../../keywords/mobile/features/more_page_feature.resource
Resource       ../../keywords/mobile/features/myaccount_feature.resource
Resource       ../../keywords/mobile/features/onboarding_feature.resource
Resource       ../../keywords/mobile/features/order_detail_feature.resource
Resource       ../../keywords/mobile/features/order_history_feature.resource
Resource       ../../keywords/mobile/features/pdpa_cookie_feature.resource
Resource       ../../keywords/mobile/features/privacy_consent_feature.resource
Resource       ../../keywords/mobile/features/product_feature.resource
Resource       ../../keywords/mobile/features/promotion_feature.resource
Resource       ../../keywords/mobile/features/register_feature.resource
Resource       ../../keywords/mobile/features/search_feature.resource
Resource       ../../keywords/mobile/features/tnc_feature.resource
Resource       ../../keywords/mobile/features/voucher_feature.resource
Variables      ../../resources/localisation/mobile/${lang}.yaml
Variables       ../../resources/localisation/mobile/${lang}_additional.yaml
Variables       ../../resources/settings/${platform}.yaml
Variables       ../../resources/data/common.yaml
Variables       ../../resources/data/${platform}.yaml
Variables       ../../resources/data/product.yaml
Variables       ../../resources/data/mobile/testdata.yaml
Variables       ../../resources/settings/aws.yaml
Variables       ../../resources/data/otp.yaml

*** Keywords ***
Open application
    # [Documentation]  Open application that already exist in mobile phone
    [Arguments]      ${device_langugage}=${device_language_th}     ${no_reset}=${False}     ${full_reset}=${True}
    IF  ${doppio_farm} == ${TRUE}    
        DobbyAppCommon.Init mobile farm configuration
    END
    IF  "${platform}" == "${platform_list['ios']}"
        ${capability}       Create dictionary                   
        ...                 language=${device_langugage}
        ...                 locale=${device_langugage}
        ...                 platformName=${platform}
        ...                 platformVersion=${platformVersion}
        ...                 deviceName=${deviceName}
        ...                 newCommandTimeout=${0}
        ...                 autoAcceptAlerts=${TRUE}
        ...                 wdaLocalPort=${systemPort}
        ...                 noReset=${no_reset}
        ...                 autoGrantPermissions=${TRUE}
        ...                 launchTimeout=${48000}
        ...                 reduceMotion=${TRUE}
        ...                 boundElementsByIndex=${TRUE}
        ...                 nativeWebScreenshot=true
        ...                 bundleId=${bundleId}
        ...                 browserstack.idleTimeout=${browserstack.idleTimeout}

        Collections.Set to dictionary    ${capability}
        ...                 fullReset=${FALSE}
        ...                 noReset=${FALSE}
        Log             ${capability}
    ELSE IF   "${platform}" == "${platform_list['android']}"
        ${capability}       Create dictionary
        ...                 language=${device_langugage}
        ...                 locale=${device_langugage}
        ...                 platformName=${platform}
        ...                 platformVersion=${androidVersion}
        ...                 udid=${udid}
        ...                 noReset=${no_reset}
        ...                 appPackage=${appPackage}
        ...                 appActivity=${appActivity}
        ...                 newCommandTimeout=0
        ...                 systemPort=${systemPort}
        ...                 adbExecTimeout=120000
        ...                 uiautomator2ServerInstallTimeout=120000
        ...                 automationName=${automationName}
        ...                 app=${app}
        ...                 browserstack.idleTimeout=${browserstack.idleTimeout}

        Collections.Set to dictionary    ${capability}
        ...                 appPackage=${appPackage}
        ...                 appActivity=${appActivity}
        Log             ${capability}
    END

    IF  "${app}" != "None"
        Collections.Set to dictionary    ${capability}
        ...                 app=${app}
    END

    IF    ${browserstack} == ${TRUE}
        Collections.Set to dictionary    ${bstack:options}    sessionName=${TEST NAME}
        mobile_common.Setup browserstack build name
        Collections.Remove from dictionary      ${capability}       wdaLocalPort
        Collections.Set to dictionary    ${capability}
        ...                  bstack:options=&{bstack:options}
        ...                  app=${app}
        ...                  deviceName=${deviceName}

        ${remoteUrl}         Set Variable    ${remoteUrlBrowserstack}
        Log             ${capability}
    END

    Set appium timeout  ${global_timeout}

    IF   "${platform}" == "${platform_list['android']}"
        AppiumLibrary.Open application    remote_url=${remoteUrl}
        ...                 &{capability}
        ...                 automationName=${automationName}
    ELSE IF  "${platform}" == "${platform_list['ios']}"
        AppiumLibrary.Open application    remote_url=${remoteUrl}
        ...                 automationName=XCUITest
        ...                 &{capability}
        Run keyword and ignore error        mobile_common.Skip system pop-up
    END

Setup browserstack build name
    ${TESTTAGS}          OperatingSystem.Get environment variable    TESTTAGS
    ${BUILD_NUMBER}      OperatingSystem.Get environment variable    BUILD_NUMBER
    ${LANGUAGE}          OperatingSystem.Get environment variable    LANGUAGE
    ${platform_title}    String.Convert to title case    ${platform}
    ${testtags_title}    String.Convert to title case    ${TESTTAGS}
    ${lang_upper}        String.Convert to upper case    ${LANGUAGE}

    IF    '${BUILD_NUMBER}' != '${EMPTY}'
        Collections.Set to dictionary    ${bstack:options}    buildName=Build ${BUILD_NUMBER} ${platform_title} - ${testtags_title} [${lang_upper}]
    ELSE
        Collections.Set to dictionary    ${bstack:options}    buildName=${platform_title} - ${testtags_title} [${lang_upper}]
    END

Mango Suite Setup
    Set library search order      AppiumLibrary
    Set appium timeout            ${appium_timeout}

Mango Test Setup
    [Arguments]     ${zipcode}=${multistore_data['samaedam_zipcode']}       ${subdistrict}=${multistore_data['samaedam_subdistrict']['${lang}']} 
    mobile_common.Open application     ${lang}
    onboarding_feature.Skip onboarding process if exist
    homepage_feature.Enter zip code when open application       ${zipcode}      ${subdistrict}    #some testcase use storeCode if you change zipcode please change storeCode
    mobile_common.Toast message should display and close    ${homepage.toast_success}
    pdpa_cookie_feature.Accept all for sdk cookie popup if exist
    DobbyAppCommon.Set resolution       ${default_scroll_view}

Mango Test Teardown
    Run keyword if test failed            mobile_common.Capture screenshot path
    AppiumLibrary.Close all applications

Capture screenshot path
    ${current_date_time}=   DateTime.Get current date   result_format=epoch
    ${IMG_PATH}    AppiumLibrary.Capture page screenshot    screenshot-${current_date_time}.png

Wait until splash screen disappear
    AppiumLibrary.Wait until page does not contain element      ${onboarding.splash_screen}

Tap my orders menu
    [Documentation]     remove and use comment after backend issue fixed
    DobbyAppCommon.Tap element when ready        ${navigation.btn_myorder}

Tap more menu
    DobbyAppCommon.Tap element when ready   ${navigation.btn_moremenu}
    mobile_common.Wait until loading complete
    DobbyAppCommon.Wait until element is visible except stale       ${moremenu_page.title}

Tap basket menu
    DobbyAppCommon.Tap element when ready   ${navigation.btn_basket}
    mobile_common.Wait until loading complete
    ${found_banner}     Run keyword and return status   DobbyAppCommon.Wait until element is visible except stale       ${basket.btn_close_popup_swipe_delete}      timeout=${shortTimeout}
    IF   "${found_banner}"=="${True}"
        FOR     ${i}    IN RANGE    0   4
            ${found_banner}     Run keyword and return status   DobbyAppCommon.Wait until element is visible except stale       ${basket.btn_close_popup_swipe_delete}      timeout=${shortTimeout}
            Exit for loop if    '${found_banner}'=='${False}'
            basket_page.Close onboarding swipe to remove from basket
        END
        Should not be true      ${found_banner}        msg=banner not close as expected
    END

Tap shopping menu
    [Arguments]     ${accept_popup}=True    ${login}=False
    DobbyAppCommon.Tap element when ready  ${navigation.btn_shopping_cart}
    IF  ${accept_popup}
        privacy_consent_feature.Accept all for privacy popup if exist
        tnc_feature.Accept terms and conditions popup if exist
        IF  ${login} == 'True'
            tnc_feature.Update terms and conditions popup if exist
            privacy_consent_feature.Confirm update privacy setting if exist
            homepage_feature.Skip register makro point if exist
        END
    END
    mobile_common.Wait until loading complete

Find element and tap
    [Arguments]     ${locator}      ${moveto}=Top   ${scroll_panel}=${default_scroll_view}      ${percent}=${swipeLongScroll}    ${timeout}=${shortTimeout}
    DobbyAppCommon.Find element    ${locator}   scroll_panel=${scroll_panel}    moveto=${moveto}    percent=${percent}  timeout=${timeout}
    DobbyAppCommon.Tap element when ready      ${locator}

Convert mobile number to mobile format
    [Documentation]     Input: 0600000006           Output: 060 000 0006
    [Arguments]     ${mobile_no}
    ${format_mobile}     Catenate    SEPARATOR=" "     ${mobile_no}[0:3]   ${mobile_no}[3:6]   ${mobile_no}[6:10]
    ${format_mobile}    String.Replace string    ${format_mobile}    "    ${Empty}
    [Return]             ${format_mobile}

# iOS KW
Skip system pop-up
    [Documentation]    Tap don't allow to skip notification alert when open app
    AppiumLibrary.Wait until element is visible               ${popup.btn_dont_allow}           ${short_timeout}
    AppiumLibrary.Tap                                         ${popup.btn_dont_allow}                   

Tap finish to hide keyboard
    DobbyAppCommon.Tap element when ready       ${keyboard.btn_done}

Tap cancel to hide keyboard
    DobbyAppCommon.Tap element when ready       ${keyboard.btn_cancel}

Hide keyboard down
    [Documentation]     ios will tap done to hide keyboard but android can use appium library directly
    IF   "${platform}" == "${platform_list['android']}"
       AppiumLibrary.Hide keyboard
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        mobile_common.Tap done on keyboard
    END

Tap delete button on ios keyboard
    DobbyAppCommon.Tap element when ready       ${keyboard.btn_delete}

Tap favourite list menu
    DobbyAppCommon.Tap element when ready        ${navigation.btn_favourite}

Tap back from product page when click shopping menu
    [Documentation]  Use this kw when click shopping menu and still in product page
    IF   "${platform}" == "${platform_list['android']}"
        Repeat keyword      2 times     DobbyAppCommon.Tap element when ready    ${mobile_common.btn_shopping}
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        DobbyAppCommon.Tap element when ready   ${mobile_common.btn_shopping}
        product_page.Tap back at product detail page
    END

Go back to main page
    [Documentation]     Back from search result to main page
    IF   "${platform}" == "${platform_list['android']}"
        AppiumLibrary.Go back
        DobbyAppCommon.Clear text when ready       ${mobile_common.edit_text}
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        mobile_common.Tap go back icon
    END

Scroll down to element
    [Arguments]     ${locator}
    IF   "${platform}" == "${platform_list['android']}"
        FOR     ${i}    IN RANGE    0   4
            ${result}=  Run keyword and return status   AppiumLibrary.Wait until element is visible   ${locator}  timeout=5s
            Exit for loop if    ${result}
            DobbyAppCommon.Swipe down
        END
        Should be true  ${result}   msg='Unable to scroll to element after 4 retry'
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        FOR     ${i}    IN RANGE    0   10
            ${result}=  Run keyword and return status   AppiumLibrary.Wait until element is visible   ${locator}  timeout=5s
            Exit for loop if    ${result}
            DobbyAppCommon.Swipe down
        END
        Should be true  ${result}   msg='Unable to scroll to element after 10 retry'
    END

Swipe up to top of page
    IF   "${platform}" == "${platform_list['android']}"
        FOR  ${val}     IN RANGE     20
            ${status}       Run keyword and return status       DobbyAppCommon.Wait until element is visible except stale       ${mobile_common.search_input}     timeout=${short_timeout}
            Exit for loop if    ${status}
            Swipe by percent    50  20  50  80    duration=1000  #swipe up
        END
        Swipe by percent    50  20  50  80    duration=1000  #swipe up
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        FOR  ${val}     IN RANGE     20
            ${status}       Run keyword and return status       DobbyAppCommon.Wait until element is visible except stale       ${mobile_common.search_input}     timeout=${short_timeout}
            Swipe by percent    50  20  50  80    duration=1000  #swipe up
            Exit for loop if    ${status}
        END
        Swipe by percent    50  20  50  80    duration=1000  #swipe up
    END

Swipe up
    [Arguments]     ${round}=1      ${duration}=1000
    FOR  ${val}     IN RANGE     ${round}
        Swipe by percent    50  20  50  80    duration=${duration}  #swipe up
    END

Swipe down
    [Arguments]     ${round}=1      ${duration}=1000
    FOR  ${val}     IN RANGE     ${round}
        Swipe by percent    50  80  50  20    duration=${duration}  #swipe down
    END

Get element attribute when ready
    [Arguments]     ${locator}    ${attribute}
    AppiumLibrary.Wait until element is visible           ${locator}
    ${att}=     AppiumLibrary.Get Element Attribute   ${locator}      ${attribute}
    [Return]      ${att}

Find element
    [Documentation]  Swip to top for find element
    [Arguments]         ${target_element}    ${moveto}=Top      ${need_scroll}=True      ${scroll_panel}=${default_scroll_view}    ${percent}=0.7       ${time}=${time_scroll}
    IF   "${platform}" == "${platform_list['android']}"
        Run keyword if      '${scroll_panel}'!='${default_scroll_view}'     DobbyAppCommon.Set resolution             ${scroll_panel}
        Run keyword if      '${need_scroll}'=='True'        Scroll element      ${target_element}   ${scroll_panel}   ${moveto}  ${percent}         ${time}
        ...     ELSE        DobbyAppCommon.Wait until element is visible except stale      ${target_element}        ${short_timeout}
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        Run keyword if      '${scroll_panel}'!='${default_scroll_view}'     DobbyAppCommon.Set resolution             ${scroll_panel}
        Run keyword if      '${need_scroll}'=='True'        Scroll element      ${target_element}   ${scroll_panel}   ${moveto}  ${percent}=0.3         ${time}
        ...     ELSE        DobbyAppCommon.Wait until element is visible except stale      ${target_element}    ${short_timeout}
    END

Scroll element
    [Documentation]     Scroll element
    [Arguments]         ${target_element}       ${scroll_panel}=${default_scroll_view}    ${moveto}=Top      ${percent}=0.7   ${time}=${time_scroll}
    Run Keyword if      '${scroll_panel}'!='${default_scroll_view}'   DobbyAppCommon.Set Resolution      ${scroll_panel}    ${percent}
    FOR    ${i}    IN RANGE    10
        ${element_status}=      Run keyword and return status       DobbyAppCommon.Wait until element is visible except stale      ${target_element}      ${time}
        Run keyword if  '${element_status}'=='False'     DobbyAppCommon.Move to    ${moveto}
        Exit for loop if    '${element_status}'=='True'
    END

Tap X button to close webview
    DobbyAppCommon.Tap element when ready       ${mobile_common.webview_close_icon}

Toast message should display and close
    [Arguments]     ${locator}
    AppiumLibrary.Wait until page does not contain element     ${locator}

Wait until toast message disappeared
    AppiumLibrary.Wait until page does not contain element        ${mobile_common.toast}  

Wait until loading complete
    [Arguments]         ${timeout}=${global_timeout}
    ${status}=  Run keyword and return status   AppiumLibrary.Wait until page contains element    ${mobile_common.loader}      timeout=2s
    Run keyword if    '${status}'=='${True}'    AppiumLibrary.Wait until page does not contain element    ${mobile_common.loader}      ${timeout}

End of month date evaluation
    [Arguments]         ${date}
    ${current_month}=    Get Current Date   result_format=%m 
    ${current_month}=       Convert To Integer      ${current_month}
    ${28day}=   Evaluate    ${current_month} in [2]
    ${30day}=   Evaluate    ${current_month} in [4,6,9,11]
    ${31day}=   Evaluate    ${current_month} in [1,3,5,7,8,10,12]

    ${tmpday1}=   Evaluate    ${date}-28
    ${tmpday2}=   Evaluate    ${date}-30
    ${tmpday3}=   Evaluate    ${date}-31
    ${next_month}=   Evaluate    ${current_month}+1

    ${new_date} =	Set Variable If	   
    ...  ${date}>28 and ${28day}==True      ${tmpday1}
    ...  ${date}<=28 and ${28day}==False    ${date}
    ...  ${date}>30 and ${30day}==True      ${tmpday2}
    ...  ${date}<=30 and ${28day}==False    ${date}
    ...  ${date}>31 and ${31day}==True      ${tmpday3}
    ...  ${date}<=31 and ${28day}==False    ${date}

    ${month} =	Set Variable If	   
    ...  ${date}>28 and ${28day}==True      ${next_month}
    ...  ${date}<=28 and ${28day}==False    ${current_month}
    ...  ${date}>30 and ${30day}==True      ${next_month}
    ...  ${date}<=30 and ${28day}==False    ${current_month}
    ...  ${date}>31 and ${31day}==True      ${next_month}
    ...  ${date}<=31 and ${28day}==False    ${current_month}
    ${new_date}=     Left padding if needed      ${new_date}
    IF    '${lang}'=='th'
        ${month}=  mobile_common.Convert month in thai    ${month}
    ELSE 
        ${month}=  DateTime.Get current date   result_format=%b
    END
    [Return]    ${new_date}     ${month}

Get current date day of week
    ${day} =	Get Current Date   result_format=%A
    [Return]   ${day}

Get tomorrow date of week
    ${tomorrow}=       Get current date    result_format=%A    increment=+1 day
    [Return]   ${tomorrow}

Get current date year
    ${day} =	Get Current Date   result_format=%Y
    [Return]   ${day}

Get current time format H:M
    ${time} =	Get Current Date  result_format=%H:%M
    [Return]   ${time}

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

Left padding if needed
    [Arguments]     ${number}
    ${number}   Convert To String   ${number}
    ${length}   Get Length      ${number}
    IF    ${length} == 1
        ${new_number}=   Catenate   SEPARATOR=  0   ${number}
        ${number}  Set variable  ${new_number}
    END
    [Return]      ${number}

Tap go back icon
    DobbyAppCommon.Tap element when ready   ${mobile_common.icon_button}
    mobile_common.Wait until loading complete

# Android

Open Chrome browser with url
    [Arguments]      ${link}
    Run keyword if  ${doppio_farm}==True    mobile_common.Init mobile farm configuration
    ${capability}       Create dictionary          automationName=UiAutomator2
    ...                 platformName=android
    ...                 platformVersion=${androidVersion}
    ...                 udid=${udid}
    ...                 androidPackage=com.android.chrome
    ...                 browserName=Chrome
    ...                 appActivity=${appActivity}
    ...                 noReset=false
    ...                 newCommandTimeout=0
    ...                 systemPort=${systemPort}
    Open Application    remote_url=${remoteUrl}
    ...                 automationName=UiAutomator2
    ...                 &{capability}
    Go to url           ${link}

Set Chrome
    ${should_skip}  Run Keyword And Return Status    AppiumLibrary.Wait Until Element Is Visible    ${mobile_common.welcome_to_chrome}        20
    IF  '${should_skip}' == '${True}'
        AppiumLibrary.Wait Until Element Is Visible                     ${mobile_common.btn_terms_accept}
        DobbyAppCommon.Tap element when ready                          ${mobile_common.btn_terms_accept}   
        Sleep                                             5s
        ${BrowserFastAlert}  Run Keyword And Return Status  AppiumLibrary.Wait Until Element Is Visible    ${mobile_common.txt_browse_faster}   10
        Run Keyword If  ${BrowserFastAlert}         DobbyAppCommon.Tap element when ready       ${mobile_common.btn_next_button}
        Sleep                                             5s
        AppiumLibrary.Wait Until Element Is Visible                      ${mobile_common.txt_turn_on_sync}            20
        AppiumLibrary.Wait Until Element Is Visible                      ${mobile_common.btn_negative_button}
        DobbyAppCommon.Tap element when ready              ${mobile_common.btn_negative_button}
    END

Swipe right to left android
    [Arguments]     ${number}=1
    FOR     ${round}    IN RANGE    ${number}    
        Swipe by percent    80  50  20  50    duration=1000
        mobile_common.Wait until loading complete
    END 
    
Swipe left to right android
    [Arguments]     ${number}=1
    FOR     ${round}    IN RANGE    ${number}    
        Swipe by percent    20  50  80  50    duration=1000
        mobile_common.Wait until loading complete
    END 

Input text one by one
    [Arguments]         ${locator}      ${text}
    DobbyAppCommon.Wait until element is visible except stale       ${locator} 
    @{characters} =	Split String To Characters      ${text}
    FOR     ${input}    IN      @{characters}
        DobbyAppCommon.Input text to element when ready          ${locator}   ${input}
    END

Should receive push notification with correct title and body
    [Arguments]     ${noti_title}   ${noti_body}
    AppiumLibrary.Open Notifications
    ${noti_title_locator}    String.Replace string    ${mobile_common.txt_noti_title}    {{noti_title}}    ${noti_title}
    ${noti_body_big_locator}    String.Replace string    ${mobile_common.txt_noti_body_big}    {{noti_body}}    ${noti_body}
    ${noti_body_locator}    String.Replace string    ${mobile_common.txt_noti_body}    {{noti_body}}    ${noti_body}
    FOR     ${i}    IN RANGE    0   5
        ${title_found}=      Run keyword and return status       AppiumLibrary.Wait Until Element Is Visible   ${noti_title_locator}    timeout=30s
        ${body1_found}=      Run keyword and return status       AppiumLibrary.Wait Until Element Is Visible   ${noti_body_locator}    timeout=30s
        ${body2_found}=      Run keyword and return status       AppiumLibrary.Wait Until Element Is Visible   ${noti_body_locator}    timeout=30s
        ${body_found}=      Evaluate    ${body1_found} or ${body2_found}
        ${result}=          Evaluate    ${title_found} and ${body_found}
        Exit for loop if        ${result}
    END
    Should be true  ${result}   msg='notification not found after 10 mins wait'
    Go back

Should not receive push notification
    AppiumLibrary.Open Notifications
    FOR     ${i}    IN RANGE    0   5
        ${title_found}=      Run keyword and return status       AppiumLibrary.Page should not contain element    ${mobile_common.txt_title}
        ${body1_found}=      Run keyword and return status       AppiumLibrary.Page should not contain element    ${mobile_common.txt_big_text}
        ${body2_found}=      Run keyword and return status       AppiumLibrary.Page should not contain element    ${mobile_common.txt_text}
    END
    Go back

Tap notification by title
    [Arguments]    ${noti_title}
    Open Notifications
    ${noti_title_locator}    String.Replace string    ${mobile_common.txt_noti_title}    {{noti_title}}    ${noti_title}
    DobbyAppCommon.Tap element when ready   ${noti_title_locator}

Press enter on numpad keyboard
    AppiumLibrary.press keycode      160

Press enter on keyboard
    IF   "${platform}" == "${platform_list['android']}"
        AppiumLibrary.press keycode      66
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        # sometime open device thai lang but keyboard show en lang
        ${is_success_en}=   Run keyword and return status   mobile_common.Press keyname        search
        ${is_success_th}=   Run keyword and return status   mobile_common.Press keyname        ค้นหา
        ${result}=          Evaluate    ${is_success_en} or ${is_success_th}
        Should be true      ${result}     
    END

Tap accept an Not sync if chrome welcome page and turn on sync page is exist
    ${welcome_page_show}=     Run keyword and return status   AppiumLibrary.Wait Until Element Is Visible       ${mobile_common.welcome_to_chrome}    timeout=${short_timeout}
    Run keyword if      '${welcome_page_show}'=='${true}'       DobbyAppCommon.Tap element when ready     ${mobile_common.terms_accept}
    ${sync_page_show}=     Run keyword and return status   AppiumLibrary.Wait Until Element Is Visible       ${mobile_common.txt_turn_on_sync}       timeout=${short_timeout}
    Run keyword if      '${sync_page_show}'=='${true}'       DobbyAppCommon.Tap element when ready     ${mobile_common.negative_button}

Select once for lead to chrome app if popup select app exist
    ${select_app_popup_show}=     Run keyword and return status   AppiumLibrary.Wait Until Element Is Visible     ${mobile_common.button_once}    timeout=${short_timeout}
    ${result_1}=     Run keyword and return status   AppiumLibrary.Wait Until Element Is Visible     ${mobile_common.profile_pager_chrome}    timeout=${short_timeout}
    ${result_2}=     Run keyword and return status   AppiumLibrary.Wait Until Element Is Visible     ${mobile_common.open_with_chrome}    timeout=${short_timeout}
    IF  ${result_1}
        DobbyAppCommon.Tap element when ready     ${mobile_common.profile_pager_chrome}
        DobbyAppCommon.Tap element when ready      ${mobile_common.button_once}
    END
    IF  ${result_2}
        DobbyAppCommon.Tap element when ready      ${mobile_common.button_once}
    END   

Close translation bar in chrome if exist
    ${result_1}=     Run keyword and return status   AppiumLibrary.Wait Until Element Is Visible     ${mobile_common.translate_infobar}
    IF  ${result_1}
        DobbyAppCommon.Tap element when ready      ${mobile_common.btn_infobar_close}
    END
    
Get order element size  
    [Arguments]    ${locator}
    ${element_size}=    AppiumLibrary.Get Element Size    ${locator}
    [Return]    ${element_size}

# iOS

Open Safari browser with url
    [Arguments]      ${link}  ${auto_accept}=${True}
    Run keyword if  ${doppio_farm}==True    mobile_common.Init mobile farm configuration
    ${capability}       Create dictionary        automationName=XCUITest                 
    ...                 platformName=ios
    ...                 platformVersion=${platformVersion}
    ...                 deviceName=${deviceName}
    ...                 newCommandTimeout=${0}
    ...                 autoAcceptAlerts=${auto_accept}
    ...                 wdaLocalPort=${systemPort}
    ...                 noReset=${FALSE}
    ...                 autoGrantPermissions=${TRUE}
    ...                 launchTimeout=${48000}
    ...                 reduceMotion=${TRUE}
    ...                 boundElementsByIndex=${TRUE}
    ...                 nativeWebScreenshot=true
    ...                 browserName=Safari

    Open Application    remote_url=${remoteUrl}
    ...                 automationName=XCUITest
    ...                 &{capability}
    Go to url           ${link}

Long press when ready
    [Arguments]     ${locator}
    DobbyAppCommon.Wait until element is visible except stale     ${locator}
    Long press         ${locator}       duration=1000

Press keyname
    [Arguments]     ${key_name}
    Hide Keyboard   key_name=${key_name}

Swipe right to left
    [Arguments]    ${locator}
    ${element_size}         AppiumLibrary.Get Element Size    ${locator}
    ${element_location}     AppiumLibrary.Get element Location    ${locator}
    ${start_x}         Evaluate      ${element_location['x']} + (${element_size['width']} * 0.1)
    ${start_y}         Evaluate      ${element_location['y']} + (${element_size['height']} * 0.1)
    ${end_x}           Evaluate      ${element_location['x']} + (${element_size['width']} * 1)
    ${end_y}           Evaluate      ${element_location['y']} + (${element_size['height']} * 0.1)
    Swipe               ${start_x}    ${start_y}  ${end_x}  ${end_y}  1000

Swipe left to right
    [Arguments]    ${locator}
    ${element_size}        AppiumLibrary.Get element size    ${locator}
    ${element_location}    AppiumLibrary.Get element location    ${locator}
    ${center_x}        Evaluate      (${element_location['x']} + ${element_size['width']}) * 0.5
    ${center_y}        Evaluate      ${element_location['y']} + (${element_size['height']} * 0.5)
    ${start_x}         Evaluate      ${element_size['width']} * 0.75
    ${end_x}           Evaluate      ${element_size['width']} * 0.25
    Swipe               ${start_x}    ${center_y}  ${end_x}  ${center_y}  1000   
    
Swipe top to bottom
    [Documentation]     Equals to "swipe up"
    [Arguments]    ${locator}
    ${element_size}        AppiumLibrary.Get element size    ${locator}
    ${element_location}    AppiumLibrary.Get element location    ${locator}
    ${center_x}         Evaluate      (${element_location['x']} + ${element_size['width']}) * 0.5
    ${center_y}         Evaluate      ${element_location['y']} + (${element_size['height']} * 0.5)
    ${start_y}         Evaluate      ${element_size['height']} * 0.25
    ${end_y}           Evaluate      ${element_size['height']} * 0.75
    Swipe               ${center_x}    ${start_y}  ${center_x}  ${end_y}  1000     

Swipe bottom to top
    [Documentation]     Equals to "swipe down"
    [Arguments]    ${locator}
    ${element_size}        AppiumLibrary.Get element size    ${locator}
    ${element_location}    AppiumLibrary.Get element location    ${locator}
    ${center_x}         Evaluate      (${element_location['x']} + ${element_size['width']}) * 0.5
    ${center_y}         Evaluate      ${element_location['y']} + (${element_size['height']} * 0.5)
    ${start_y}          Evaluate      ${element_size['height']} * 0.75
    ${end_y}            Evaluate      ${element_size['height']} * 0.25
    Swipe               ${center_x}    ${start_y}  ${center_x}  ${end_y}  1000    

Input value to pickerwheel when ready
    [Arguments]     ${value}
    ${pickerwheel_value_locator}    String.Replace string    ${mobile_common.pickerwheel_value}    {{value}}    ${value}
    AppiumLibrary.Wait Until Element Is Visible           ${mobile_common.pickerwheel}
    Input value                             ${mobile_common.pickerwheel}    ${value}
    DobbyAppCommon.Tap element when ready                   ${pickerwheel_value_locator}
    DobbyAppCommon.Tap element when ready                   ${mobile_common.btn_done}

Input value to pickerwheel in kyc page when ready
    [Arguments]     ${value}
    ${pickerwheel_value_locator}    String.Replace string    ${mobile_common.pickerwheel_value}    {{value}}    ${value}
    AppiumLibrary.Wait Until Element Is Visible           ${mobile_common.pickerwheel}
    Input value                             ${mobile_common.pickerwheel}    ${value}
    DobbyAppCommon.Tap element when ready                   ${pickerwheel_value_locator}
    DobbyAppCommon.Tap element when ready                   ${mobile_common.btn_done_button}

Get current date with zero padding
    ${date} =    Get Current Date    result_format=%d
    [Return]   ${date}

Get current month without zero padding
    ${month} =    Get Current Date    result_format=%m
    ${month_no_padding}=    Replace String Using Regexp    ${month}    ^0    ${EMPTY}
    [Return]        ${month_no_padding}

Change language EN
    DobbyAppCommon.Long press when ready        ${mobile_common.btn_th_basket}
    DobbyAppCommon.Tap element when ready       ${mobile_common.switch_en}
    Element value should be                     ${mobile_common.switch_en}       1
    DobbyAppCommon.Tap element when ready       ${mobile_common.typeother}

Change language TH
    DobbyAppCommon.Long press when ready        ${mobile_common.btn_en_basket}
    DobbyAppCommon.Tap element when ready       ${mobile_common.switch_en}
    Element value should be                     ${mobile_common.switch_en}       0
    DobbyAppCommon.Tap element when ready       ${mobile_common.typeother}

Tap done on keyboard
    DobbyAppCommon.Tap element when ready       ${mobile_common.btn_label_done}

Swipe and tab element by locator
    [Arguments]    ${locator}
    ${element_size}=    AppiumLibrary.Get Element Size    ${locator}
    ${element_location}=    Get Element Location    ${locator}
    ${start_x}=         Evaluate      ${element_location['x']} + (${element_size['width']} * 0.5)
    ${start_y}=         Evaluate      ${element_location['y']} + (${element_size['height']} * 0.3)
    ${end_x}=           Evaluate      ${element_location['x']} + (${element_size['width']} * 0.5)
    ${end_y}=           Evaluate      ${element_location['y']} + (${element_size['height']} * 0.9)
    Swipe               ${start_x}    ${start_y}  ${end_x}  ${end_y}  1000
    Sleep  2s
    DobbyAppCommon.Tap element when ready   ${locator}

Page should not contain loading spinner
    AppiumLibrary.Wait until page does not contain element      ${mobile_common.loader}
    
Verify message in textview
    [Arguments]         ${label}
    ${locator}         String.Replace string       ${mobile_common.txt_desc}      {{string}}    ${label}       
    mobile_common.Find element              ${locator}

Get new qty after click increase button
    [Arguments]            ${add_amount}    ${original_qty}=1
    ${original_qty}         Convert to integer      ${original_qty}
    ${add_amount}           Convert to integer      ${add_amount}
    ${qty_after_added}      Evaluate                ${original_qty}+${add_amount}
    ${qty_added_str}        Convert to string       ${qty_after_added}
    [Return]        ${qty_added_str}

Get new qty after click increase as array list
    [Arguments]     ${qty_list}     ${original_qty}=1
    ${all_new_qty}      Create list
    FOR   ${qty_i}      IN    @{qty_list}
        ${qty_after_added}      mobile_common.Calculate total price  ${qty_i}    ${original_qty}
        Collections.Append to list      ${all_new_qty}       ${qty_after_added}
    END
    [Return]        ${all_new_qty}

Get new qty after click decrease button
    [Arguments]     ${target_qty}       ${del_amount}
    ${target_qty}           Convert to integer  ${target_qty}
    ${del_amount}           Convert to integer  ${del_amount}
    ${qty_after_del}        Evaluate            ${target_qty}-${del_amount}
    ${qty_del_str}          Convert to string   ${qty_after_del}
    [Return]        ${qty_del_str}

Get separate sentente that has new line from language file
    [Arguments]     ${target_data}
    ${data}      Evaluate      list(filter(None, '''${target_data}'''.splitlines()))
    ${first_sentence}       Set variable    ${data}[0]
    ${second_sentence}      Set variable    ${data}[1]
    [Return]     ${first_sentence}      ${second_sentence}

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
    [Return]    ${product_name}

Get total price by qty
    [Arguments]     ${product_price}    ${qty}
    ${total_price}          Evaluate               ${product_price}*${qty}
    [Return]        ${total_price}

Calculate all total price with qty
    [Arguments]     ${all_product_price_list}    ${qty_list}
    @{total_price_list}      Create list
    ${len_add_list}     Evaluate    len(${all_product_price_list})
    FOR    ${index}     IN RANGE        ${len_add_list}
        ${price_with_qty}       mobile_common.Get total price by qty    ${qty_list}[${index}]    ${all_product_price_list}[${index}]
        Collections.Append to list      ${total_price_list}       ${price_with_qty}
    END
    ${total_all_price}    Set variable  0
    FOR   ${price_i}      IN    @{total_price_list}
        ${total_all_price}      mobile_common.Calculate total price  ${total_all_price}    ${price_i}
    END
    [Return]               ${total_all_price}

Calculate total price
    [Arguments]     ${first_price}   ${second_price}
    ${total_price}          Evaluate         ${first_price}+${second_price}
    [Return]        ${total_price}

Open deeplink
    [Arguments]    ${link}
    AppiumLibrary.Go to url    ${link}

Click open deeplink
    ${check_popup}      Run keyword and return status        DobbyAppCommon.Wait until element is visible except stale     ${mobile_common.btn_open}           ${global_timeout}
    IF    ${check_popup}
        ${tap_status}    Run keyword and return status    DobbyAppCommon.Tap Element When Ready        ${mobile_common.btn_open}   
    END            
    AppiumLibrary.Wait until page does not contain element    ${mobile_common.btn_open}
    
Change mobile number to mobile with country code pattern
    [Documentation]    Input: 06xxxxxxxx output: +66xxxxxxxxx
    [Arguments]    ${mobile_number}
    ${global_number}    String.Replace string    ${mobile_number}     ${mobile_data['thai_start_mobile_number']}    ${mobile_data['thai_country_code']}      count=1
    [Return]    ${global_number}

Extend data equal to array size
    [Arguments]     ${data}     ${size}
    [Documentation]    ${data}: 0, ${size}:3 , output: ['0', '0', '0']
    @{new_data}         Create list
    FOR   ${index}      IN RANGE     ${size}
        Collections.Append to list   ${new_data}    ${data}
    END
    [Return]        ${new_data}

Get target qty to add from expected qty
    [Arguments]     ${expected_qty}       ${current_qty}
    [Documentation]     current amount need to be less than expected qty
    ${expected_qty}         Convert to integer  ${expected_qty}
    ${current_qty}       Convert to integer     ${current_qty}
    ${qty_to_add}           Evaluate            ${expected_qty}-${current_qty}
    ${qty_to_add}           Convert to string   ${qty_to_add}
    [Return]        ${qty_to_add}

Get target qty to decrease from expected qty
    [Arguments]     ${expected_qty}       ${current_qty}
    [Documentation]     current amount need to be more than expected qty
    ${expected_qty}         Convert to integer  ${expected_qty}
    ${current_qty}       Convert to integer     ${current_qty}
    ${qty_to_minus}         Evaluate            ${current_qty}-${expected_qty}
    ${qty_to_minus}         Convert to string   ${qty_to_minus}
    [Return]        ${qty_to_minus}

Swipe to the top of page
    [Arguments]     ${time}=1
    FOR    ${index}    IN RANGE     ${time}
        DobbyAppCommon.Swipe down
    END

Change dictionary format to be array format
    [Documentation]     Input ${target_dict_detail} format: {'product_1': {'title': 'ไอวี่', 'price': '350', 'qty': 1}}
    ...     output format:  [1]  while 'product' from 'product_1' is ${target_parent_key} and qty is ${target_sub_key}
    [Arguments]     ${target_dict_detail}       ${target_parent_key}      ${target_sub_key}
    ${output_list}      Create list
    ${total_item}       Get length     ${target_dict_detail}
    FOR    ${index}     IN RANGE     1        ${total_item}+1
        ${parent_key}    Catenate    SEPARATOR=   ${target_parent_key}_    ${index}
        Collections.Append to list    ${output_list}       ${target_dict_detail["${parent_key}"]['${target_sub_key}']}
    END
    [Return]        ${output_list}

Update all dictionary items by dictionary key
    [Documentation]     Input ${target_dict_detail} format: {'product_1': {'title': 'ไอวี่', 'price': '350', 'qty': 1}}, 
    ...     and ${target_change_list}: [2], output format: {'product_1': {'title': 'ไอวี่', 'price': '350', 'qty': 2}} 
    ...     and while 'product' from 'product_1' is ${target_parent_key} and qty is ${target_sub_key}
    [Arguments]     ${target_dict_detail}     ${target_parent_key}    ${target_sub_key}   ${target_change_list}
    ${total_item}      Get length         ${target_change_list}
    FOR    ${index}      IN RANGE    1    ${total_item}+1
        ${parent_key}       Catenate      SEPARATOR=   ${target_parent_key}_    ${index}
        ${target_index}     Evaluate      ${index}-1
        Collections.Set to dictionary   ${target_dict_detail['${parent_key}']}   ${target_sub_key}    ${target_change_list}[${target_index}]
    END
    [Return]        ${target_dict_detail}

Swipe to find element
    [Arguments]    ${locater}     ${round_amount}=${5}   ${moveto}=${scroll_direction['bottom']}
    [Documentation]  This keyword can be used to scroll on product list page or any page that have problem to scroll find element on browserstack
    FOR     ${i}    IN RANGE    1   ${round_amount}
        ${locater_shown}   Run keyword and return status   DobbyAppCommon.Wait until element is visible except stale       ${locater}    timeout=${short_timeout}
        IF    ${locater_shown} == ${True}    BREAK
        IF     "${moveto}" == "Top"
            mobile_common.Swipe top to bottom   ${mobile_common.default_scroll_view}
            ${locater_shown}   Run keyword and return status   DobbyAppCommon.Wait until element is visible except stale    ${locater}    timeout=${short_timeout}
        ELSE
            mobile_common.Swipe bottom to top   ${mobile_common.default_scroll_view}
            ${locater_shown}   Run keyword and return status   DobbyAppCommon.Wait until element is visible except stale    ${locater}    timeout=${short_timeout}
        END
        IF    ${locater_shown} == ${True}    BREAK
    END

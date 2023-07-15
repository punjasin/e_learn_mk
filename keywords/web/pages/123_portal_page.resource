*** Settings ***
Resource            ../../../resources/locators/web/123_portal_locator.resource
Resource            ../../../common/web/web_common.resource

*** Keywords ***
Enter payment code
    [Arguments]     ${payment_ref}
    DobbyWebCommon.Wait until element is visible except stale       ${123.input_payment_code}
    DobbyWebCommon.Input text to element when ready		${123.input_payment_code}		${payment_ref}

Select agent code
    [Arguments]     ${agent_code}
    DobbyWebCommon.Wait until element is visible except stale       ${123.input_agent_code}
    SeleniumLibrary.Select From List By Value           ${123.input_agent_code}     ${agent_code}

Select channel code
    [Arguments]     ${channel_code}
    DobbyWebCommon.Wait until element is visible except stale       ${123.input_channel_code}
    SeleniumLibrary.Select From List By Value           ${123.input_channel_code}     ${channel_code}

Enter paid amount
    [Arguments]     ${amount}
    DobbyWebCommon.Input text to element when ready           ${123.input_paid_amount}     ${amount}

Click submit button
    DobbyWebCommon.Wait until element is visible except stale       ${123.btn_submit}
    DobbyWebCommon.Click element when ready       ${123.btn_submit}

Select payment status
    [Arguments]     ${status}
    SeleniumLibrary.Wait until element is visible       ${123.select_payment_status}
    SeleniumLibrary.Select From List By Label           ${123.select_payment_status}     ${status.upper()}
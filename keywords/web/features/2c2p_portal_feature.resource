*** Settings ***
Resource            ../pages/2c2p_portal_page.resource

*** Keywords ***
Verify card information and submit
    2c2p_portal_page.Verify 2c2p image header
    2c2p_portal_page.Click confirm button

Input otp and submit
    [Arguments]    ${otp}
    2c2p_portal_page.Verify otp header
    2c2p_portal_page.Input otp textbox    ${otp}
    2c2p_portal_page.Click submit button
    2c2p_portal_page.Click back to merchant button
    web_common.Wait for page load
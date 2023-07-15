*** Settings ***
Resource            ../pages/123_portal_page.resource

*** Keywords ***
Open 123 portal and mark as paid
    [Arguments]     ${payment_ref}      ${agent_code}       ${channel_code}     ${amount}
    web_common.Open website                 ${123_portal_url}
    123_portal_page.Enter payment code      ${payment_ref}
    123_portal_page.Select agent code       ${agent_code}
    Sleep   1s      # To counter stale exception
    123_portal_page.Select channel code     ${channel_code}
    123_portal_page.Enter paid amount       ${amount}
    123_portal_page.Click submit button


# Open 123 portal and mark as expired     #not ready to implement due to makroclick migration
#     [Arguments]     ${payment_ref}      ${agent_code}       ${channel_code}     ${amount}
#     web_common.Open website      ${123_portal_url}
#     Enter payment code      ${payment_ref}
#     Select agent code       ${agent_code}
#     Sleep   1s      # To counter stale exception
#     Select channel code     ${channel_code}
#     Enter paid amount       ${amount}
#     Select payment status   EXPIRED
#     123_portal_page.Click submit button
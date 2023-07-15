*** Settings ***
Resource        ../pages/cookie_page.resource

*** Keywords ***
Accept all for sdk cookie popup if exist
    ${status}=  Run keyword and return status    cookie_page.Verify cookie SDK popup appear
    IF  ${status}
        cookie_page.Click accept all button on cookie SDK popup
    END

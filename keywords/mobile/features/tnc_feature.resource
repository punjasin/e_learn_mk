*** Settings ***
Resource        ../pages/tnc_page.resource

*** Keywords ***
Accept terms and conditions popup if exist
    ${status}       Run keyword and return status       tnc_page.Verify terms and conditions popup display
    IF      ${status} == ${TRUE}       
        tnc_page.Click accept terms and conditions popup
        mobile_common.Wait until toast message disappeared
    END

Update terms and conditions popup if exist
    ${status}       Run keyword and return status       tnc_page.Verify update terms and conditions popup display
    IF  ${status} == ${TRUE}
        tnc_page.Tap accept terms and conditions checkbox
        tnc_page.Tap confirm update terms and conditioins
        mobile_common.Wait until toast message disappeared
    END
*** Settings ***
Resource            ../pages/pickpack_page.resource

*** Keywords ***
Open pickpack and login
    web_common.Open website                        ${pickpack_url}
    SeleniumLibrary.Wait until element is visible  ${pickpack.input_email}
    pickpack_page.Input email
    pickpack_page.input password
    pickpack_page.Click login

Complete pick pack shipped
    [Arguments]     ${OrderNumber}      ${zone}
    pickpack_page.Search by order number                                        ${OrderNumber}
    pickpack_page.Click search button
    pickpack_page.Click pick order                                              ${OrderNumber}
    pickpack_page.Click pick all
    pickpack_page.Confirmation pick all
    pickpack_page.Click next button
    pickpack_page.Assign zone                                                   ${zone}
    pickpack_page.Verify order status                                           ${pickpack['pickpack status']['status_ready']}
    pickpack_page.Pick order continue
    pickpack_page.Click pack all into current package
    pickpack_page.Confirmation pack all item
    pickpack_page.Finish pack button
    pickpack_page.Confirmation pick all
    pickpack_page.Verify order status                                           ${pickpack['pickpack status']['status_packed']}
    pickpack_page.Click ship order
    pickpack_page.Select ship packages
    pickpack_page.Verify order status                                           ${pickpack['pickpack status']['status_shipped']}

Complete pick pack delivered
    [Arguments]     ${OrderNumber}      ${zone}
    pickpack_page.Search by order number                                        ${OrderNumber}
    pickpack_page.Click search button
    pickpack_page.Click pick order                                              ${OrderNumber}
    pickpack_page.Click pick all
    pickpack_page.Confirmation pick all
    pickpack_page.Click next button
    pickpack_page.Assign zone                                                   ${zone}
    pickpack_page.Verify order status                                           ${pickpack['pickpack status']['status_ready']}
    pickpack_page.Pick order continue
    pickpack_page.Click pack all into current package
    pickpack_page.Confirmation pack all item
    pickpack_page.Finish pack button
    pickpack_page.Confirmation pick all
    pickpack_page.Verify order status                                           ${pickpack['pickpack status']['status_packed']}
    pickpack_page.Click ship order
    pickpack_page.Select ship packages
    pickpack_page.Verify order status                                           ${pickpack['pickpack status']['status_shipped']}
    pickpack_page.Click mark as delivered
    pickpack_page.click confirm mark as delivered
    pickpack_page.Verify order status                                           ${pickpack['pickpack status']['status_delivered']}
*** Settings ***
Resource            ../pages/home_makroproweb_page.resource
Resource            ../pages/login_makroproweb_page.resource

*** Keywords ***
Navigate to forgot password page
    home_makroproweb_page.Click on user account icon
    login_makroproweb_page.Click email tab
    login_makroproweb_page.Click forgot password

Login with email and password
    [Arguments]    ${email}    ${password}
    home_makroproweb_page.Click on user account icon
    login_makroproweb_page.Click email tab
    login_makroproweb_page.Input email       ${email} 
    login_makroproweb_page.Input password    ${password}
    login_makroproweb_page.Click login button
    web_common.Wait for page load
    web_common.Wait until toast message dissapear
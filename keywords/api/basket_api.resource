*** Settings ***
Resource        ../../common/api/api_common.resource
Resource        login_api.resource

*** Keywords ***
Update basket for login user via API
    [Arguments]     ${IDToken}   ${basketItems}     ${storecode}=${store_code['st4']}      ${jsonfile}=basket/queryUpdateBasket.json
    ${basketItems}=     Convert String To Json  ${basketItems}
    api_common.Update json variable   ${json_file}       $.variables.accessToken        ${IDToken}
    api_common.Update json variable   ${json_file}       $.variables.basketItems        ${basketItems}
    api_common.Update json variable   ${json_file}       $.variables.storeCode          ${storecode}
    ${response}=    api_common.Call qraphql maknet app       jsonfile=${jsonfile}    IDToken=${IDToken}

Create basket product list for API
    [Documentation]     Will be used with 'basket_api.Update basket for login user via API'
    [Arguments]    ${basket_dict}
    ${basket_list}  Create list
    FOR    ${productID}    ${qty}    IN    &{basket_dict}
    Append To List  ${basket_list}    {"productId": "${productID}", "quantity": ${qty}}
    END
    ${basket_list}  Convert To String   ${basket_list}
    ${basket_list}  Remove String   ${basket_list}  '
    [Return]        ${basket_list}

Login and update basket via API
    [Arguments]    ${email}     ${pwd}      ${basket_dict}
    ${basket_list}=    Create basket product list for API   ${basket_dict}
    ${IDToken}  ${Accesstoken} =     login_api.Call qraphql to login user via email  ${email}    ${pwd}
    basket_api.Update basket for login user via API    ${IDToken}   ${basket_list} 

Delete basket for login user via API
    [Arguments]     ${IDToken}      ${jsonfile}=basket/queryDeleteBasket.json
    api_common.Update json variable   ${json_file}       $.variables.accessToken        ${IDToken}
    ${response}=    api_common.Call qraphql maknet app       jsonfile=${jsonfile}    IDToken=${IDToken}

Login and delete basket via API
    [Arguments]    ${email}     ${pwd}
    ${IDToken}  ${Accesstoken} =     login_api.Call qraphql to login user via email  ${email}    ${pwd}
    basket_api.Delete basket for login user via API    ${IDToken}
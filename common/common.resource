*** Settings ***
Library          String
Library          OperatingSystem
Library          Collections
Library          DateTime 
Library          Process

Variables       ../resources/data/common.yaml

*** Keywords ***

Archive previous screenshots
    [Arguments]    ${suiteDirectory}=${EXECDIR}
    ${ScreenshotDirectory}=     Set Variable    ${suiteDirectory}${/}Screenshots${/}
    ${ArchiveDirectory}=     Set Variable     ${suiteDirectory}${/}Screenshots${/}Archive${/}
    Move Files      ${ScreenshotDirectory}${/}*.png      ${ArchiveDirectory}
     
Screenshot cleanup
    [Arguments]    ${suiteDirectory}=${EXECDIR}
    ${parentDirectory}=    Split String    ${CURDIR}    Common
    ${parentDirectory}=    Get From List    ${parentDirectory}    0

    ${ScreenshotDirectory}=     Set Variable    ${suiteDirectory}${/}Screenshots${/}
    Remove Files    ${parentDirectory}*-screenshot-*.png
    Remove Files    ${parentDirectory}${/}results${/}*-screenshot-*.png
    Remove Files    ${suiteDirectory}${/}*-screenshot-*.png
    Remove Files    ${ScreenshotDirectory}${/}*-screenshot-*.png
    Wait Until Removed  ${suiteDirectory}${/}selenium-screenshot-1.png
    Wait Until Removed  ${suiteDirectory}${/}appium-screenshot-1.png
    Move Files      ${suiteDirectory}${/}*.png      ${ScreenshotDirectory}

Get operating system
    ${isUnix}=    Run Keyword And Return Status    Should Be Equal As Strings    ${/}    /
    IF    ${isUnix}
        ${os}=    Set Variable    Unix
    ELSE
        ${os}=    Set Variable    Windows
    END
    [Return]    ${os}

Run python process in background
    [Arguments]    ${scriptPath}    ${arg1}=    ${arg2}=
    ${os}=    Get Operating System
    IF    '${os}' == 'Unix'
        ${pythonCommand}=    Set Variable    python3
    ELSE
        ${pythonCommand}=    Set Variable    python
    END
    ${metadata}=    Split String From Right    ${scriptPath}    ${/}    1
    
    ${process}=    Start Process    ${pythonCommand}    ${scriptPath}    ${arg1}    stdout=${CURDIR}${/}stdout_${metadata}[1].txt    stderr=${CURDIR}${/}stderr_${metadata}[1].txt
        
Set product name from api data
    [Arguments]   ${product_info}
    [Documentation]     When open device lang en, product name is en but sometime found empty string in product en from api result
    ...     so,it need to check if it is empty string or not
     IF  "${lang}"=="en"
        ${product_name}       Set variable        ${product_info['product_name_en']}
        IF   "${product_name}"=="${empty}"
            ${product_name}     Set variable      ${product_info['product_name_th']}
        END
    ELSE
        ${product_name}       Set variable        ${product_info['product_name_th']}
        IF   "${product_name}"=="${empty}"
            ${product_name}     Set variable      ${product_info['product_name_en']}
        END
    END
    Collections.Set to dictionary   ${product_info}      productname=${product_name}
    [Return]    ${product_info}

Get required qty to reach minimum price
    [Arguments]    ${product_price}    ${current_qty}=1    ${min_price_order}=${default['minimum_order']}
    [Documentation]    check total price or product price with minimum price 999 thb to get total qty that need to add more
    ...  ex: if you click add, your current qty=1 and display price is 499 -> 999/499=2 -> the total qty to plus more is 1
    ${qty}    Evaluate    round(${min_price_order}/${product_price})
    IF    ${current_qty}<${qty}
        ${qty}    Evaluate   ${qty}-${current_qty}
    END
    [Return]    ${qty}
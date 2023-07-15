*** Settings ***
Resource        ../../common/api/api_common.resource
Resource        gmail_api.resource

*** Keywords ***
Order cancelled email should contain correct CS number
    [Arguments]     ${email}    ${password}     ${sender_address}   ${cs_number}
    ${body}     ${link}=    DobbyCommon.Get body and link from email    ${email}    ${password}     ${sender_address}
    Should contain  ${body}   ${cs_number}

Verify order is placed from email
    [Arguments]     ${email}    ${password}    ${sender_address}    ${order_no}    ${order_summary}    ${delivery_address}    ${billing_address}
    ...             ${delivery_method}    ${payment_method}    ${contact_no}
    ${text}=    gmail_api.Get only email body    ${email}    ${password}     ${sender_address}
    Should contain    ${text}    ${order_no}
    Should contain    ${text}    ${order_summary}
    Should contain    ${text}    ${delivery_address}
    Should contain    ${text}    ${billing_address}
    Should contain    ${text}    ${delivery_method}
    Should contain    ${text}    ${payment_method}
    Should contain    ${text}    ${contact_no}
    
Verify order is cancelled from email
    [Arguments]     ${email}    ${password}    ${sender_address}    ${order_cancelled}    ${order_summary}    ${order_refund}    ${order_refund_success}
    ...             ${summary_sub_total}    ${delivery_method}    ${tax}    ${total}    ${refund_method}    ${contact_no}
    ${text}=    gmail_api.Get only email body    ${email}    ${password}     ${sender_address}
    should contain    ${text}    ${order_cancelled}
    should contain    ${text}    ${order_summary}
    should contain    ${text}    ${order_refund}
    should contain    ${text}    ${order_refund_success}
    should contain    ${text}    ${summary_sub_total}
    should contain    ${text}    ${delivery_method}
    should contain    ${text}    ${tax}
    should contain    ${text}    ${total}
    should contain    ${text}    ${refund_method}
    should contain    ${text}    ${contact_no}

Verify order is shipped from email
    [Arguments]     ${email}
    ...    ${password}
    ...    ${sender_address}
    ...    ${order_shipped}
    ...    ${lbl_info1}
    ...    ${lbl_info2}
    ...    ${lbl_info3}
   
    ${text}=            gmail_api.Get only email body    ${email}    ${password}     ${sender_address}
    ${to_string}=       Convert to string           ${text}
    ${string}=          RobotUtils.decode_base64    ${to_string.rstrip()}
    Should contain    ${string}    ${order_shipped}
    Should contain    ${string}    ${lbl_info1}
    Should contain    ${string}    ${lbl_info2}
    Should contain    ${string}    ${lbl_info3}

Verify order attempt delivery from email
    [Arguments]     ${email}
    ...    ${password}
    ...    ${sender_address}
    ...    ${lbl_failed}
    ...    ${lbl_attempt}
    ...    ${lbl_info1}
    ...    ${lbl_info2}
    
    
    ${text}=            gmail_api.Get only email body    ${email}    ${password}     ${sender_address}
    ${to_string}=       Convert to string           ${text}
    ${string}=          RobotUtils.decode_base64    ${to_string.rstrip()}
    Should contain    ${string}    ${lbl_failed}
    Should contain    ${string}    ${lbl_attempt}
    Should contain    ${string}    ${lbl_info1}
    Should contain    ${string}    ${lbl_info2}
    

Verify order delivered from email
    [Arguments]     ${email}
    ...    ${password}
    ...    ${sender_address}
    ...    ${delivered}
    ...    ${lbl_info1}
    ...    ${lbl_info2}
    
    ${text}=            gmail_api.Get only email body    ${email}    ${password}     ${sender_address}
    ${to_string}=       Convert to string           ${text}
    ${string}=          RobotUtils.decode_base64    ${to_string.rstrip()}
    Should contain    ${string}    ${delivered}
    Should contain    ${string}    ${lbl_info1}
    Should contain    ${string}    ${lbl_info2}
    
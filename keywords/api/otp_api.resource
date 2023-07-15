*** Settings ***
Resource        email_api.resource
Resource        gmail_api.resource
Resource        ../../common/api/api_common.resource

*** Keywords ***
Get otp from sms
    [Arguments]    ${url}    ${expected_status_code}=200
    RequestsLibrary.Create session              Post session           ${url}
    ${request}             JSONLibrary.Load json from file             ${CURDIR}/../../resources/data/json_template/otp/get_otp.json
    ${response}            RequestsLibrary.Post on session             Post session             ${url_request_otp}                json=${request}
    Should not be equal     ${response.status_code}     ${server_error_response}    msg="OTP Framework Service is down"
    RequestsLibrary.Status should be    ${expected_status_code}    ${response}
    ${sms_text}	           JSONLibrary.Get value from json             ${response.json()}      ${update_otp['sms_text']}
    ${otp_number}          String.Get regexp matches   ${sms_text}[0]      \\d{6}
    ${otp_number}          Set variable     @{otp_number}
    [Return]               ${otp_number}

Get otp from mail
    [Arguments]    ${email}    ${password}     ${sender_address}    ${mail_host}=${imap_outlook['host']}
    ${mailtext}    email_api.Get email body    ${email}    ${password}     ${sender_address}    ${mail_host}
    ${otp_number}          String.Get regexp matches   ${mailtext}      \\d{6}
    [Return]               ${otp_number}[3]

Get otp from gmail
    [Arguments]    ${email}    ${password}     ${sender_address}
    ${mailtext}    gmail_api.Get email body    ${email}    ${password}     ${sender_address}
    ${otp_number}          String.Get regexp matches   ${mailtext}      \\d{6}
    [Return]               ${otp_number}[4]

Verify OTP delivery within 1 minute
    [Arguments]    ${old_otp_number}
    [Documentation]    wait otp for login and register
    FOR  ${index}     IN RANGE     20
        ${otp_number}  otp_api.Get otp from sms  ${otp_url}
        IF    '${otp_number}'!='${old_otp_number}'    BREAK
        sleep    2s    #wait otp sent
    END
    [Return]    ${otp_number}
*** Settings ***
Resource        ../../common/api/api_common.resource

*** Keywords ***
Get body and link from email
    [Arguments]     ${email}    ${password}     ${sender_address}
    Wait until keyword succeeds    40x    10s
    ...            ImapLibrary2.Open mailbox      host=outlook.office365.com    port=993       user=${email}    password=${password}
    ${index}=      ImapLibrary2.Wait for email    sender=${sender_address}  status=RECENT    timeout=600
    ${parts}=      ImapLibrary2.Walk Multipart Email    ${index}
    FOR    ${i}    IN RANGE    ${parts}
        ImapLibrary2.Walk Multipart Email    ${index}
        ${content-type} =    ImapLibrary2.Get Multipart Content Type
        Continue For Loop If    '${content-type}' != 'text/html'
        ${payload} =    ImapLibrary2.Get Multipart Payload    decode=True
        ${link}=        ImapLibrary2.Get Links From Email    ${index}
    END
    ImapLibrary2.Delete All Emails
    ImapLibrary2.Close Mailbox
    ${links}=    RobotUtils.decode_url   ${link}
    [Return]    ${payload}  ${links}

Email body should not contain
    [Arguments]     ${email_body}   ${text_that_should_not_contain}
    Should not contain  ${email_body}   ${text_that_should_not_contain}

Get email body
    [Arguments]     ${email}    ${password}     ${sender_address}
    Wait until keyword succeeds    40x    10s
    ...                 ImapLibrary2.Open mailbox      host=imap.gmail.com       user=${email}    password=${password}
    ${index}=           ImapLibrary2.Wait for email    sender=${sender_address}     status=UNSEEN    timeout=180
    ${text}=            ImapLibrary2.Get Email Body    ${index}
    ${text_replace}=    Replace string      ${text}         \n      ${EMPTY}
    ImapLibrary2.Delete All Emails
    ImapLibrary2.Close Mailbox
    [Return]    ${text_replace}
*** Settings ***
Resource        ../../common/api/api_common.resource

*** Keywords ***
Get email body
    [Arguments]     ${email}    ${password}     ${sender_address}    ${mail_host}
    ImapLibrary2.Open mailbox      host=${mail_host}       user=${email}    password=${password}
    ${index}=           ImapLibrary2.Wait for email    sender=${sender_address}     status=UNSEEN    timeout=${default['email_timeout']}
    ${text}=            ImapLibrary2.Get email body    ${index}
    ${clean_text}       email_utils.extract file html   ${text}
    ImapLibrary2.Delete All Emails
    ImapLibrary2.Close Mailbox
    [Return]    ${clean_text}
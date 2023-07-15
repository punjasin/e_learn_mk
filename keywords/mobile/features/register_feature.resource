*** Settings ***
Resource        ../pages/register_page.resource
Resource        ../../api/otp_api.resource
Variables       ../../../resources/settings/aws.yaml
Variables       ../../../resources/settings/db.yaml

*** Keywords ***
Delete registered user
    [Arguments]    ${mobile_number}
    ${global_number}    mobile_common.Change mobile number to mobile with country code pattern    ${mobile_number}
    ${user}    DeleteRegisteredUsers.get_available_number   ${aws_cognito}    ${global_number}
    IF    ${user['Users']}
        DeleteRegisteredUsers.delete_user_aws_cognito    ${aws_cognito}    ${global_number}
        register_feature.Delete shopifyid by mobile number    ${global_number}
        DeleteRegisteredUsers.delete_user_DB    ${makropro_db['user_service']}    ${global_number}
    END

Delete shopifyid by mobile number
    [Arguments]    ${global_number}
    ${shopifyId}    DeleteRegisteredUsers.fetching_shopifyId_WithPhoneNumber    ${shopify_api}    ${global_number}
    ${shopifyId}    Convert to string    ${shopifyId}
    IF    ${shopifyId}!=None
        DeleteRegisteredUsers.delete_user_shopify    ${shopify_api}    ${shopifyId}
    END

Register new individual
    [Arguments]    ${first_name}    ${last_name}     ${mobile}
    ${old_otp_number}  otp_api.Get otp from sms  ${otp_url}
    register_page.Select individual type account
    register_page.Input first name    ${first_name}
    register_page.Input last name    ${last_name}
    register_page.Input mobile number    ${mobile}
    mobile_common.Hide keyboard down
    register_page.Tap accept terms and conditions
    register_page.Tap register button
    register_feature.Get and input otp    ${old_otp_number}

Register new business
    [Arguments]    ${first_name}    ${last_name}     ${mobile}    ${business_type_list}
    ${old_otp_number}  otp_api.Get otp from sms  ${otp_url}
    register_page.Select business type account
    register_page.Input first name    ${first_name}
    mobile_common.Hide keyboard down
    register_page.Verify user cannot create account when checkbox is uncheck
    register_page.Input last name    ${last_name}
    mobile_common.Hide keyboard down
    register_page.Verify user cannot create account when checkbox is uncheck
    register_page.Input mobile number    ${mobile}
    mobile_common.Hide keyboard down
    register_page.Verify user cannot create account when checkbox is uncheck
    mobile_common.Hide keyboard down
    register_page.Select business type    ${business_type_list}
    register_page.Tap accept terms and conditions
    register_page.Tap register button
    register_feature.Get and input otp    ${old_otp_number}
    
Get and input otp
    [Arguments]    ${old_otp_number}=000000
    Acquire Lock    otp_api.Get otp from sms
    ${otp_number}    otp_api.Verify OTP delivery within 1 minute    ${old_otp_number}
    register_page.Input otp    ${otp_number}
    register_page.Tap verify otp
    Release Lock    otp_api.Get otp from sms
    
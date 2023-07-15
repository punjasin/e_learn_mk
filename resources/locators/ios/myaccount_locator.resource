***Settings***
Variables       ../../localisation/mobile/${lang}.yaml
Variables       ../../localisation/mobile/${lang}_additional.yaml

*** Variables ***
${myaccount.txt_account}                   chain=**/XCUIElementTypeOther[`label == "${mobile['account']['title']}"`]
${myaccount.account_details}               xpath=//XCUIElementTypeOther[@name="${mobile['account']['label']['accountDetails']} {{firstname}} {{lastname}} {{email}} "]
${myaccount.txt_account_details}           xpath=//XCUIElementTypeStaticText[@name="${mobile['account']['label']['accountDetails']}"]
${myaccount.input_name_txt}                xpath=//XCUIElementTypeOther[@name="${mobile_additional['my_account']['name']}"]//XCUIElementTypeTextField[@name="input"]
${myaccount.input_surname_txt}             xpath=//XCUIElementTypeOther[@name="${mobile_additional['my_account']['surname']}"]//XCUIElementTypeTextField[@name="input"]
${myaccount.txt_name_surname}              xpath=//XCUIElementTypeStaticText[@name="{{firstname}}${SPACE}{{lastname}}"]
${myaccount.txt_email}                     accessibility_id={{email}}
${myaccount.txt_phone}                     xpath=//XCUIElementTypeStaticText[@name="{{phone}}"]
${myaccount.expected}                      chain=**/XCUIElementTypeStaticText[`label == "{{expected}}"`]
${myaccount.input_email}                   chain=**/XCUIElementTypeTextField[`name == "input" AND value == "{{email}}" AND enabled == 0`]
${myaccount.txt_save}                      xpath=(//XCUIElementTypeOther[@name="${mobile['global']['save']}" and @enabled="true"])[2]
${myaccount.txt_cancel}                    chain=**/XCUIElementTypeOther[`label == "${mobile['global']['cancel']}"`]
${myaccount.yes_and_confirm}               chain=**/XCUIElementTypeOther[`label == "${mobile['global']['yesAndConfirm']}"`]
${myaccount.txt_account_txt}               chain=**/XCUIElementTypeStaticText[`label == "${mobile['account']['title']}"`]
${myaccount.toast_success}                 chain=**/XCUIElementTypeOther[`label == "${mobile_additional['my_account']['toast_success']}"`]/XCUIElementTypeOther[`name == "toast_success"`]
${myaccount.success_2}                     chain=**/XCUIElementTypeOther[`label == "${mobile_additional['my_account']['success']}"`][2]
${myaccount.my_address}                    accessibility_id=${mobile['address']['title']['overviewTitle']}
${myaccount.input_name_surname}            chain=**/XCUIElementTypeOther[`label == "${mobile_additional['my_account']['name_surname']}"`]/**/XCUIElementTypeTextField[`name == "input_container"`]
${myaccount.input_container_email}         chain=**/XCUIElementTypeOther[`label == "${mobile['global']['email']}*"`]/**/XCUIElementTypeTextField[`name == "input_container"`]
${myaccount.description_fullname}          chain=**/XCUIElementTypeOther[`label CONTAINS "${mobile['account']['label']['accountDetails']} {{fullname}} {{email}}" AND name == "account_details"`]
${myaccount.input_name_surname_txt}        xpath=//XCUIElementTypeOther[@name="${mobile_additional['my_account']['name_surname']}"]/following-sibling::XCUIElementTypeStaticText[@name="${mobile_additional['my_account']['please_specify']}"]
${myaccount.please_specify_email}          xpath=//XCUIElementTypeOther[@name="${mobile['global']['email']}*"]/following-sibling::XCUIElementTypeStaticText[@name="${mobile_additional['my_account']['please_specify']}"]
${myaccount.please_specify_valid_email}    xpath=//XCUIElementTypeOther[@name="${mobile['global']['email']}*"]/following-sibling::XCUIElementTypeStaticText[@name="${mobile_additional['my_account']['specify_valid']}"]
${myaccount.disable_update}                chain=**/XCUIElementTypeOther[`label == "${mobile['global']['update']}" AND enabled == 0 AND accessible == 1`]
${myaccount.enable_update}                 chain=**/XCUIElementTypeOther[`label == "${mobile['global']['update']}" AND enabled == 1 AND accessible == 1`]
${myaccount.txt_address_name}              xpath=//XCUIElementTypeOther[contains(@name,"{{address_name}}") and @accessible="true"]
${myaccount.btn_default_address}           xpath=//XCUIElementTypeOther[contains(@name,"{{address_name}}")]/XCUIElementTypeOther[@label="${mobile['address']['button']['default']}"]//XCUIElementTypeOther[@label="${mobile['address']['button']['default']}" and @accessible="true"]
${myaccount.txt_default_address_name}      xpath=//XCUIElementTypeOther[contains(@name,"${mobile['address']['message']['defaultLabelAddress']}") and contains(@name,"{{address_name}}") and @accessible="true"]
${myaccount.txt_total_point}               xpath=//XCUIElementTypeOther[contains(@name,"${mobile['loyalty']['label']['my_profile_loyalty_label']}") and @accessible="true"]
${myaccount.txt_otp}                       xpath=//XCUIElementTypeStaticText[@name="${mobile['confirmOTP']['message']['titleSixDigit']}"]/following-sibling::XCUIElementTypeOther/XCUIElementTypeOther/XCUIElementTypeTextField
${myaccount.verify_email_btn}              xpath=//XCUIElementTypeOther[@name="${mobile['confirmOTP']['button']['verifyEmail']}"]
${myaccount.txt_default_address}           xpath=//XCUIElementTypeOther[contains(@name,"${mobile['address']['message']['defaultLabelAddress']}") and @accessible="true"]
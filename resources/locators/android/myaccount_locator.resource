***Settings***
Variables       ../../localisation/mobile/${lang}.yaml
Variables       ../../localisation/mobile/${lang}_additional.yaml

*** Variables ***
${myaccount.txt_account}                      xpath=//android.widget.TextView[@text='${mobile['account']['title']}']
${myaccount.txt_account_details}            xpath=//android.view.ViewGroup[@content-desc="account_details"]/android.widget.TextView[@text='${mobile['account']['label']['accountDetails']}']
${myaccount.txt_name_surname}               xpath=//android.view.ViewGroup[@content-desc="account_details"]/android.widget.TextView[@text="${mobile['account']['label']['accountDetails']}"]/following-sibling::android.widget.TextView[@text="{{firstname}}${SPACE}{{lastname}}"]
${myaccount.txt_email}                      xpath=//android.view.ViewGroup[@content-desc="account_details"]/android.widget.TextView[@text="${mobile['account']['label']['accountDetails']}"]/following-sibling::android.widget.TextView[normalize-space(@text)="{{email}}"]
${myaccount.txt_phone}                      xpath=//android.widget.TextView[@text='${mobile['global']['phone']}']//following-sibling::android.widget.TextView[@text="{{phone}}"]
${myaccount.txt_dash}                       xpath=//android.widget.TextView[@text='${mobile['global']['phone']}']//following-sibling::android.widget.TextView[@text="-"]
${myaccount.txt_specify_info}               xpath=//android.widget.TextView[@text='${mobile_additional['my_account']['specify_info']}']
${myaccount.txt_account_details_phone}      xpath=//android.view.ViewGroup[@content-desc="account_details"]/android.widget.TextView[@text='${mobile['global']['phone']}']
${myaccount.txt_change_phone_number}        xpath=//android.widget.TextView[@text='${mobile_additional['my_account']['change_phone_number']}']
${myaccount.input_name_txt}                 xpath=//android.widget.TextView[@text='${mobile_additional['my_account']['name']}']//ancestor::android.view.ViewGroup/android.view.ViewGroup/android.widget.EditText
${myaccount.input_name}                     xpath=//android.widget.EditText[@text='${mobile_additional['my_account']['name']}']
${myaccount.input_surname_txt}              xpath=//android.widget.TextView[@text='${mobile_additional['my_account']['surname']}']//ancestor::android.view.ViewGroup/android.view.ViewGroup/android.widget.EditText
${myaccount.input_surname}                  xpath=//android.widget.EditText[@text='${mobile_additional['my_account']['surname']}']
${myaccount.input_email_txt_email}          xpath=//android.widget.TextView[@text='${mobile['global']['email']}*']//ancestor::android.view.ViewGroup/android.view.ViewGroup/android.widget.EditText[@text='{{email}}']
${myaccount.txt_save}                       xpath=//android.widget.TextView[@text='${mobile['global']['save']}']
${myaccount.txt_cancel}                     xpath=//android.widget.TextView[@text='${mobile['global']['cancel']}']
${myaccount.yes_and_confirm}                xpath=//android.widget.TextView[@text='${mobile_additional['my_account']['want_to_cancel']}']//following-sibling::android.view.ViewGroup/android.widget.TextView[@text='${mobile['global']['yesAndConfirm']}']
${myaccount.no_and_go_back}                 xpath=//android.widget.TextView[@text='${mobile_additional['my_account']['want_to_cancel']}']//following-sibling::android.view.ViewGroup/android.widget.TextView[@text='${mobile['global']['noAndGoBack']}']
${myaccount.txt_save_success}               xpath=//android.widget.TextView[@text='${mobile_additional['my_account']['save_success']}']
${myaccount.input_name_surname_txt}         xpath=//android.widget.TextView[@text="${mobile_additional['my_account']['name_surname']}"]/following-sibling::android.view.ViewGroup/android.widget.EditText[@content-desc="input_container"]
${myaccount.input_name_surname}             xpath=//android.widget.EditText[@content-desc="input_container" and @text="${mobile_additional['my_account']['name_surname']}"]
${myaccount.input_email_txt}                xpath=//android.widget.TextView[@text="${mobile['global']['email']}*"]/following-sibling::android.view.ViewGroup/android.widget.EditText[@content-desc="input_container"]
${myaccount.input_email}                    xpath=//android.widget.EditText[@content-desc="input_container" and @text="${mobile['global']['email']}*"]
${myaccount.please_specify_name_surname}    xpath=//android.widget.EditText[@content-desc="input_container" and @text="${mobile_additional['my_account']['name_surname']}"]/ancestor::android.view.ViewGroup/following-sibling::android.widget.TextView[@text="${mobile_additional['my_account']['please_specify']}"]
${myaccount.please_specify_email}           xpath=//android.widget.EditText[@content-desc="input_container" and @text="${mobile['global']['email']}*"]/ancestor::android.view.ViewGroup/following-sibling::android.widget.TextView[@text="${mobile_additional['my_account']['please_specify']}"]
${myaccount.please_specify_valid_email}     xpath=//android.widget.TextView[@text="${mobile['global']['email']}*"]/ancestor::android.view.ViewGroup/android.widget.TextView[@text="${mobile_additional['my_account']['specify_valid']}"]
${myaccount.txt_false_update}               xpath=//android.widget.TextView[@text="${mobile['global']['update']}"]/parent::android.view.ViewGroup[@enabled="false"]
${myaccount.txt_true_update}                xpath=//android.widget.TextView[@text="${mobile['global']['update']}"]/parent::android.view.ViewGroup[@enabled="true"]
${myaccount.toast_success}                  xpath=//android.widget.TextView[@text="${mobile_additional['my_account']['toast_success']}"]/preceding-sibling::android.view.ViewGroup[@content-desc="toast_success"]
${myaccount.details_name}                   xpath=//android.view.ViewGroup[@content-desc="account_details"]/android.widget.TextView[@text="${mobile['account']['label']['accountDetails']}"]/following-sibling::android.widget.TextView[normalize-space(@text)="{{name}}"]
${myaccount.details_email}                  xpath=//android.view.ViewGroup[@content-desc="account_details"]/android.widget.TextView[@text="${mobile['account']['label']['accountDetails']}"]/following-sibling::android.widget.TextView[normalize-space(@text)="{{email}}"]
${myaccount.my_address}                     xpath=//android.widget.TextView[@text="${mobile['address']['title']['overviewTitle']}"]
${myaccount.txt_address_name}               xpath=//android.widget.TextView[@text="{{address_name}}"]
${myaccount.btn_default_address}            xpath=//android.widget.TextView[@text="${mobile['address']['button']['default']}"]
${myaccount.txt_default_address_name}       xpath=//android.widget.TextView[@text="${mobile['address']['message']['defaultLabelAddress']}"]/following-sibling::android.widget.TextView[@text="{{address_name}}"]
${myaccount.txt_total_point}                xpath=//android.widget.TextView[@text="${mobile['loyalty']['label']['my_profile_loyalty_label']}"]/preceding-sibling::android.view.ViewGroup/android.widget.TextView
${myaccount.txt_otp}                       xpath=//android.view.ViewGroup/android.widget.TextView[@text="${mobile['confirmOTP']['message']['titleSixDigit']}"]/following-sibling::android.widget.EditText
${myaccount.verify_email_btn}              xpath=//android.view.ViewGroup/android.widget.TextView[@text="${mobile['confirmOTP']['button']['verifyEmail']}"]
${myaccount.txt_default_address}           xpath=//android.widget.ScrollView//android.widget.TextView[contains(@text,""${mobile['address']['message']['defaultLabelAddress']}"")]/following-sibling::android.widget.TextView[3]
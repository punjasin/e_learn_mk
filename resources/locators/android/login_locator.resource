***Settings***
Variables       ../../localisation/mobile/${lang}.yaml
Variables       ../../localisation/mobile/${lang}_additional.yaml

*** Variables ***
${login.btn_login}                                        xpath=//android.view.ViewGroup[android.widget.TextView[@text='${mobile['login']['label']['login']}']]
${login.btn_login_by_email}                               xpath=//android.widget.TextView[@text="${mobile['global']['email']}"]/parent::android.view.ViewGroup
${login.input_email}                                      xpath=//android.widget.EditText[@content-desc="${mobile_additional['other_textbox']['login_with_input_email']}" and @text="${mobile['global']['email']}"]
${login.input_password}                                   accessibility_id=input_password
${login.btn_confirm_login}                                xpath=//android.widget.TextView[@text="${mobile['login']['label']['login']}"]/parent::android.view.ViewGroup
${login.input_customer_email}                             xpath=//android.widget.EditText[@resource-id="CustomerEmail"]
${login.input_customer_password}                          xpath=//android.widget.EditText[@resource-id="CustomerPassword"]
${login.btn_login}                                        xpath=//android.widget.Button[@text='${login['button']['login']}']
${login.txt_order}                                        xpath=//android.view.ViewGroup[1][android.view.View[@text='${mobile['order']['title']}']]
${login.txt_fix_info}                                     xpath=//android.view.View[@text='${mobile_additional['login']['message']['fix_info']}']
${login.txt_invalid_info}                                 xpath=//android.widget.TextView[@text='${mobile_additional['login']['message']['invalid_info']}']
${login.txt_please_login}                                 xpath=//android.widget.TextView[@text='${mobile_additional['login']['message']['please_login']}']
${login.input_password_eye_icon_active}                   xpath=//android.view.ViewGroup[@content-desc="input_password_eye_icon_active"]
${login.login_with_email_input_password}                  xpath=//android.widget.EditText[@content-desc="login_with_email_input_password"]
${login.forgot_your_password}                             xpath=//android.view.View[@content-desc="${mobile_additional['login']['message']['forgot_your_password']}"]
${login.txt_login}                                        xpath=//android.view.View[@text="${mobile['login']['label']['login']}"]
${login.txt_select_login}                                 xpath=//android.widget.TextView[@text="${mobile_additional['login']['message']['select_login']}"]
${login.phone_number}                                     xpath=//android.widget.TextView[@text="${mobile['account']['label']['mobile']}"]
${login.email}                                            xpath=//android.view.View[@content-desc="login_form_container_tab_email, ${mobile['global']['email']}"]/android.widget.TextView
${login.create_account}                                   xpath=//android.widget.TextView[@text="${mobile['login']['label']['createAccount']}"]/parent::android.view.ViewGroup
${login.icon_button}                                      xpath=//android.view.ViewGroup[@content-desc="icon_button"]
${login.login_with_email_login_button_enabled}            xpath=//android.widget.TextView[@text="${mobile['login']['label']['login']}"]/parent::android.view.ViewGroup
${login.txt_create_account}                               xpath=//android.view.View[@text="${mobile['login']['label']['createAccount']}"]
${login.please_fill_out}                                  xpath=//android.widget.TextView[@text="${mobile_additional['login']['message']['please_fill_out']}"]
${login.input_name_surname}                               xpath=//android.widget.EditText[@content-desc="input_container" and @text="${mobile_additional['login']['message']['name_surname']}"]
${login.input_phone_number}                               xpath=//android.widget.EditText[@content-desc="input_container" and @text="${mobile_additional['login']['message']['phone_number']}"]
${login.policy}                                           xpath=//android.widget.TextView[@text="${mobile_additional['login']['message']['policy']}"]
${login.enabled_create_account}                           xpath=//android.widget.TextView[@text="${mobile['login']['label']['createAccount']}"]/parent::android.view.ViewGroup[@enabled="true"]
${login.disable_create_account}                           xpath=//android.widget.TextView[@text="${mobile['login']['label']['createAccount']}"]/parent::android.view.ViewGroup[@enabled="false"]
${login.txt_please_valid_phone_number}                    xpath=//android.widget.TextView[@text="${mobile['global']['phone']}*"]/parent::android.view.ViewGroup/following-sibling::android.widget.TextView[@text="${mobile_additional['login']['message']['txt_please_valid_phone_number']}"]
${login.txt_please_specify}                               xpath=//android.widget.EditText[@content-desc="input_container" and @text="${mobile_additional['login']['message']['name_surname']}"]/ancestor::android.view.ViewGroup/android.widget.TextView[@text="${mobile_additional['login']['label']['please_specify']}"]
${login.txt_authenticate}                                 xpath=//android.view.View[@text="${mobile_additional['login']['message']['authenticate']}"]
${login.txt_fill_otp}                                     xpath=//android.widget.TextView[@text="${mobile_additional['login']['message']['fill_otp']}"]
${login.edittext}                                         xpath=//android.widget.EditText
${login.txt_verify_password}                              xpath=//android.widget.TextView[@text="${mobile_additional['login']['message']['verify_password']}"]/parent::android.view.ViewGroup
${login.txt_sent_otp_again}                               xpath=//android.widget.TextView[@text="${mobile_additional['login']['message']['sent_otp_again']}"]/parent::android.view.ViewGroup
${login.invalid_otp}                                      xpath=//android.view.ViewGroup[@content-desc="toast_warning"]/following-sibling::android.widget.TextView[@text="${mobile_additional['login']['message']['invalid_otp']}"]
${login.input_login_with_email}                           accessibility_id=input_email
${login.txt_forget_password}                              xpath=//android.view.ViewGroup[@content-desc="login_with_email_forgot_password_button"]/android.widget.TextView[@text="${mobile['login']['label']['forgotPassword']}"]
${login.confirm_email_input}                              xpath=//android.widget.EditText[@content-desc="reset_password_screen_confirm_email_input"]
${login.confirm_button_enabled}                           xpath=//android.view.ViewGroup[@content-desc="reset_password_screen_confirm_button_enabled"]
${login.confirm_new_password_input_newPassword}           xpath=//android.widget.EditText[@content-desc="reset_password_screen_confirm_new_password_input_newPassword"]
${login.confirm_new_password_input_confirmNewPassword}    xpath=//android.widget.EditText[@content-desc="reset_password_screen_confirm_new_password_input_confirmNewPassword"]
${login.toast_warning}                                    xpath=//android.view.ViewGroup[@content-desc="toast_warning"]/following-sibling::android.widget.TextView[@text="${mobile['login']['message']['loginFailed']}"]
${login.update_info_account}                              xpath=//android.widget.TextView[@text="${mobile['accountUpdate']['label']['titlePhone']}"]
${login.add_phone_number_to_account}                      xpath=//android.widget.TextView[@text="${mobile['accountUpdate']['message']['descriptionPhone']}"]
${login.please_specify_phone_number}                      xpath=//android.widget.EditText[@content-desc="input_container" and @text="${mobile_additional['login']['message']['please_specify_phone_number']}"]
${login.continue_with_phone_number}                       xpath=//android.widget.TextView[@text="${mobile_additional['login']['message']['continue_with_phone_number']}"]/parent::android.view.ViewGroup
${login.txt_phone_number}                                 xpath=//android.view.View[@text="${mobile['login']['label']['login']}"]/ancestor::android.view.ViewGroup/following-sibling::android.view.ViewGroup//android.widget.TextView[@text="${mobile_additional['login']['label']['phone_number']}"] 
${login.input_telephone_number}                           xpath=//android.widget.EditText[@content-desc="input_phoneNumber"]
${login.txt_sent_otp}                                     xpath=//android.widget.TextView[@text="${mobile_additional['login']['label']['sent_otp']}"]/parent::android.view.ViewGroup
${login.description_phone}                                xpath=//android.widget.TextView[@text='${mobile['accountUpdate']['label']['titlePhone']}']/following-sibling::android.widget.TextView[@text='${mobile['accountUpdate']['message']['descriptionPhone']}']
${login.input_container}                                  xpath=//android.widget.EditText[@content-desc="input_container"]
${login.txt_phoneNumber}                                  xpath=//android.widget.TextView[@text='${mobile['accountUpdate']['button']['phoneNumber']}']
${login.enter_valid_phone}                                xpath=//android.widget.TextView[@text='${mobile['account']['message']['enterValidPhone']}']
${login.btn_login_by_phone}                               xpath=//android.view.ViewGroup[@content-desc="login_input_list_button"]
${login.txt_welcome_page_title}                           xpath=//android.widget.TextView[@text="${mobile['makroClickOnboarding']['label']['titlev2']}"]
${login.btn_login_or_register}                            accessibility_id=makro_click_onboarding_login_or_register_button
${login.input_customer_login}                             xpath=//form[@id="customer_login"]/div/Input
${login.txt_account_created_successfully}                 xpath=//android.widget.TextView[@text='${mobile['account']['message']['accountCreatedSuccessfully']}']
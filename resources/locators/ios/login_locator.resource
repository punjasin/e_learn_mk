***Settings***
Variables       ../../localisation/mobile/${lang}.yaml
Variables       ../../localisation/mobile/${lang}_additional.yaml

*** Variables ***
${login.btn_login}                                        chain=**/XCUIElementTypeOther[`label == "${mobile['login']['label']['login']}"`]
${login.btn_login_by_email}                               chain=**/XCUIElementTypeOther[`label == "${mobile['global']['email']}"`]
${login.input_email}                                      chain=**/XCUIElementTypeTextField[`name == "${mobile_additional['other_textbox']['login_with_input_email']}"`]
${login.input_password}                                   accessibility_id=input_password
${login.btn_confirm_login}                                chain=**/XCUIElementTypeOther[`label == "${mobile['login']['label']['login']}" AND name == "${mobile_additional['other_button']['confirm_login_with_email']}"`]
${login.txt_login}                                        xpath=//XCUIElementTypeStaticText[@name="${mobile['login']['label']['login']}"]
${login.input_customer_email}                             xpath=//XCUIElementTypeOther[@name="${mobile['global']['email']}"]//following-sibling::XCUIElementTypeTextField
${login.txt_forget_password}                              xpath=//XCUIElementTypeOther[@name="${mobile['login']['label']['password']}"]//following-sibling::XCUIElementTypeSecureTextField
${login.btn_login}                                        chain=**/XCUIElementTypeButton[`label == "${login['button']['login']}"`]
${login.txt_order}                                        xpath=//XCUIElementTypeNavigationBar[@name="${mobile['order']['title']}"]
${login.forgot_your_password}                             chain=**/XCUIElementTypeStaticText[`label == "${mobile_additional['login']['message']['forgot_your_password']}"`]
${login.reset_your_password}                              chain=**/XCUIElementTypeStaticText[`label == "${mobile_additional['login']['message']['reset_your_password']}"`]
${login.vertical_scroll}                                  xpath=//XCUIElementTypeOther[contains(@name,"Vertical scroll")]/XCUIElementTypeOther[not(@name)]/XCUIElementTypeStaticText/following-sibling::XCUIElementTypeOther
${login.txt_create_account}                               chain=**/XCUIElementTypeStaticText[`label == "${mobile_additional['login']['label']['create_account']}"`]
${login.webview_close_icon}                               xpath=//XCUIElementTypeOther[@name="webview_close_icon"]
${login.toast_warning}                                    xpath=//XCUIElementTypeOther[@name="${mobile['login']['message']['loginFailed']}"]/following-sibling::XCUIElementTypeOther[@name='toast_warning']
${login.txt_please_login}                                 chain=**/XCUIElementTypeStaticText[`label == "${mobile_additional['login']['message']['please_login']}"`]
${login.login_with_email_input_password}                  chain=**/XCUIElementTypeSecureTextField[`name == "login_with_email_input_password"`]
${login.txt_password}                                     xpath=//XCUIElementTypeOther[@name="${mobile['login']['label']['password']}"]/following-sibling::XCUIElementTypeTextField 
${login.password}                                         xpath=//input[@name="customer[password]"]/following-sibling::span
${login.icon_eye_visible}                                 xpath=//*[name()='svg' and @class="icon-eye-visible"]
${login.icon_eye_hide}                                    xpath=//*[name()='svg' and @class="icon-eye-hide"]
${login.method_to_login}                                  chain=**/XCUIElementTypeStaticText[`label == "${mobile['login']['message']['methodToLogin']}"`]
${login.phone_number}                                     chain=**/XCUIElementTypeOther[`label == "${mobile['account']['label']['mobile']}"`]
${login.email}                                            chain=**/XCUIElementTypeOther[`label == "${mobile['global']['email']}"`]
${login.create_account}                                   chain=**/XCUIElementTypeOther[`label == "${mobile['login']['label']['createAccount']}"`]
${login.icon_button}                                      chain=**/XCUIElementTypeOther[`name == "icon_button"`]/**/XCUIElementTypeOther[4]
${login.please_fill_out}                                  chain=**/XCUIElementTypeStaticText[`label == "${mobile_additional['login']['message']['please_fill_out']}"`]
${login.input_name_surname}                               chain=**/XCUIElementTypeOther[`label == "${mobile_additional['login']['message']['name_surname']}"`]/XCUIElementTypeTextField[`name == "input"`]
${login.input_phone_number}                               chain=**/XCUIElementTypeOther[`label == "${mobile_additional['login']['message']['phone_number']}"`]/XCUIElementTypeTextField[`name == "input"`]
${login.policy}                                           chain=**/XCUIElementTypeOther[`label == "${mobile_additional['login']['message']['policy']}"`]
${login.enabled_create_account}                           chain=**/XCUIElementTypeOther[`label == "${mobile['login']['label']['createAccount']}" AND enabled == 1 AND accessible == 1`][2]
${login.disable_create_account}                           chain=**/XCUIElementTypeOther[`label == "${mobile['login']['label']['createAccount']}" AND enabled == 0`]
${login.txt_please_valid_phone_number}                    xpath=//XCUIElementTypeOther[@name="${mobile['global']['phone']}*"]/following-sibling::XCUIElementTypeStaticText[@name="${mobile_additional['login']['message']['txt_please_valid_phone_number']}"]
${login.txt_please_specify}                               xpath=//XCUIElementTypeOther[@name="${mobile_additional['login']['message']['name_surname']}"]/following-sibling::XCUIElementTypeStaticText[@name="${mobile_additional['login']['label']['please_specify']}"]
${login.txt_authenticate}                                 chain=**/XCUIElementTypeOther[`label == "${mobile_additional['login']['message']['authenticate']}"`]
${login.txt_fill_otp}                                     chain=**/XCUIElementTypeStaticText[`label == "${mobile_additional['login']['message']['fill_otp']}"`]
${login.edittext}                                         chain=**/XCUIElementTypeTextField   
${login.txt_verify_password}                              chain=**/XCUIElementTypeOther[`label == "${mobile_additional['login']['message']['verify_password']}"`] 
${login.input_login_with_email}                           accessibility_id=input_email
${login.txt_forget_password}                              chain=**/XCUIElementTypeStaticText[`label == "${mobile['login']['label']['forgotPassword']}"`]
${login.login_with_email_login_button_enabled}            xpath=//XCUIElementTypeOther[@name="login_input_list_forgot_password_button"]/following-sibling::XCUIElementTypeOther[@name="login_input_list_button"]
${login.confirm_email_input}                              chain=**/XCUIElementTypeTextField[`name == "reset_password_screen_confirm_email_input"`]
${login.confirm_button_enabled}                           chain=**/XCUIElementTypeOther[`label == "${mobile['global']['confirm']}" AND name == "reset_password_screen_confirm_button_enabled"`]
${login.create_new_password}                              chain=**/XCUIElementTypeOther[`label == "${mobile_additional['login']['label']['create_new_password']}"`]
${login.confirm_new_password_input_newPassword}           chain=**/XCUIElementTypeSecureTextField[`name == "reset_password_screen_confirm_new_password_input_newPassword"`]
${login.confirm_new_password_input_confirmNewPassword}    chain=**/XCUIElementTypeSecureTextField[`name == "reset_password_screen_confirm_new_password_input_confirmNewPassword"`]
${login.update_new_password_button_enabled}               chain=**/XCUIElementTypeOther[`label == "${mobile_additional['login']['label']['update_new_password']}" AND name == "reset_password_screen_update_new_password_button_enabled"`]
${login.btn_login_by_phone}                               xpath=//XCUIElementTypeOther[@name="login_input_list_button"]
${login.input_telephone_number}                           chain=**/XCUIElementTypeOther[`label == "${mobile['global']['phone']}"`]/XCUIElementTypeTextField[`name == "input_phoneNumber"`]
${login.txt_sent_otp}                                     chain=**/XCUIElementTypeOther[`label == "${mobile_additional['login']['label']['sent_otp']}"`][2]
${login.txt_account_created_successfully}                 chain=**/XCUIElementTypeStaticText[`label == "${mobile['account']['message']['accountCreatedSuccessfully']}"`]
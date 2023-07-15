***Settings***
Variables       ../../localisation/mobile/${lang}.yaml
Variables       ../../localisation/mobile/${lang}_additional.yaml

*** Variables ***
${register.create_new_account}                      xpath=//android.view.View[@text="${mobile_additional['register']['create_account']}"]
${register.individual_type}                         xpath=//android.view.ViewGroup[android.widget.TextView[@text="${mobile_additional['register']['individual']}"]]
${register.txt_create_new_account}                  xpath=//android.widget.TextView[@text='${mobile_additional['register']['create_new_account']}']
${register.register_firstname}                      xpath=//android.widget.EditText[contains(@text,"${mobile['kycRegister']['labels']['firstName']}")]
${register.register_lastname}                       xpath=//android.widget.EditText[contains(@text,"${mobile['kycRegister']['labels']['lastName']}")]
${register.register_mobile}                         xpath=//android.widget.EditText[contains(@text,"${mobile['kycRegister']['labels']['mobile']}")]
${register.register_email}                          xpath=//android.widget.EditText[@resource-id="RegisterForm-email"]
${register.popup_title_terms_and_conditions}        xpath=//android.view.View[@content-desc="${mobile_additional['register']['popup_title_terms_and_conditions']}"]
${register.register_password}                       xpath=//android.widget.EditText[@text="${mobile['kycRegister']['labels']['mobile']}"]
${register.register_checkbox}                       xpath=//android.widget.CheckBox[@resource-id="RegisterForm-tc-checkbox"]
${register.create}                                  xpath=//android.view.ViewGroup[android.widget.TextView[@text="${mobile['kycRegister']['button']['createAccount']}"]]
${register.popup_title_terms_and_conditions_txt}    xpath=//android.view.View[@text='${mobile_additional['register']['popup_title_terms_and_conditions']}']
${register.password_length_error}                   xpath=//android.view.View[@resource-id="RegisterForm-password-length-error" and @text="${mobile_additional['register']['password_length_error']}"]
${register.checkbox_unfilled_icon}                  xpath=//android.view.ViewGroup[@content-desc="checkbox_unfilled_icon"]
${register.txt_otp}                                 xpath=//android.view.ViewGroup[android.widget.TextView[@text="${mobile['confirmOTP']['message']['linkedWord']}"]]/following-sibling::android.widget.EditText
${register.register_btn}                            xpath=//android.view.ViewGroup[android.widget.TextView[@text="${mobile['kycRegister']['button']['createAccount']}"]]
${register.verify_otp_btn}                          xpath=//android.view.ViewGroup[android.widget.TextView[@text="${mobile['confirmOTP']['button']['verify']}"]]
${register.business_type}                           xpath=//android.view.ViewGroup[android.widget.TextView[@text="${mobile_additional['register']['business']}"]]
${register.select_business_type}                    xpath=//android.view.ViewGroup[android.widget.EditText[@text="${mobile_additional['register']['selectBusinessType']}"]]
${register.register_business_type}                  xpath=//android.widget.TextView[@text="{{business_type}}"]
${register.close_icon}                              accessibility_id=icon_button

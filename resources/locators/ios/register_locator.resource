***Settings***
Variables       ../../localisation/mobile/${lang}.yaml
Variables       ../../localisation/mobile/${lang}_additional.yaml

*** Variables ***
${register.create_new_account}                      chain=**/XCUIElementTypeStaticText[`label == "${mobile_additional['register']['create_account']}"`]
${register.txt_create_new_account}                  chain=**/XCUIElementTypeOther[`label == "${mobile_additional['register']['create_new_account']}"`]
${register.individual_type}                         xpath=//XCUIElementTypeOther[@name="${mobile_additional['register']['individual']}"]
${register.register_firstname}                      xpath=//XCUIElementTypeOther[contains(@name,"${mobile['kycRegister']['labels']['firstName']}")]/XCUIElementTypeTextField
${register.register_lastname}                       xpath=//XCUIElementTypeOther[contains(@name,"${mobile['kycRegister']['labels']['lastName']}")]/XCUIElementTypeTextField
${register.register_mobile}                         xpath=//XCUIElementTypeOther[contains(@name,"${mobile['kycRegister']['labels']['mobile']}")]/XCUIElementTypeTextField
${register.register_email}                          xpath=//XCUIElementTypeOther[@name="${mobile['global']['email']}"]//following-sibling::XCUIElementTypeTextField[1]
${register.txt_taxid}                               xpath=//XCUIElementTypeOther[@name="${mobile_additional['register']['txt_taxid']}"]//following-sibling::XCUIElementTypeTextField 
${register.register_password}                       xpath=//XCUIElementTypeOther[@name="${mobile_additional['register']['password']}"]//following-sibling::XCUIElementTypeSecureTextField 
${register.popup_title_terms_and_conditions}        chain=**/XCUIElementTypeLink[`label == "${mobile_additional['register']['popup_title_terms_and_conditions']}"`]
${register.popup_title_terms_and_conditions_txt}    chain=**/XCUIElementTypeStaticText[`label == "${mobile_additional['register']['popup_title_terms_and_conditions']}"`]
${register.webview_close_icon}                      xpath=//XCUIElementTypeOther[contains(@name,"webview_close_icon")]
${register.create}                                  chain=**/XCUIElementTypeButton[`label == "${mobile_additional['register']['create']}"`]
${register.txt_accept}                              chain=**/XCUIElementTypeStaticText[`label == "${mobile_additional['register']['accept']}"`]
${register.password_length_error}                   chain=**/XCUIElementTypeStaticText[`label == "${mobile_additional['register']['password_length_error']}"`]
${register.checkbox_unfilled_icon}                  xpath=//XCUIElementTypeOther[@name="checkbox_unfilled_icon"]
${register.txt_otp}                                 xpath=//XCUIElementTypeStaticText[@name="${mobile['confirmOTP']['message']['title']}"]/following-sibling::XCUIElementTypeOther/XCUIElementTypeOther/XCUIElementTypeTextField
${register.register_btn}                            xpath=//XCUIElementTypeOther[@name="${mobile['kycRegister']['button']['createAccount']}" and @enabled="true"]
${register.verify_otp_btn}                          xpath=//XCUIElementTypeOther[@name="${mobile['confirmOTP']['button']['verify']}"]
${register.business_type}                           xpath=//XCUIElementTypeOther[@name="${mobile_additional['register']['business']}"]
${register.select_business_type}                    xpath=(//XCUIElementTypeOther[@name="${mobile_additional['register']['selectBusinessType']}"])[2]
${register.register_business_type}                  xpath=//XCUIElementTypeOther[@name="{{business_type}}"]
${register.close_icon}                              accessibility_id=icon_button
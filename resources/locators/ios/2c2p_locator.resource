***Settings***
Variables       ../../localisation/mobile/${lang}.yaml
Variables       ../../localisation/mobile/${lang}_additional.yaml

*** Variables ***
${2c2p.txt_company_title}                       chain=**/XCUIElementTypeStaticText[`label == "${mobile_additional['other_label']['company_name']}"`]
${2c2p.option_bank_transfer}                    chain=**/XCUIElementTypeStaticText[`label == "${mobile_additional['other_label']['platform_choosed']}"`]
${2c2p.input_payer_name}                        xpath=//XCUIElementTypeOther[@name="${mobile_additional['other_label']['payer_name']}"]/following-sibling::XCUIElementTypeOther[1]/XCUIElementTypeTextField
${2c2p.input_email}                             xpath=//XCUIElementTypeOther[@name="${mobile_additional['other_textbox']['email']}"]/following-sibling::XCUIElementTypeOther[1]/XCUIElementTypeTextField
${2c2p.input_phone_number}                      xpath=//XCUIElementTypeOther[@name="${mobile_additional['other_textbox']['phone_number']}"]/following-sibling::XCUIElementTypeOther[1]/XCUIElementTypeTextField
${2c2p.btn_continue_payment}                    chain=**/XCUIElementTypeButton[`label == "${mobile_additional['other_button']['continue_payment']}"`]
${2c2p.bank_qr}                                 xpath=//XCUIElementTypeStaticText[@name="${mobile_additional['other_label']['qr_code']}"]
${2c2p.txt_bank_payment_ref}                    xpath=//XCUIElementTypeOther[@name="${mobile_additional['other_label']['payment_ref']}"]/XCUIElementTypeOther[4]/XCUIElementTypeOther[1]/XCUIElementTypeOther[2]/XCUIElementTypeStaticText
${2c2p.txt_bank_payment_amount}                 xpath=//XCUIElementTypeOther[@name="${mobile_additional['other_label']['payment_ref']}"]/XCUIElementTypeOther[4]/XCUIElementTypeOther[2]/XCUIElementTypeOther[2]/XCUIElementTypeStaticText
${2c2p.txt_bank_complete_company}               chain=**/XCUIElementTypeStaticText[`label == "${mobile_additional['other_label']['company_name_upper_text']}"`]
${2c2p.btn_bank_complete_return_to_merchant}    chain=**/XCUIElementTypeButton[`label == "${mobile_additional['other_button']['return_to_merchant']}"`]
${2c2p.btn_bank_complete_back_to_merchant}      chain=**/XCUIElementTypeButton[`label == "${mobile_additional['other_button']['back_to_merchant']}"`]
${2c2p.input_otp}                               xpath=//XCUIElementTypeOther[@name="${mobile_additional['other_label']['2c2p_label']}"]/XCUIElementTypeSecureTextField

${checkout_2c2p.global_card}                    chain=**/XCUIElementTypeStaticText[`label == "${mobile_additional['2c2p']['global_card']}"`]
${checkout_2c2p.internet_mobile_banking}        chain=**/XCUIElementTypeStaticText[`label == "${mobile_additional['other_label']['platform_choosed']}"`]
${checkout_2c2p.digital_payment}                chain=**/XCUIElementTypeStaticText[`label == "${mobile_additional['2c2p']['digital_payment']}"`]
${checkout_2c2p.card_number}                    xpath=//XCUIElementTypeOther[@name="CARD NUMBER"]/following-sibling::XCUIElementTypeOther[position()=1]/XCUIElementTypeTextField
${checkout_2c2p.expiry_date}                    xpath=//XCUIElementTypeOther[@name="EXPIRY DATE"]/following-sibling::XCUIElementTypeOther[position()=1]/XCUIElementTypeTextField
${checkout_2c2p.cvv}                            xpath=//XCUIElementTypeOther[@name="CVV/CVV2"]/following-sibling::XCUIElementTypeOther[position()=2]/XCUIElementTypeTextField
${checkout_2c2p.input_2c2p_plus}                xpath=//XCUIElementTypeOther[@name="2c2p Plus"]/XCUIElementTypeSecureTextField
${checkout_2c2p.textfield}                      xpath=//XCUIElementTypeSecureTextField
${checkout_2c2p.btn_verify}                         chain=**/XCUIElementTypeButton[`label == "${mobile_additional['2c2p']['btn_verify']}"`]
${checkout_2c2p.proceed}                        chain=**/XCUIElementTypeButton[`label == "${mobile_additional['2c2p']['proceed']}"`]
${checkout_2c2p.cardholder_name}                xpath=//XCUIElementTypeOther[@name="CARDHOLDER NAME"]/following-sibling::XCUIElementTypeOther[position()=1]/XCUIElementTypeTextField
${checkout_2c2p.continue_payment}               chain=**/XCUIElementTypeButton[`label == "${mobile_additional['2c2p']['continue_payment']}"`]
${checkout_2c2p.CANCEL}                         chain=**/XCUIElementTypeButton[`label == "${mobile_additional['2c2p']['btn_txt_cancel']}"`]
${checkout_2c2p.Cancel}                         chain=**/XCUIElementTypeButton[`label == "${mobile_additional['2c2p']['btn_cancel']}"`]
${checkout_2c2p.transaction_failed}             xpath=//XCUIElementTypeStaticText[contains(@name,"Transaction failed")]
${checkout_2c2p.transaction_successful}         xpath=//XCUIElementTypeStaticText[contains(@name,"Transaction is successful")]
${checkout_2c2p.back_to_merchant}               chain=**/XCUIElementTypeButton[`label == "${mobile_additional['other_button']['back_to_merchant']}"`]
${checkout_2c2p.customer_cancellation}          chain=**/XCUIElementTypeStaticText[`label == "${mobile_additional['2c2p']['customer_cancellation']}"`]
${checkout_2c2p.payer_name}                     xpath=//XCUIElementTypeOther[@name="PAYER NAME"]/following-sibling::XCUIElementTypeOther[1]/XCUIElementTypeTextField
${checkout_2c2p.email_address}                  xpath=//XCUIElementTypeOther[@name="EMAIL ADDRESS"]/following-sibling::XCUIElementTypeOther[1]/XCUIElementTypeTextField
${checkout_2c2p.phone_number}                   xpath=//XCUIElementTypeOther[@name="PHONE NUMBER"]/following-sibling::XCUIElementTypeOther[1]/XCUIElementTypeTextField
${checkout_2c2p.delete}                         chain=**/XCUIElementTypeKey[`label == "${mobile_additional['2c2p']['delete']}"`]
${checkout_2c2p.return_to_merchant}             chain=**/XCUIElementTypeButton[`label == "${mobile_additional['2c2p']['return_to_merchant']}"`]
${checkout_2c2p.qr_code}                        xpath=//XCUIElementTypeStaticText[@name="Qr Code"]
${checkout_2c2p.1_2_3_service_12}               xpath=//XCUIElementTypeStaticText[@name="${mobile_additional['other_label']['payment_code_1']}"]/parent::XCUIElementTypeOther/following-sibling::XCUIElementTypeOther/XCUIElementTypeStaticText
${checkout_2c2p.1_2_3_service_22}               xpath=//XCUIElementTypeStaticText[@name="${mobile_additional['other_label']['payment_amount']}"]/parent::XCUIElementTypeOther/following-sibling::XCUIElementTypeOther/XCUIElementTypeStaticText
${checkout_2c2p.successful}                     xpath=//XCUIElementTypeOther[@name="${mobile_additional['2c2p']['txt_successful']}"]
${checkout_2c2p.txt_company_title}              chain=**/XCUIElementTypeStaticText[`label == "${mobile_additional['other_label']['company_name']}"`]
${checkout_2c2p.simulate_success}               chain=**/XCUIElementTypeButton[`label == "${mobile_additional['2c2p']['btn_simulate_success']}"`]
${checkout_2c2p.main_price}                     chain=**/XCUIElementTypeOther[`label == "${mobile_additional['2c2p']['main']}"`]/**/XCUIElementTypeStaticText[`label == "{{price}}"`]
${checkout_2c2p.bank_transfer}                  chain=**/XCUIElementTypeStaticText[`label == "${mobile_additional['2c2p']['bank_transfer']}"`]
${checkout_2c2p.bankoption}                     chain=**/XCUIElementTypeStaticText[`label == "{{bankoption}}"`]
${checkout_2c2p.bankoption_local}               chain=**/XCUIElementTypeStaticText[`label == "{{bankoption}}"`]
${checkout_2c2p.txt_bank_qr}                    xpath=//XCUIElementTypeStaticText[@name="${mobile_additional['other_label']['qr_code']}"]
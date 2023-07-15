***Settings***
Variables       ../../localisation/mobile/${lang}.yaml
Variables       ../../localisation/mobile/${lang}_additional.yaml

*** Variables ***
${2c2p.txt_company_title}                           xpath=//android.view.View[@text='${mobile_additional['other_label']['company_name']}']
${2c2p.option_bank_transfer}                        xpath=//android.view.View[@text='${mobile_additional['other_label']['platform_choosed']}']
${2c2p.input_payer_name}                            xpath=//android.widget.EditText[@resource-id='text-name']
${2c2p.input_email}                                 xpath=//android.widget.EditText[@resource-id='email-email']
${2c2p.input_phone_number}                          xpath=//android.widget.EditText[following-sibling::android.view.View]
${2c2p.btn_continue_payment}                        xpath=//android.widget.Button[@text='${mobile_additional['other_button']['continue_payment']}']
${2c2p.txt_bank_qr}                                 xpath=//android.widget.TextView[@text='${mobile_additional['other_label']['qr_code']}']
${2c2p.txt_bank_payment_ref}                        xpath=//android.widget.TextView[@text='${mobile_additional['other_label']['payment_code_1']}']/following-sibling::android.widget.TextView
${2c2p.txt_bank_payment_amount}                     xpath=//android.widget.TextView[@text='${mobile_additional['other_label']['payment_amount']}']/following-sibling::android.widget.TextView[following-sibling::android.widget.TextView[@text='${mobile_additional['other_label']['payment_alert']}']]
${2c2p.txt_bank_complete_company}                   xpath=//android.widget.TextView[@text='${mobile_additional['other_label']['company_name_upper_text']}']
${2c2p.btn_bank_complete_return_to_merchant}        xpath=//android.widget.Button[@text='${mobile_additional['other_button']['return_to_merchant']}']
${2c2p.btn_bank_complete_back_to_merchant}          xpath=//android.widget.Button[@text='${mobile_additional['other_button']['back_to_merchant']}']
${2c2p.input_otp}                                   xpath=//android.widget.EditText[@resource-id='otp']

${checkout_2c2p.credit_debit}                       xpath=//android.view.View[@text="${mobile_additional['2c2p']['credit_debit']}"]/parent::android.view.View
${checkout_2c2p.card_number}                        xpath=//android.view.View[@text="${mobile_additional['2c2p']['card_number']}"]/following-sibling::android.widget.EditText
${checkout_2c2p.expiry_date}                        xpath=//android.view.View[@text="${mobile_additional['2c2p']['exp_date']}"]/following-sibling::android.widget.EditText
${checkout_2c2p.cvv}                                xpath=//android.view.View[@text="${mobile_additional['2c2p']['cvv']}"]/following-sibling::android.widget.EditText
${checkout_2c2p.cardholder_name}                    xpath=//android.view.View[@text="${mobile_additional['2c2p']['namecard']}"]/following-sibling::android.widget.EditText
${checkout_2c2p.email}                              xpath=//Input[@name="email"]
${checkout_2c2p.btn_continue}                       xpath=//android.widget.Button[@text="${mobile_additional['2c2p']['continue']}"]
${checkout_2c2p.loading}                            xpath=//android.view.View[@text="${mobile_additional['2c2p']['loading']}"]
${checkout_2c2p.proceed}                            xpath=//android.widget.Button[@text='${mobile_additional['2c2p']['proceed']}']
${checkout_2c2p.btn_cancel}                         xpath=//android.widget.Button[@resource-id='cancel' or @text='${mobile_additional['2c2p']['btn_cancel']}' ]
${checkout_2c2p.btn_txt_cancel}                     xpath=//android.widget.Button[@text='${mobile_additional['2c2p']['btn_txt_cancel']}']
${checkout_2c2p.payment_has_been_declined}          xpath=//android.view.View[@text="${mobile_additional['2c2p']['payment_has_been_declined']}"]
${checkout_2c2p.transaction_successful}             //android.view.View[contains(@text,'${mobile_additional['2c2p']['transaction_successful']}')]
${checkout_2c2p.customer_cancellation}              //android.view.View[contains(@text,'${mobile_additional['2c2p']['customer_cancellation']}')]
${checkout_2c2p.btn_back_to_merchant}               xpath=//android.widget.Button[@text="${mobile_additional['2c2p']['back_to_merchant']}"]
${checkout_2c2p.txt_successful}                     xpath=//android.view.ViewGroup[2][android.widget.TextView[@text='${mobile_additional['2c2p']['txt_successful']}']]
${checkout_2c2p.bank_transfer}                      xpath=//android.view.View/android.widget.TextView[@text="${mobile_additional['2c2p']['bank_transfer']}"]/parent::android.view.View
${checkout_2c2p.bank_transfer_local}                xpath=//android.view.View[@text="${mobile_additional['2c2p']['bank_transfer']}"]/parent::android.view.View
${checkout_2c2p.select_bank}                        xpath=//android.view.View[@text="${mobile_additional['2c2p']['select_bank']}"]/preceding-sibling::android.widget.Image
${checkout_2c2p.kasikorn_bank}                      xpath=//android.view.View[contains(@text,'${mobile_additional['2c2p']['kasikorn_bank']}')]
${checkout_2c2p.txt_bank_qr}                        xpath=//android.widget.TextView[@text='${mobile_additional['other_label']['qr_code']}']
${checkout_2c2p.txt_bank_payment_ref}               xpath=//android.widget.TextView[@text='${mobile_additional['other_label']['payment_code_1']}']/following-sibling::android.widget.TextView
${checkout_2c2p.txt_bank_payment_amount}            xpath=//android.widget.TextView[@text='${mobile_additional['other_label']['payment_amount']}']/following-sibling::android.widget.TextView[following-sibling::android.widget.TextView[@text='${mobile_additional['other_label']['payment_alert']}']]
${checkout_2c2p.bankoption}                         xpath=//android.view.View/android.widget.TextView[@text="{{bankoption}}"]/parent::android.view.View
${checkout_2c2p.bankoption_local}                   xpath=//android.view.View[@text="{{bankoption}}"]/parent::android.view.View
${checkout_2c2p.true_wallet}                        xpath=//android.view.View[@text="${mobile_additional['2c2p']['true_wallet']}"]/parent::android.view.View
${checkout_2c2p.upper_otp_id}                       xpath=//android.widget.EditText[@resource-id='OTP']
${checkout_2c2p.btn_verify}                         xpath=//android.widget.Button[@text='${mobile_additional['2c2p']['btn_verify']}']
${checkout_2c2p.btn_simulate_success}               xpath=//android.widget.Button[@text='${mobile_additional['2c2p']['btn_simulate_success']}']
${checkout_2c2p.main_price}                         xpath=//android.view.View[@text="${mobile_additional['2c2p']['bank_name']}"]/following-sibling::android.view.View[@text="{{price}} THB"]


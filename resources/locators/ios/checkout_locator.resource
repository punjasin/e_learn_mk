***Settings***
Variables       ../../localisation/mobile/${lang}.yaml
Variables       ../../localisation/mobile/${lang}_additional.yaml

*** Variables ***
${checkout_shipping_address.btn_continue_shipping_date}     chain=**/XCUIElementTypeButton[`label == "${mobile_additional['checkout']['message']['proceedToDelivery']}"`]
${checkout_shipping_address.txt_select_pin_title}           chain=**/XCUIElementTypeOther[`label == "${mobile_additional['message']['check_pin_area']}"`]
${checkout_shipping_address.btn_update_pin}                 chain=**/XCUIElementTypeButton[`label == "${mobile_additional['button']['edit_pin']}"`]
${checkout_shipping_address.btn_accept_pindrop}             chain=**/XCUIElementTypeButton[`label == "${mobile_additional['button']['noted']}"`]
${checkout_shipping_address.dialog_update_pin}              chain=**/XCUIElementTypeOther[`label == "${mobile_additional['other_button']['map']}"`]
${checkout_shipping_address.btn_confirm_update_pin}         chain=**/XCUIElementTypeButton[`label == "${mobile_additional['button']['confirmed_address']}"`]
${checkout_shipping_address.btn_confirm_update_address}     chain=**/XCUIElementTypeButton[`label == "${mobile_additional['checkout']['button']['saveAndContinue']}"`]
${checkout_shipping_address.address_saved}                  xpath=//XCUIElementTypeOther[@name="${mobile_additional['checkout']['message']['address_saved']}"]/following-sibling::XCUIElementTypeOther[1]
${checkout_shipping_address.address_name}                   chain=**/XCUIElementTypeButton[`label == "{{address_name}}"`]
${checkout_shipping_address.add_new_address}                xpath=//XCUIElementTypeButton[@name="${mobile_additional['checkout']['message']['add_new_address']}"]
${checkout_shipping_address.field_resource_id_typeother}    xpath=//XCUIElementTypeOther[@name="{{field_resource_id}}"]/following-sibling::XCUIElementTypeOther[1]
${checkout_shipping_address.field_resource_id}              xpath=//XCUIElementTypeOther[@name="{{field_resource_id}}"]/following-sibling:: XCUIElementTypeTextField[1]
${checkout_shipping_address.province}                       chain=**/XCUIElementTypeButton[`label == "{{province}}"`]
${checkout_shipping_address.district}                       chain=**/XCUIElementTypeButton[`label == "{{district}}"`]
${checkout_shipping_address.txt_step2of3}                   chain=**/XCUIElementTypeStaticText[`label == "${mobile_additional['checkout']['message']['step2of3']}"`]
${checkout_shipping_address.verify_pin}                     chain=**/XCUIElementTypeOther[`label == "${mobile_additional['checkout']['message']['check_pin_area']}"`]
${checkout_shipping_address.map}                            chain=**/XCUIElementTypeOther[`label == "${mobile_additional['checkout']['message']['map']}"`]
${checkout_shipping_address.confirm_location}               chain=**/XCUIElementTypeButton[`label == "${mobile_additional['checkout']['button']['confirmed_address']}"`]
${checkout_shipping_address.save_and_continue}              chain=**/XCUIElementTypeButton[`label == "${mobile_additional['checkout']['button']['saveAndContinue']}"`]
${checkout_shipping_address.pin_your_location}              chain=**/XCUIElementTypeOther[`label == "${mobile_additional['checkout']['message']['pin_your_location']}"`]
${checkout_shipping_address.disable_save_and_continue}      xpath=//XCUIElementTypeButton[@name="${mobile_additional['checkout']['button']['saveAndContinue']}" and @enabled="false"]
${checkout_shipping_address.txt_step1of3}                   chain=**/XCUIElementTypeStaticText[`label == "${mobile_additional['checkout']['message']['step1of3']}"`]
${checkout_shipping_address.address_for_delivery}           xpath=//XCUIElementTypeOther[@name="${mobile_additional['checkout']['message']['address_for_delivery']}"]/following-sibling::XCUIElementTypeOther/XCUIElementTypeButton[{{address_no}}*]/preceding-sibling::XCUIElementTypeOther[1]
${checkout_shipping_address.btn_close}                      xpath=//XCUIElementTypeOther[@name="${mobile_additional['checkout']['message']['address_details']}, web dialog"]/XCUIElementTypeButton[@name="Close"]

${checkout_delivery_slot.txt_step_2_of_3}                    chain=**/XCUIElementTypeStaticText[`label == "${mobile_additional['checkout']['message']['step2of3']}"`]
${checkout_delivery_slot.txt_step_3_of_3}                    chain=**/XCUIElementTypeStaticText[`label == "${mobile_additional['checkout']['message']['step3of3']}"`]
${checkout_delivery_slot.btn_continue_billing}               chain=**/XCUIElementTypeButton[`label == "${mobile_additional['button']['continue_payment']}"`]
${checkout_delivery_slot.starts_with_day}                    xpath=//XCUIElementTypeStaticText[starts-with(@name,"${mobile_additional['checkout']['message']['day']}")]
${checkout_delivery_slot.zerozero}                           xpath=//XCUIElementTypeOther[contains(@value,'${mobile_additional['checkout']['message']['zerozero']}')]
${checkout_delivery_slot.shipping_date}                      xpath=(//XCUIElementTypeOther[@name="Shipping date"]/following-sibling::XCUIElementTypeOther//XCUIElementTypeStaticText)[1]
${checkout_delivery_slot.delivery_round_is_fully_booked}     chain=**/XCUIElementTypeStaticText[`label == "${mobile_additional['checkout']['message']['delivery_round_is_fully_booked']}"`]

${checkout_billing.btn_complete_checkout}                    chain=**/XCUIElementTypeButton[`label == "${mobile_additional['checkout']['button']['completeOrder']}"`]
${checkout_billing.change_date_and_time}                     chain=**/XCUIElementTypeLink[`label == "${mobile_additional['checkout']['message']['change_date_and_time']}"`][2]
${checkout_billing.change_address_for_delivery_typeother}    xpath=//XCUIElementTypeLink[@name="${mobile_additional['checkout']['message']['change_address_for_delivery']}" and position()=1]/parent::XCUIElementTypeOther
${checkout_billing.tax_address}                              chain=**/XCUIElementTypeStaticText[`label == "${mobile_additional['checkout']['message']['use_other_for_tax_invoices']}"`]
${checkout_billing.address_saved}                            xpath=///XCUIElementTypeOther[@name="${mobile_additional['checkout']['message']['address_saved']}"]/following-sibling::XCUIElementTypeOther[position()=1]
${checkout_billing.change_address_for_delivery}              chain=**/XCUIElementTypeButton[`label == "${mobile_additional['checkout']['message']['change_address_for_delivery']}"`]
${checkout_billing.company_name}                             xpath=//XCUIElementTypeOther[@name="${mobile_additional['checkout']['message']['company_name']}"]/following-sibling::XCUIElementTypeOther[position()=2 and @name="${mobile_additional['checkout']['message']['name']}"]
${checkout_billing.picker_wheel}                             xpath=//XCUIElementTypePickerWheel
${checkout_billing.btn_same_as_shipping_address}             xpath=//XCUIElementTypeStaticText[@name="${mobile_additional['checkout']['message']['same_as_shipping_address']}"]
${checkout_billing.confirm_order}                            chain=**/XCUIElementTypeStaticText[`label == "${mobile_additional['checkout']['message']['confirm_order']}"`]
${checkout_billing.basket_are_out_of_stock}                  xpath=//XCUIElementTypeOther[@name="alert"]//XCUIElementTypeStaticText[@name="${mobile_additional['checkout']['message']['basket_are_out_of_stock']}"]
${checkout_billing.tax_id}                                   xpath=//XCUIElementTypeOther[@name="${mobile_additional['checkout']['message']['tax_id']}"]/following-sibling::XCUIElementTypeTextField[1]
${checkout_billing.typeother_id}                             chain=**/XCUIElementTypeOther[`label == "${mobile_additional['checkout']['message']['address_for_payment']}"`]/**/XCUIElementTypeStaticText[`label == "${mobile_additional['checkout']['message']['error_msg']}"`]
${checkout_billing.complete_order}                           chain=**/XCUIElementTypeButton[`label == "${mobile_additional['checkout']['button']['completeOrder']}" AND enabled == 1`]
${checkout_billing.txt_step1of3}                             chain=**/XCUIElementTypeStaticText[`label == "ขั้นที่ 1 จาก 3"`]
${checkout_billing.timeslot_error_container}                 xpath=//XCUIElementTypeOther[@name="alert"]

${checkout.btn_finish_checkout}            xpath=//XCUIElementTypeOther[@name="${mobile['global']['done']}"]
${checkout.expected_msg}                   chain=**/XCUIElementTypeStaticText[`label == "{{expected_msg}}"`]
${checkout.field_resource_id_typeother}    xpath=//XCUIElementTypeOther[@name="{{field_resource_id}}"]/following-sibling::XCUIElementTypeOther[1]
${checkout.field_resource_id_textfield}    xpath=//XCUIElementTypeOther[@name="{{field_resource_id}}"]/following-sibling::XCUIElementTypeTextField[1]
${checkout.name_address}                   xpath=//XCUIElementTypeOther[@name="${mobile_additional['checkout']['message']['name_address']}"]/following-sibling::XCUIElementTypeOther[position()=1 and @name="${mobile_additional['checkout']['message']['name']}"]
${checkout.zip_code}                       xpath=//XCUIElementTypeOther[@name="${mobile_additional['checkout']['message']['apartment']}"]/following-sibling::XCUIElementTypeOther[position()=1 and @name="${mobile_additional['checkout']['message']['zip_code']}"]
${checkout.advice}                         xpath=//XCUIElementTypeOther[@name="${mobile_additional['checkout']['message']['advice']}"]/following-sibling::XCUIElementTypeOther[position()=2]
${checkout.statictext_phone}               chain=**/XCUIElementTypeStaticText[`label == "${mobile_additional['checkout']['message']['statictext_phone']}"`]
${checkout.statictext_phone_completed}     chain=**/XCUIElementTypeStaticText[`label == "${mobile_additional['checkout']['message']['statictext_phone_completed']}"`]
${checkout.branch_code}                    xpath=//XCUIElementTypeOther[@name="${mobile_additional['checkout']['message']['tax_id']}"]/following-sibling::XCUIElementTypeOther[position()=1 and @name='${mobile_additional['checkout']['message']['branch_code']}']
${checkout.company}                        xpath=//XCUIElementTypeOther[@name="${mobile_additional['checkout']['message']['branch_code']}"]/following-sibling::XCUIElementTypeOther[position()=1 and @name='${mobile_additional['checkout']['message']['company_name']}']
${checkout.typeother}                      xpath=//XCUIElementTypeOther[XCUIElementTypeStaticText and XCUIElementTypeOther]/XCUIElementTypeOther
${checkout.btn_goToPayment}                xpath=//XCUIElementTypeButton[@name="${mobile_additional['checkout']['button']['goToPayment']}"]
***Settings***
Variables       ../../localisation/mobile/${lang}.yaml
Variables       ../../localisation/mobile/${lang}_additional.yaml

*** Variables ***
${voucher.icon_button}                             chain=**/XCUIElementTypeOther[`name == "vocuher_form"`]/**/XCUIElementTypeOther[`name == "icon_button"`]
${voucher.vocuher_input}                           chain=**/XCUIElementTypeOther[`name == "vocuher_form"`]/**/XCUIElementTypeTextField[`name == "vocuher_input"`]
${voucher.icon_button_2}                           xpath=//XCUIElementTypeOther[@name="vocuher_form"]//XCUIElementTypeOther[@name="icon_button"]
${voucher.code}                                    chain=**/XCUIElementTypeOther[`name == "vocuher_form"`]/**/XCUIElementTypeTextField[`name == "vocuher_input" AND value == "{{code}}"`]
${voucher.vocuher_apply_button}                    xpath=//XCUIElementTypeOther[@name="vocuher_apply_button"]/XCUIElementTypeStaticText[@name="${mobile['global']['apply']}"]
${voucher.txt_toast_success}                       xpath=//XCUIElementTypeOther[@name="toast_success"]/following-sibling::XCUIElementTypeOther[@name='${mobile_additional['voucher']['message']['voucherApplied_b']}']
${voucher.txt_code_cannot_use}                     xpath=//XCUIElementTypeOther[@name='${mobile['voucher']['message']['voucherNotApplied']}']/XCUIElementTypeOther[@name='toast_warning']
${voucher.txt_discount}                            xpath=//XCUIElementTypeStaticText[@name="-{{discount}} ฿" and @accessible="true"]
${voucher.basket_summary_section_voucher_badge}    chain=**/XCUIElementTypeOther[`name == "basket_summary_section_voucher_badge"`]
${voucher.complementary}                           xpath=//XCUIElementTypeOther[@name="complementary"]/XCUIElementTypeOther[@name='${mobile['voucher']['label']['vouchers']}']/following-sibling::XCUIElementTypeTextField
${voucher.complementary_code}                      xpath=//XCUIElementTypeOther[@name="complementary"]/XCUIElementTypeOther[@name='${mobile['voucher']['label']['vouchers']}']/following-sibling::XCUIElementTypeTextField[@value="{{code}}"]
${voucher.main_voucher}                            xpath=//XCUIElementTypeOther[@name="main"]/XCUIElementTypeOther[@name="${mobile['voucher']['label']['vouchers']}"]/following-sibling::XCUIElementTypeTextField
${voucher.complementary_voucher}                   xpath=//XCUIElementTypeOther[@name="complementary"]/XCUIElementTypeButton[@label="${mobile_additional['voucher']['label']['use_vouchers']}"]
${voucher.use_voucher}                             chain=**/XCUIElementTypeButton[`label == "${mobile_additional['voucher']['label']['use_vouchers']}"`]
${voucher.txt_code}                                xpath=//XCUIElementTypeStaticText[@name='{{code}}']
${voucher.productname_code_discount}               xpath=//XCUIElementTypeStaticText[@name='{{productname}}']/../following-sibling:: XCUIElementTypeOther//XCUIElementTypeStaticText[@name="{{code}} (-{{discount}} ฿)"]
${voucher.before_discount_baht}                    xpath=//XCUIElementTypeStaticText[@name='{{productname}}']/../../following-sibling::XCUIElementTypeOther//XCUIElementTypeStaticText[@name="{{beforediscount}} ฿"]
${voucher.after_discount}                          xpath=//XCUIElementTypeStaticText[@name='{{productname}}']/../../following-sibling::XCUIElementTypeOther//XCUIElementTypeStaticText[@name="฿{{afterdiscount}}"]
${voucher.before_discount}                         xpath=//XCUIElementTypeStaticText[@name='{{productname}}']/../../following-sibling::XCUIElementTypeOther/XCUIElementTypeStaticText[@name="฿{{beforediscount}}"]
${voucher.before_sale_price}                       xpath=//XCUIElementTypeStaticText[@name='${mobile_additional['voucher']['label']['hide_summary']}' or @label='${mobile_additional['voucher']['label']['show_summary']}' ]/../following-sibling::XCUIElementTypeOther//XCUIElementTypeStaticText[@name='฿{{beforediscount}}']
${voucher.after_sale_price}                        xpath=//XCUIElementTypeStaticText[@name='${mobile_additional['voucher']['label']['hide_summary']}' or @label='${mobile_additional['voucher']['label']['show_summary']}' ]/../following-sibling::XCUIElementTypeOther//XCUIElementTypeStaticText[@name='฿{{afterdiscount}}']
${voucher.error_for_reduction_code}                xpath=//XCUIElementTypeStaticText[@name='${mobile_additional['voucher']['label']['error_for_reduction_code']}']
${voucher.code_discount}                           xpath=//XCUIElementTypeOther[@name='application status']//XCUIElementTypeStaticText[@name='${mobile['voucher']['label']['vouchers']}']
${voucher.status_code}                             xpath=//XCUIElementTypeOther[@name='application status']//XCUIElementTypeStaticText[@name='{{code}}']
${voucher.conditions_not_met}                      xpath=//XCUIElementTypeOther[@name='application status']//XCUIElementTypeStaticText[@name='${mobile_additional['voucher']['message']['voucher_not_ready']}' or @name='${mobile_additional['voucher']['message']['conditions_not_met']}']
${voucher.btn_remove_voucher}                      xpath=//XCUIElementTypeOther[XCUIElementTypeStaticText[@name='${mobile_additional['voucher']['message']['voucher_not_ready']}' or @name='${mobile_additional['voucher']['message']['conditions_not_met']}']]/following-sibling::XCUIElementTypeButton[@name="${mobile_additional['voucher']['button']['removed_voucher']}"]
${voucher.error_message}                           chain=**/XCUIElementTypeOther[`name == "vocuher_form"`]/XCUIElementTypeStaticText[`label == "{{error_message}}"`]
${voucher.txt_code_voucher_badge}                  chain=**/XCUIElementTypeOther[`label == "{{code}}"`]
${voucher.txt_voucher}                             accessibility_id=vocuher_form
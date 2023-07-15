***Settings***
Variables       ../../localisation/mobile/${lang}.yaml
Variables       ../../localisation/mobile/${lang}_additional.yaml

*** Variables ***
${voucher.vocuher_input}                             xpath=//android.widget.EditText[@content-desc="vocuher_input"]
${voucher.icon_button}                               xpath=//android.view.ViewGroup[@content-desc="vocuher_form"]/android.view.ViewGroup[@content-desc="icon_button"]
${voucher.vocuher_apply_button}                      xpath=//android.view.ViewGroup[@content-desc="vocuher_apply_button"]/android.widget.TextView[@text='${mobile['global']['apply']}']
${voucher.txt_toast_success}                         xpath=//android.view.ViewGroup[@content-desc="toast_success"]/following-sibling::android.widget.TextView[@text='${mobile_additional['voucher']['message']['voucherApplied_b']}']
${voucher.txt_code_cannot_use}                       xpath=//android.widget.TextView[@text='${mobile['voucher']['message']['voucherNotApplied']}']
${voucher.txt_code_voucher_badge}                    xpath=//android.view.ViewGroup[@content-desc="basket_summary_section_voucher_badge"]//android.widget.TextView[@text='{{code}}']
${voucher.txt_discount}                              xpath=//android.view.ViewGroup[@content-desc="basket_summary_section_voucher_field"]/android.widget.TextView[@text='-{{discount}} ฿']
${voucher.basket_summary_section_voucher_badge}      xpath=//android.view.ViewGroup[@content-desc="basket_summary_section_voucher_badge"]
${voucher.basket_summary_section_voucher_badge_2}    xpath=//android.view.ViewGroup[@content-desc=“basket_summary_section_voucher_badge”]//android.view.ViewGroup[2]
${voucher.checkout_reduction_code}                   xpath=//android.widget.EditText[@resource-id='checkout_reduction_code']
${voucher.checkout_reduction_code_mobile}            xpath=//android.widget.EditText[@resource-id='checkout_reduction_code_mobile']
${voucher.btn_checkout_submit}                       xpath=//android.widget.Button[@resource-id='checkout_submit']
${voucher.btn_delete_voucher}                        xpath=//android.widget.TextView[@text='{{code}}']/following-sibling::android.view.ViewGroup
${voucher.productname_code_discount}                 xpath=//android.widget.TextView[@text='{{productname}}']/following-sibling::android.widget.ListView[android.view.View[@text='{{code}} (-{{discount}} ฿)']]
${voucher.before_discount_baht}                      xpath=//android.widget.TextView[@text='{{productname}}']/../following-sibling::android.view.View[android.view.View[@text='{{beforediscount}} ฿']]
${voucher.after_discount}                            xpath=//android.widget.TextView[@text='{{productname}}']/../following-sibling::android.view.View[android.widget.TextView[@text='฿{{afterdiscount}}']]
${voucher.before_discount}                           xpath=//android.view.View[@text='{{productname}}']/following-sibling::android.view.View[@text='฿{{beforediscount}}']
${voucher.sale_price}                                xpath=//android.widget.Button[@text="${mobile_additional['voucher']['message']['sale_price_1']}" or @text="${mobile_additional['voucher']['message']['sale_price_2']}"]
${voucher.error_for_reduction_code}                  xpath=//android.view.View[@resource-id='error-for-reduction_code' and @text='${mobile_additional['voucher']['label']['error_for_reduction_code']}']
${voucher.conditions_not_met}                        xpath=//android.view.View[@text='${mobile_additional['voucher']['message']['voucher_not_ready']}' or @text='${mobile_additional['voucher']['message']['conditions_not_met']}']
${voucher.btn_remove_voucher}                        xpath=//android.view.View[@text='${mobile_additional['voucher']['message']['voucher_not_ready']}' or @text='${mobile_additional['voucher']['message']['conditions_not_met']}']/following-sibling::android.widget.Button[@text='${mobile_additional['voucher']['button']['removed_voucher']}']
${voucher.btn_remove_discount}                       xpath=//android.widget.Button[@text='${mobile_additional['voucher']['button']['removed_voucher']}']
${voucher.error_message}                             xpath=//android.view.ViewGroup[@content-desc="vocuher_form"]/android.widget.TextView[@text="{{error_message}}"]
${voucher.txt_voucher}                               accessibility_id=vocuher_form
***Settings***
Variables       ../../localisation/mobile/${lang}.yaml
Variables       ../../localisation/mobile/${lang}_additional.yaml

*** Variables ***
${moremenu_page.title}                      xpath=//android.view.View[@text='${mobile['more']['title']}']
${moremenu_page.btn_logout}                 xpath=//android.widget.TextView[@text='${mobile['more']['button']['logout']}']
${moremenu_page.btn_confirm_logout}         xpath=//android.widget.TextView[@text='${mobile['more']['message']['logoutModalTitle']}']/following-sibling::android.view.ViewGroup/android.widget.TextView[@text='${mobile['more']['button']['logout']}']
${moremenu_page.txt_customer_service}       xpath=//android.widget.TextView[@text='${mobile_additional['contacts']['lbl_customer_service']}']
${moremenu_page.txt_my_account}             xpath=//android.widget.TextView[@text="${mobile_additional['more']['label']['my_account']}"]/parent::android.view.ViewGroup
${moremenu_page.txt_faq}                    xpath=//android.widget.TextView[@text='${mobile['more']['label']['FAQ']}']
${moremenu_page.txt_faq_header}             xpath=//android.widget.TextView[@content-desc="webview_heading" and @text='${mobile['more']['label']['FAQ']}']
${moremenu_page.txt_faq_viewgroup}          xpath=//android.widget.TextView[@text='${mobile['more']['label']['FAQ']}']/following-sibling::android.view.ViewGroup
${moremenu_page.txt_start_your_business}    xpath=//android.widget.TextView[@text='${mobile_additional['more']['start_your_business']}']
${moremenu_page.txt_become_a_seller}        xpath=//android.view.View[@text="${mobile_additional['more']['become_a_seller']}"]
${moremenu_page.txt_register_now}           xpath=//android.widget.Button[@text="${mobile_additional['more']['label']['register_now']}"]
${moremenu_page.talkToUs}                   xpath=//android.widget.TextView[@text='${mobile['more']['label']['talkToUs']}']
${moremenu_page.call_with_us}               xpath=//android.widget.TextView[@text='${mobile_additional['more']['call_with_us']}']
${moremenu_page.txt_privacy_settings}        xpath=//android.view.ViewGroup[android.widget.TextView[@text='${mobile_additional['more']['privacySettings']}']]
${moremenu_page.txt_tel_your_business}        xpath=//android.widget.TextView[@text='${mobile['more']['label']['tellYourBusiness']}']

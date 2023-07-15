***Settings***
Variables       ../../localisation/mobile/${lang}.yaml
Variables       ../../localisation/mobile/${lang}_additional.yaml

*** Variables ***
${moremenu_page.title}                      xpath=//XCUIElementTypeStaticText[@name="${mobile['more']['title']}"]
${moremenu_page.btn_logout}                 xpath=(//XCUIElementTypeOther[@name="${mobile['more']['button']['logout']}"])[last()]
${moremenu_page.btn_confirm_logout}         xpath=//XCUIElementTypeOther[contains(@name,"${mobile['more']['message']['logoutModalTitle']}")]//XCUIElementTypeOther[@name="${mobile['more']['button']['logout']}"]
${moremenu_page.logout_modal_title}         chain=**/XCUIElementTypeStaticText[`label == "${mobile['more']['message']['logoutModalTitle']}"`]
${moremenu_page.txt_cancel}                 chain=**/XCUIElementTypeOther[`label == "${mobile['global']['cancel']}"`]
${moremenu_page.txt_faq}                    chain=**/XCUIElementTypeOther[`label == "${mobile['more']['label']['FAQ']}"`]
${moremenu_page.call_with_us}               chain=**/XCUIElementTypeOther[`label == "${mobile_additional['more']['call_with_us']}"`]
${moremenu_page.txt_become_a_seller}        chain=**/XCUIElementTypeStaticText[`label == "${mobile_additional['more']['become_a_seller']}"`]
${moremenu_page.txt_register_now}           chain=**/XCUIElementTypeButton[`label == "${mobile_additional['more']['label']['register_now']}"`]
${moremenu_page.txt_my_account}             chain=**/XCUIElementTypeOther[`label == "${mobile_additional['more']['label']['my_account']}"`]
${moremenu_page.search_product}             xpath=(//XCUIElementTypeOther[@name="${mobile_additional['more']['label']['search_product']}"])[last()]
${moremenu_page.logout}                     xpath=(//XCUIElementTypeOther[@name="${mobile_additional['more']['label']['logout']}"])[last()]
${moremenu_page.txt_customer_service}       chain=**/XCUIElementTypeStaticText[`label == "${mobile_additional['contacts']['lbl_customer_service']}"`]
${moremenu_page.txt_privacy_settings}       chain=**/XCUIElementTypeOther[`label == "${mobile_additional['more']['privacySettings']}"`]
${moremenu_page.txt_tel_your_business}      chain=**/XCUIElementTypeOther[`label == "${mobile['more']['label']['tellYourBusiness']}"`]
${moremenu_page.txt_start_your_business}    chain=**/XCUIElementTypeOther[`label == "${mobile_additional['more']['start_your_business']}"`]
${moremenu_page.txt_faq_header}             xpath=//XCUIElementTypeStaticText[@name="${mobile['more']['label']['FAQ']}"]

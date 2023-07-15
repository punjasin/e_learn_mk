***Settings***
Variables       ../../localisation/mobile/${lang}.yaml
Variables       ../../localisation/mobile/${lang}_additional.yaml

*** Variables ***
${cookie.title}                     chain=**/XCUIElementTypeCell[`name =="${mobile_additional['text_banner']['cookies_banner']}"`]
${cookie.btn_accept_cookies}        chain=**/XCUIElementTypeButton[`label == "${mobile['global']['accept']}"`]
${cookie.btn_setting_cookies}       chain=**/XCUIElementTypeButton[`label == "${mobile_additional['text_banner']['settings']}"`]
${cookie.cookies_policy}            chain=**/XCUIElementTypeLink[`label == "${mobile_additional['text_banner']['cookie_policy']}"`]
${cookie.txt_cookies_consent}       chain=**/XCUIElementTypeTextView[`name=="${mobile_additional['cookie']['cookies_consent']} "`]
${cookie.close}                     chain=**/XCUIElementTypeOther[`label CONTAINS "${mobile_additional['cookie']['privacy_popup_on_web']}"`]/**/XCUIElementTypeButton[`label == "${mobile_additional['cookie']['close']}"`]
${cookie.privacy_accept_cookies}    chain=**/XCUIElementTypeOther[`label CONTAINS "${mobile_additional['cookie']['privacy_popup_on_web']}"`]/**/XCUIElementTypeButton[`label == "${mobile_additional['cookie']['accept_all_cookie']}"`]
${cookie.privacy}                   chain=**/XCUIElementTypeOther[`label CONTAINS "${mobile_additional['cookie']['privacy_popup_on_web']}"`]
${cookie.web_alert_dialog}          chain=**/XCUIElementTypeOther[`label CONTAINS "${mobile_additional['cookie']['web_alert_dialog']}"`]

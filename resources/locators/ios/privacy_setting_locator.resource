***Settings***
Variables       ../../localisation/mobile/${lang}.yaml
Variables       ../../localisation/mobile/${lang}_additional.yaml

*** Variables ***
${privacy.txt_privacy_consent_popup}             chain=**/XCUIElementTypeStaticText[`label == "${mobile['privacy']['privacyPolicy']}"`]
${privacy.btn_agree_privacy_consent_popup}       chain=**/XCUIElementTypeOther[`label == "${mobile['global']['ok']}"`]
${privacy.privacy_settings_screen_footer}        chain=**/XCUIElementTypeOther[`name == "privacy_settings_screen_footer"`]/**/XCUIElementTypeOther[`label == "${mobile_additional['privacy']['success']}"`]
${privacy.txt_privacy_settings}                  chain=**/XCUIElementTypeOther[`label == "${mobile['privacy']['privacySettings']}"`]
${privacy.settings}                              chain=**/XCUIElementTypeOther[`label == "${mobile['global']['settings']}"`]
${privacy.txt_consent}                           chain=**/XCUIElementTypeStaticText[`label == "${mobile_additional['privacy']['consent']}"`]
${privacy.txt_content_desc}                      xpath=//XCUIElementTypeStaticText[@name="{{content_name}}"]/following-sibling::XCUIElementTypeStaticText[@name="{{content_detail}}"]
${privacy.privacy_screen_in_on_state}            chain=**/XCUIElementTypeOther[`label CONTAINS "{{privacy_name}}" AND name CONTAINS "item_card"`]/**/XCUIElementTypeOther[`name CONTAINS "switcher"`]/XCUIElementTypeOther
${privacy.privacy_screen_in_off_state}           chain=**/XCUIElementTypeOther[`label CONTAINS "{{content_name}}" AND name CONTAINS "item_card"`]/**/XCUIElementTypeOther[`name CONTAINS "switcher"`]
${privacy.read_more}                             chain=**/XCUIElementTypeOther[`label CONTAINS "{{content_name}}" AND name CONTAINS "item_card"`]/**/XCUIElementTypeStaticText[`label == "${mobile['privacy']['readMore']}"`]
${privacy.not_receive_offers_If_not_accepted}    chain=**/XCUIElementTypeStaticText[`label == "${mobile['privacy']['consentWarningTitle']}"`]
${privacy.txt_not_accepted}                      chain=**/XCUIElementTypeOther[`label == "${mobile['privacy']['warningPopupConfrimTitle']}"`]
${privacy.txt_back}                              chain=**/XCUIElementTypeOther[`label == "${mobile['privacy']['warningPopupCancelTitle']}"`]
${privacy.see_details}                           chain=**/XCUIElementTypeOther[`label CONTAINS "${mobile['privacy']['personalDetailsDescription']}"`]/**/XCUIElementTypeOther[`label == "${mobile['global']['seeDetails']}" AND name == "item_card_footer_info_read_more_button"`]
${privacy.webview_content}                       chain=**/XCUIElementTypeOther[`name == "webview_content"`]
${privacy.content_name}                          chain=**/XCUIElementTypeStaticText[`label CONTAINS "{{content_name}}"`]
${privacy.content_detail}                        chain=**/XCUIElementTypeStaticText[`label == "{{content_detail}}"`]
${privacy.txt_get_deal}                          xpath=//XCUIElementTypeStaticText[@name="${mobile_additional['privacy']['get_deal']}"]
${privacy.switcher}                              chain=**/XCUIElementTypeOther[`name CONTAINS "switcher"`]
${privacy.txt_success}                           xpath=//XCUIElementTypeOther[@name='${mobile_additional['privacy']['success']}']
${privacy.switcher_in_on_state}                  chain=**/XCUIElementTypeOther[`label CONTAINS "{{privacy_name}}" AND name CONTAINS "item_card"`]/**/XCUIElementTypeOther[`name == "switcher_in_on_state"`]
${privacy.switcher_in_off_state}                 chain=**/XCUIElementTypeOther[`label CONTAINS "{{privacy_name}}" AND name CONTAINS "item_card"`]/**/XCUIElementTypeOther[`name == "switcher_in_off_state"`]

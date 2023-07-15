***Settings***
Variables       ../../localisation/mobile/${lang}.yaml
Variables       ../../localisation/mobile/${lang}_additional.yaml

*** Variables *** 
${debug.btn_clear_storage}            xpath=//XCUIElementTypeStaticText[@name="${mobile_additional['other_label']['clear_storage']}"]/following-sibling::XCUIElementTypeButton[@name="${mobile_additional['other_button']['clear_button_lower_case']}"]
${debug.btn_basket}                   xpath=//XCUIElementTypeButton[contains(@name,'${mobile['tab']['basket']}')]
${debug.build}                        xpath=//XCUIElementTypeOther[contains(@name,'${mobile_additional['debug']['build']}')]
${debug.iconIcon}                     xpath=//XCUIElementTypeOther[@name=""]
${debug.txt_build}                    xpath=//XCUIElementTypeStaticText[contains(@text,'${mobile_additional['debug']['build']}')]
${debug.clear_basket}                 xpath=//XCUIElementTypeStaticText[@name="${mobile_additional['debug']['clear_basket']}"]/following-sibling::XCUIElementTypeButton[@name="${mobile_additional['debug']['clear']}"]
${debug.clear_storage}                xpath=//XCUIElementTypeStaticText[@name="${mobile_additional['debug']['clear_storage']}"]/following-sibling::XCUIElementTypeButton[@name="${mobile_additional['debug']['clear']}"]
${debug.btn_ok}                       chain=**/XCUIElementTypeButton[`label == "${mobile_additional['debug']['ok']}"`]
${debug.btn_invalidate}               chain=**/XCUIElementTypeButton[`label == "${mobile_additional['debug']['invalidate']}"`]
${debug.warning_invalidate}           xpath=//XCUIElementTypeAlert[@name="Warning"]//XCUIElementTypeButton[@name="Invalidate"]
${debug.simulate_jailbreak}           xpath=//XCUIElementTypeOther[@name="Simulate jailbreak"]/.//XCUIElementTypeSwitch
${debug.for_your_safety}              chain=**/XCUIElementTypeOther[`label == "${mobile_additional['debug']['for_your_safety']}"`]
${debug.btn_confirm_clear}            xpath=//XCUIElementTypeAlert[@name="Are you sure?"]//XCUIElementTypeButton[@name="${mobile_additional['debug']['clear']}"]
${debug.prevent_screenshots}          xpath=//XCUIElementTypeOther[@name="${mobile_additional['debug']['prevent_screenshots']}"]/.//XCUIElementTypeSwitch
${debug.search_localization}          xpath=//XCUIElementTypeOther[@name="${mobile_additional['debug']['searchLocalization']}"]//XCUIElementTypeSwitch
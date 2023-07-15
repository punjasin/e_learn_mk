***Settings***
Variables       ../../localisation/mobile/${lang}.yaml
Variables       ../../localisation/mobile/${lang}_additional.yaml

*** Variables ***    
${debug.btn_clear_storage}            xpath=//android.widget.TextView[@text='${mobile_additional['other_label']['clear_storage']}']/following-sibling::android.widget.Button[1]
${debug.btn_confirm_clear_storage}    xpath=//android.widget.Button[@text='${mobile_additional['other_button']['clear_button']}']
${debug.btn_basket}                   xpath=//android.widget.Button/android.widget.TextView[@text='${mobile['tab']['basket']}']
${debug.txt_build}                    xpath=//android.widget.TextView[contains(@text,'${mobile_additional['debug']['build']}')]
${debug.iconIcon}                     xpath=//android.widget.TextView[@resource-id='iconIcon']
${debug.simulate_jailbreak}           xpath=//android.widget.TextView[@text='${mobile_additional['debug']['simulate_jailbreak']}']/following-sibling::android.widget.Switch[1]
${debug.txt_for_safe}                 xpath=//android.widget.TextView[@text="${mobile['global']['message']['securityAlert']}"]
${debug.txt_makro_pro_will_close}     xpath=//android.widget.TextView[@text="${mobile_additional['debug']['makro_pro_will_close']}"]
${debug.txt_invalidate}               xpath=//android.widget.Button/android.widget.TextView[@text="${mobile_additional['debug']['invalidate']}"]
${debug.btn_invalidate}               xpath=//android.widget.Button[@text="${mobile_additional['debug']['invalidate']}"]
${debug.switch_feature}               xpath=//android.widget.TextView[@text='{{feature}}']/following-sibling::android.widget.Switch[1]
${debug.clear_basket}                 xpath=(//android.widget.TextView[@text='${mobile_additional['debug']['clear_basket']}']/following-sibling::android.widget.Button/android.widget.TextView[@text="${mobile_additional['debug']['clear'].upper()}"])[1]
${debug.clear_storage}                xpath=(//android.widget.TextView[@text='${mobile_additional['debug']['clear_storage']}']/following-sibling::android.widget.Button/android.widget.TextView[@text="${mobile_additional['debug']['clear'].upper()}"])[1]
${debug.btn_confirm_clear}            xpath=//android.widget.Button[@text="${mobile_additional['debug']['clear'].upper()}"]
${debug.prevent_screenshots}          xpath=//android.widget.TextView[@text='${mobile_additional['debug']['prevent_screenshots']}']/following-sibling::android.widget.Switch[1]
${debug.search_localization}          xpath=//android.widget.TextView[@text='${mobile_additional['debug']['searchLocalization']}']/following-sibling::android.widget.Switch[1]
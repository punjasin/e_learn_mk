***Settings***
Variables       ../../localisation/mobile/${lang}.yaml
Variables       ../../localisation/mobile/${lang}_additional.yaml

*** Variables ***
${privacy.txt_privacy_consent_popup}             xpath=//android.widget.TextView[@text="${mobile['privacy']['privacyPolicy']}"]
${privacy.btn_agree_privacy_consent_popup}       xpath=//android.widget.TextView[@text="${mobile['privacy']['privacyPolicy']}"]/following-sibling::android.view.ViewGroup/android.widget.TextView[@text="${mobile['global']['okay']}"]
${privacy.txt_screen_footer_success}             xpath=//android.view.ViewGroup[@content-desc="privacy_settings_screen_footer"]//android.widget.TextView[@text='${mobile_additional['privacy']['success']}']
${privacy.txt_privacy_settings}                  xpath=//android.view.View[@text="${mobile['privacy']['privacySettings']}"]
${privacy.txt_setting}                           xpath=//android.widget.TextView[@text="${mobile_additional['privacy']['consent']}"]/following-sibling::android.view.ViewGroup/android.widget.TextView[@text="${mobile['global']['settings']}"]
${privacy.txt_consent}                           xpath=//android.widget.TextView[@text="${mobile_additional['privacy']['consent']}"]
${privacy.txt_update_consent_title}              xpath=//android.view.View[@text="${mobile['privacy']['updatePrivacyPolicy']}"]
${privacy.btn_confirm_update_consent}            xpath=//android.view.ViewGroup[@content-desc="privacy_settings_screen_footer"]//android.widget.TextView[@text="${mobile['global']['confirm']}"]/parent::android.view.ViewGroup
${privacy.txt_content_desc}                      xpath=//android.widget.TextView[@text='{{content_name}}']/following-sibling::android.widget.TextView[@text='{{content_desc}}']
${privacy.switcher_container}                    xpath=//android.widget.TextView[contains(@content-desc,"conteiner_title") and contains(@text,"{{privacy_name}}")]/parent::android.view.ViewGroup/following-sibling::android.view.ViewGroup[contains(@content-desc,"switcher_container")]
${privacy.switcher_viewgroup}                    xpath=//android.widget.TextView[contains(@content-desc,"conteiner_title") and contains(@text,"{{privacy_name}}")]/parent::android.view.ViewGroup/following-sibling::android.view.ViewGroup[contains(@content-desc,"switcher_container")]/android.view.ViewGroup
${privacy.switcher}                              xpath=//android.widget.TextView[contains(@text,"{{content_name}}")]/parent::android.view.ViewGroup/following-sibling::android.view.ViewGroup/android.view.ViewGroup[contains(@content-desc,"switcher")]
${privacy.privacy_screen_in_on_state}            xpath=//android.view.ViewGroup[@content-desc="privacy_item_screen_switcher_in_on_state"]
${privacy.privacy_screen_in_off_state}           xpath=//android.view.ViewGroup[@content-desc="privacy_item_screen_switcher_in_off_state"]
${privacy.privacy_item_screen_switcher}          xpath=//android.view.ViewGroup[contains(@content-desc,"privacy_item_screen_switcher")]
${privacy.read_more}                             xpath=//android.widget.TextView[contains(@text,'{{content_name}}')]/following-sibling::android.view.ViewGroup//android.widget.TextView[@text='${mobile['privacy']['readMore']}']
${privacy.content_name}                          xpath=//android.widget.TextView[contains(@text,'{{content_name}}')]
${privacy.content_detail}                        xpath=//android.widget.ScrollView//android.widget.TextView[@text='{{content_detail}}']
${privacy.txt_get_deal}                          xpath=//android.widget.TextView[@text='${mobile_additional['privacy']['get_deal']}']
${privacy.see_details}                           xpath=//android.widget.TextView[contains(@text,"${mobile_additional['privacy']['details']}")]/following-sibling::android.view.ViewGroup//android.widget.TextView[@text="${mobile['global']['seeDetails']}"]
${privacy.main_content}                          xpath=//android.view.View[@resource-id="MainContent"]//android.view.View[contains(@text,"${mobile_additional['privacy']['main_content']}")]
${privacy.not_receive_offers_If_not_accepted}    xpath=//android.widget.TextView[@text="${mobile['privacy']['consentWarningTitle']}"]
${privacy.txt_not_accepted}                      xpath=//android.widget.TextView[@text="${mobile['privacy']['warningPopupConfrimTitle']}"]
${privacy.txt_back}                              xpath=//android.widget.TextView[@text="${mobile['privacy']['warningPopupCancelTitle']}"]
${privacy.txt_title}                             xpath=//android.widget.TextView[contains(@text,"{{title}}")]
${privacy.txt_success}                           xpath=//android.view.ViewGroup/android.widget.TextView[@text='${mobile_additional['privacy']['success']}']
${privacy.switcher_in_on_state}                  xpath=//android.widget.TextView[contains(@text,"{{privacy_name}}")]/parent::android.view.ViewGroup/following-sibling::android.view.ViewGroup/android.view.ViewGroup[@content-desc="switcher_in_on_state"]
${privacy.switcher_in_off_state}                 xpath=//android.widget.TextView[contains(@text,"{{privacy_name}}")]/parent::android.view.ViewGroup/following-sibling::android.view.ViewGroup/android.view.ViewGroup[@content-desc="switcher_in_off_state"]

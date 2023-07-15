***Settings***
Variables       ../../localisation/mobile/${lang}.yaml
Variables       ../../localisation/mobile/${lang}_additional.yaml

*** Variables ***
${onboarding.txt_online_marketplace}      xpath=//android.widget.TextView[@text='${mobile['onboarding']['label']['titleSlide1']}']
${onboarding.splash_screen}               xpath=//android.widget.ImageView[@resource-id='com.makromangoapp.qa:id/lottie']
${onboarding.cvp_title}                   xpath=//android.widget.TextView[@text='${mobile['onboarding']['label']['titleSlide1']}']
${onboarding.btn_skip}                    xpath=//android.widget.TextView[@text='${mobile['onboarding']['button']['skip']}']
${onboarding.privacy_title}               xpath=//android.widget.TextView[@text='${mobile['privacy']['privacyPolicy']}']
${onboarding.privacy_content}             xpath=//android.widget.TextView[@text='${mobile['privacy']['aboutPrivacySettings']}']
${onboarding.btn_accept_cookie}           xpath=//android.widget.TextView[@text='${mobile_additional['button']['accept_all']}']
${onboarding.btn_start_shopping}          xpath=//android.widget.TextView[@text='${mobile['onboarding']['button']['goShopping']}']
${onboarding.txt_cvp_content}             xpath=//android.widget.TextView[@text='{{content}}']
${onboarding.txt_contains_cvp_content}    xpath=//android.widget.TextView[contains(@text,'{{content}}')]                                                                                          
${onboarding.txt_next}                    xpath=//android.widget.TextView[@text='${mobile['global']['next']}']
${onboarding.txt_back}                    xpath=//android.widget.TextView[@text='${mobile_additional['onboarding']['back']}']
${onboarding.txt_start}                   xpath=//android.widget.TextView[@text='${mobile_additional['onboarding']['start']}']
${onboarding.txt_start_order}             xpath=//android.widget.TextView[@text='${mobile['onboarding']['button']['goShopping']}']
${onboarding.txt_create_new_account}      xpath=//android.widget.TextView[@text='${mobile['onboarding']['button']['createAccount']}']
${onboarding.txt_privacy_policy}          xpath=//android.widget.TextView[@text='${mobile['privacy']['privacyPolicy']}']
${onboarding.txt_consent}                 xpath=//android.widget.TextView[@text='${mobile_additional['onboarding']['consent']}']
${onboarding.txt_all_accept}              xpath=//android.widget.TextView[@text='${mobile['global']['acceptAll']}']
${onboarding.txt_setting}                 xpath=//android.widget.TextView[@text='${mobile['global']['settings']}']
${onboarding.btn_next}                    xpath=//android.widget.Button[@text="${mobile['global']['next']}"]
${onboarding.input_contact_name}          xpath=//android.view.View[contains(@text,"${mobile['address']['label']['contactFirstName']}")]/parent::android.view.View/following-sibling::android.view.View/android.widget.EditText 
${onboarding.input_company_name}          xpath=//android.view.View[contains(@text,"${mobile['address']['label']['businessName']}")]/parent::android.view.View/following-sibling::android.view.View/android.widget.EditText
${onboarding.input_email}                 xpath=//android.view.View[contains(@text,"${mobile['global']['email']}")]/parent::android.view.View/following-sibling::android.view.View/android.widget.EditText
${onboarding.input_phone}                 xpath=//android.view.View[contains(@text,"${mobile['global']['phone']}")]/parent::android.view.View/following-sibling::android.view.View/android.widget.EditText
${onboarding.checkbox_true_category}      xpath=//android.widget.CheckBox[contains(@text,"{{category}}") and @checked="true"]
${onboarding.checkbox_false_category}     xpath=//android.widget.CheckBox[contains(@text,"{{category}}") and @checked="false"]
${onboarding.checkbox_category}           xpath=//android.widget.CheckBox[contains(@text,"{{category}}")]
${onboarding.btn_ok}                      xpath=//android.widget.Button[@text="${mobile['global']['ok']}"]
${onboarding.link}                        xpath=//android.view.View[@content-desc="{{link}}"]
${onboarding.txt_main_content_consent}    xpath=//android.view.View[@resource-id="MainContent"]//android.view.View[@text="${mobile['privacy']['privacyModalDesc']}"]

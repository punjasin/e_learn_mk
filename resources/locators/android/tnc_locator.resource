***Settings***
Variables       ../../localisation/mobile/${lang}.yaml
Variables       ../../localisation/mobile/${lang}_additional.yaml

*** Variables ***
${tnc_btn.accept_terms_and_condition}           xpath=//android.widget.TextView[@text="${mobile['global']['accept']}"]/parent::android.view.ViewGroup
${tnc_txt.terms_and_condition_title}            xpath=//android.widget.TextView[@text="${mobile['product']['message']['qualityAssurancePopupDesTermsLink']}"]
${tnc_btn.terms_and_condition_checkbox}         xpath=//android.widget.TextView[@text="${mobile['privacy']['termsAndConditionConsent']}"]
${tnc_btn.accept_update_terms_and_condition}    xpath=//android.widget.TextView[@text="${mobile['global']['accept']}"]/parent::android.view.ViewGroup[@enabled="true"]
${tnc_txt.update_terms_and_condition_title}     xpath=//android.view.View[@text="${mobile['privacy']['updateTerms']}"]
${tnc_txt.terms_and_condition_desc}             xpath=//android.widget.TextView[@text="${mobile_additional['message']['privacy_policy']}"]
${tnc_txt.digital_services}                     xpath=//android.widget.TextView[contains(normalize-space(@text),"${mobile_additional['tnc']['digital_services']}")]

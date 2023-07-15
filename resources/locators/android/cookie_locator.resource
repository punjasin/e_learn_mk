***Settings***
Variables       ../../localisation/mobile/${lang}.yaml
Variables       ../../localisation/mobile/${lang}_additional.yaml

*** Variables ***    
${cookie.title}                   xpath=//android.widget.TextView[@resource-id="com.makromangoapp.qa:id/cookie_policy_banner" and @text="${mobile_additional['text_banner']['cookie_policy']}"]
${cookie.btn_accept_cookies}      xpath=//android.widget.Button[@resource-id="com.makromangoapp.qa:id/btn_accept_cookies" and @text="${mobile['global']['accept']}"]
${cookie.btn_setting_cookies}     xpath=//android.widget.TextView[@resource-id="com.makromangoapp.qa:id/cookies_setting" and @text="${mobile_additional['text_banner']['settings']}"]
${cookie.txt_cookies_consent}     xpath=//android.widget.TextView[@resource-id="com.makromangoapp.qa:id/alert_notice_text" and @text="${mobile_additional['cookie']['cookies_consent']}"]
${cookie.btn_onetrust_close}      xpath=//android.view.View[@resource-id="onetrust-close-btn-container"]/android.widget.Button
${cookie.btn_onetrust_accept}     xpath=//android.widget.Button[@resource-id="onetrust-accept-btn-handler"]
${cookie.onetrust_consent_sdk}    xpath=//android.view.View[@resource-id="onetrust-consent-sdk"]

***Settings***
Variables       ../../localisation/web/${lang}.yaml
Variables       ../../localisation/web/${lang}_additional.yaml

*** Variables ***
${2c2p_portal.txt_otp_header}           xpath=//h3[contains(text(),"${web_additional['2c2p']['verifyOTPHeader']}")]
${2c2p_portal.txt_otp}                  xpath=//input[@name="challengeDataEntry"]
${2c2p_portal.image_2c2p}               xpath=//img[@alt="2C2P"]
${2c2p_portal.btn_confirm}              xpath=//button[@data-name="resendChallenge"]
${2c2p_portal.btn_submit}               xpath=//button[contains(text(),"${web_additional['2c2p']['submit']}")]
${2c2p_portal.btn_back_to_merchant}     xpath=//input[@value="${web_additional['2c2p']['backToMerchant']}"]
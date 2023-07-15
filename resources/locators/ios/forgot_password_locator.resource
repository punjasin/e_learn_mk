***Settings***
Variables       ../../localisation/mobile/${lang}.yaml
Variables       ../../localisation/mobile/${lang}_additional.yaml

*** Variables ***
${forgot_password.txt_main}      chain=**/XCUIElementTypeOther[`label == "main"`]/XCUIElementTypeTextField
${forgot_password.btn_sent}      chain=**/XCUIElementTypeButton[`label == "${mobile_additional['forgot_password']['sent']}"`]
${forgot_password.txt_cancel}    chain=**/XCUIElementTypeStaticText[`label == "${mobile['global']['cancel']}"`]
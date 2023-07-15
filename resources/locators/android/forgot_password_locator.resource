***Settings***
Variables       ../../localisation/mobile/${lang}.yaml
Variables       ../../localisation/mobile/${lang}_additional.yaml

*** Variables ***
${forgot_password.recoveremail_input}    xpath=//android.widget.EditText[@resource-id='RecoverEmail']
${forgot_password.btn_sent}              xpath=//android.widget.Button[@text='${mobile_additional['forgot_password']['sent']}']

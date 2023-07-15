***Settings***
Variables       ../../localisation/mobile/${lang}.yaml
Variables       ../../localisation/mobile/${lang}_additional.yaml

*** Variables ***
${myaddress.txt_my_address}     xpath=//android.widget.TextView[@text = "${mobile_additional['my_address']['my_address']}"]
${myaddress.add_new_address}    xpath=//android.widget.TextView[@text = "${mobile_additional['my_address']['add_new_address']}"]
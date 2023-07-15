***Settings***
Variables       ../../localisation/mobile/${lang}.yaml
Variables       ../../localisation/mobile/${lang}_additional.yaml

*** Variables ***
${order_success.order_success}          chain=**/XCUIElementTypeStaticText[`label == "${mobile['order']['label']['orderPlaced']}"`]
${order_success.prepare_and_deliver}    chain=**/XCUIElementTypeStaticText[`label == "${mobile['order']['message']['orderComplete']}"`]
${order_success.pay_within}             chain=**/XCUIElementTypeStaticText[`label == "${mobile_additional['order']['label']['orderCompleteBanking']}"`]
${order_success.txt_done}               chain=**/XCUIElementTypeOther[`label == "${mobile['global']['done']}"`]

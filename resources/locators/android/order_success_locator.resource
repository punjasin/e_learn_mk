***Settings***
Variables       ../../localisation/mobile/${lang}.yaml
Variables       ../../localisation/mobile/${lang}_additional.yaml

*** Variables ***
${order_success.order_success}          xpath=//android.widget.TextView[@text='${mobile['order']['label']['orderPlaced']}']
${order_success.prepare_and_deliver}    xpath=//android.widget.TextView[@text='${mobile['order']['message']['orderComplete']}']
${order_success.pay_within}             xpath=//android.widget.TextView[@text='${mobile_additional['order']['label']['orderCompleteBanking']}']
${order_success.txt_done}               xpath=//android.view.ViewGroup/android.widget.TextView[@text="${mobile['global']['done']}"]
${order_success.back_to_store}          xpath=//android.widget.Button[@text="${mobile_additional['order']['message']['back_to_store']}"]

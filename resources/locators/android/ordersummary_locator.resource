***Settings***
Variables       ../../localisation/mobile/${lang}.yaml
Variables       ../../localisation/mobile/${lang}_additional.yaml

*** Variables ***
${order_summary.btn_order_summary}        xpath=//android.widget.Button[contains(@text,'${mobile_additional['order']['label']['showOrderSummary']}')]
${order_summary.order_summary}            xpath=//android.view.View[@resource-id='order-summary']
${order_summary.txt_productname}          xpath=//android.view.View[@text='{{productname}}']
${order_summary.totalamount}              xpath=//android.view.View[contains(@text,'{{totalamount}}')]
${order_summary.btn_hid_order_summary}    xpath=//android.widget.Button[contains(@text,'${mobile_additional['order']['button']['hide_summary_order']}')]
${order_summary.order_summary_btn}        xpath=//android.view.View[@resource-id='order-summary']/android.view.View//android.widget.Button

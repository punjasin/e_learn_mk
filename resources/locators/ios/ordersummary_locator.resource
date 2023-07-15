***Settings***
Variables       ../../localisation/mobile/${lang}.yaml
Variables       ../../localisation/mobile/${lang}_additional.yaml

*** Variables ***
${order_summary.btn_order_summary}         chain=**/XCUIElementTypeOther[`label == "complementary"`]/**/XCUIElementTypeButton[`label CONTAINS "${mobile_additional['order']['label']['showOrderSummary']}"`]
${order_summary.btn_hide_order_summary}    chain=**/XCUIElementTypeOther[`label == "complementary"`]/**/XCUIElementTypeButton[`label CONTAINS "${mobile_additional['order']['button']['hide_summary_order']}"`]
${order_summary.txt_productname}           xpath=//XCUIElementTypeStaticText[@name="{{productname}}"]
${order_summary.totalamount}               chain=**/XCUIElementTypeOther[`label == "complementary"`]/**/XCUIElementTypeStaticText[`label == "฿{{totalamount}}"`]
${order_summary.complementary}             chain=**/XCUIElementTypeOther[`label == "complementary"`]
${order_summary.txt_hide_order_summary}    chain=**/XCUIElementTypeOther[`label == "complementary"`]/**/XCUIElementTypeStaticText[`label == "${mobile_additional['order']['button']['hide_summary_order']}"`]
${order_summary.remove_voucher}            chain=**/XCUIElementTypeOther[`label == "complementary"`]/**/XCUIElementTypeButton[`label == "${mobile_additional['order']['button']['remove_voucher']}"`]

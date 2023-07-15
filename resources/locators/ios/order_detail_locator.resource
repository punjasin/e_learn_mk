***Settings***
Variables       ../../localisation/mobile/${lang}.yaml
Variables       ../../localisation/mobile/${lang}_additional.yaml

*** Variables ***
${order_detail.txt_seller_name}                   chain=**/XCUIElementTypeOther[`name == "order"`]/**/XCUIElementTypeStaticText[`label == "${mobile['order']['label']['seller']}"`]
${order_detail.txt_product_name}                  chain=**/XCUIElementTypeOther[`name CONTAINS "basket_list_item"`]/**/XCUIElementTypeStaticText[`label == "{{product_name}}"`]
${order_detail.txt_payment_type}                  xpath=//XCUIElementTypeStaticText[contains(@name,'{{payment_type}}')]
${order_detail.txt_payment_status}                xpath=//XCUIElementTypeStaticText[contains(@name,"${mobile_additional['order']['label']['payment_status']}")]
${order_detail.txt_pay_within}                    xpath=//XCUIElementTypeStaticText[contains(@name,"${mobile['order']['label']['payBy']}")]
${order_detail.txt_pay_within_date}               xpath=//XCUIElementTypeStaticText[contains(@name,"${mobile_additional['order']['label']['pay_within_date']}")]
${order_detail.txt_pay_within_new_date}           xpath=//XCUIElementTypeStaticText[contains(@name,"${mobile_additional['order']['label']['pay_within_new_date']}")]
${order_detail.basket_list_item_gid}              xpath=(//XCUIElementTypeOther[contains(@name,'basket_list_item_gid')])[1]
${order_detail.txt_order_cancel}                  chain=**/XCUIElementTypeStaticText[`label == "${mobile['order']['label']['orderCancelled']}"`]
${order_detail.txt_payment_unsuccess}             chain=**/XCUIElementTypeStaticText[`label == "${mobile['order']['message']['unsuccessfulPayment']}"`]
${order_detail.txt_seller}                        xpath=//XCUIElementTypeStaticText[@name="{{status}}"]/following-sibling::XCUIElementTypeStaticText[@name="${mobile['order']['label']['seller']}"]
${order_detail.txt_order}                         xpath=//XCUIElementTypeStaticText[contains(@name,"${mobile_additional['order']['label']['order']}")]
${order_detail.txt_status}                        chain=**/XCUIElementTypeStaticText[`label == "{{status}}"`]
${order_detail.txt_status_timeline}               xpath=//XCUIElementTypeOther[@name="status_timeline"]/following-sibling::XCUIElementTypeOther//XCUIElementTypeStaticText[contains(@name,"{{status}}")]
${order_detail.txt_seller_order}                  xpath=//XCUIElementTypeOther[@name="order"]/parent::XCUIElementTypeOther[contains(@name,"${mobile['order']['label']['seller']}")]/preceding-sibling::XCUIElementTypeOther//XCUIElementTypeStaticText[contains(@name,"${mobile_additional['order']['label']['order']}")]
${order_detail.txt_seller_detail}                 xpath=//XCUIElementTypeOther[@name="order"]/parent::XCUIElementTypeOther[contains(@name,"${mobile['order']['label']['seller']}")]/preceding-sibling::XCUIElementTypeOther//XCUIElementTypeStaticText[@name="{{detail}}"]
${order_detail.contains_order}                    chain=**/XCUIElementTypeStaticText[`label CONTAINS "${mobile_additional['order']['label']['order']}"`]
${order_detail.txt_order_success}                 xpath=//XCUIElementTypeStaticText[@name="${mobile_additional['order']['message']['txt_order_success']}"]
${order_detail.txt_description_icon_button}       chain=**/XCUIElementTypeOther[`label == "${mobile['order']['label']['orderDetails']}"`]/**/XCUIElementTypeOther[`name == "icon_button"`]
${order_detail.txt_seller_list_product_cancel}    xpath=//XCUIElementTypeStaticText[@name="${mobile['order']['message']['productsCancelled']}"]/following-sibling::XCUIElementTypeStaticText[@name="${mobile['order']['label']['seller']}"]
${order_detail.txt_list_product_cancel}           xpath=//XCUIElementTypeStaticText[@name="${mobile['order']['message']['productsCancelled']}"]
${order_detail.txt_description}                   xpath=(//XCUIElementTypeOther[@name="${mobile['order']['label']['orderDetails']}"])[last()]
${order_detail.basket_list_item}                  xpath=(//XCUIElementTypeOther[contains(@name,"basket_list_item")]//XCUIElementTypeOther/XCUIElementTypeStaticText[1])[1]
${order_detail.txt_total_textview}                xpath=//XCUIElementTypeOther[@name="${mobile['order']['button']['addToBasket']}"]//following-sibling::XCUIElementTypeOther[contains(@name,"${mobile_additional['order']['label']['total_textview']}")]
${order_detail.txt_add_all_to_basket}             xpath=//XCUIElementTypeOther[@name="${mobile['order']['button']['addToBasket']}"]
${order_detail.status_timeline}                   chain=**/XCUIElementTypeOther[`name == "status_timeline"`]
${order_detail.txt_deliver}                       xpath=//XCUIElementTypeOther[@name="${mobile['order']['button']['trackDelivery']}"]
${order_detail.icon_button}                       xpath=(//XCUIElementTypeOther[@name="icon_button"])[1]/XCUIElementTypeOther
${order_detail.canceled}                          accessibility_id=${mobile['order']['label']['orderCancelled']}
${order_detail.order_number_cancel}               accessibility_id=${mobile['order']['label']['orderWithNumber']} ${mobile['order']['label']['cancelled']}
${order_detail.order_cancel_product}              accessibility_id=${mobile['order']['message']['productsCancelled']}
${order_detail.txt_basket_list_item}              //XCUIElementTypeOther[contains(@name,'basket_list_item')]
${order_detail.basket_list_item_textview_index}   xpath=(//XCUIElementTypeOther[contains(@name,'basket_list_item')])[{{i}}]//XCUIElementTypeOther[contains(@name,'฿')]//preceding-sibling::XCUIElementTypeStaticText//parent::XCUIElementTypeOther
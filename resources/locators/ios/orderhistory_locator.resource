***Settings***
Variables       ../../localisation/mobile/${lang}.yaml
Variables       ../../localisation/mobile/${lang}_additional.yaml

*** Variables ***
${orderhistory.title}                                       xpath=(//XCUIElementTypeOther[@name="${mobile['order']['title']}"])[last()]
${orderhistory.order_section}                               xpath=//XCUIElementTypeScrollView/XCUIElementTypeOther[contains(@name,"${mobile_additional['order']['label']['makroPro']}")]/XCUIElementTypeOther[contains(@name,"${mobile_additional['order']['label']['makroPro']}")]
${orderhistory.description}                                 chain=**/XCUIElementTypeOther[`label == "${mobile['order']['label']['orderDetails']}"`]
${orderhistory.txt_order_card_details}                      xpath=(//XCUIElementTypeStaticText[contains(@name,'order_card_details')])[1]
${orderhistory.order_no}                                    xpath=//XCUIElementTypeStaticText[contains(@value,"${mobile_additional['order']['label']['order_id']}")]
${orderhistory.time_expire}                                 xpath=//XCUIElementTypeStaticText[contains(@name,"{{time_expire}}")]
${orderhistory.time_offset}                                 xpath=//XCUIElementTypeStaticText[contains(@name,"{{time_offset}}")]
${orderhistory.time_offset2}                                xpath=//XCUIElementTypeStaticText[contains(@name,"{{time_offset2}}")]
${orderhistory.txt_pay_within}                              xpath=//XCUIElementTypeStaticText[contains(@name,"${mobile_additional['order']['label']['order_id']}")]/parent::XCUIElementTypeOther/following-sibling::XCUIElementTypeOther[contains(@name,"${mobile_additional['order']['label']['pay_within']}")]
${orderhistory.txt_order_no}                                xpath=//XCUIElementTypeStaticText[contains(@name,"${mobile_additional['order']['label']['order_id']}")]
${orderhistory.order_canceled}                              xpath=//XCUIElementTypeStaticText[@name="${mobile_additional['order']['label']['order_id']}"]/parent::XCUIElementTypeOther/following-sibling::XCUIElementTypeOther//XCUIElementTypeStaticText[@name="${mobile['order']['label']['orderCancelled']}"]
${orderhistory.order_card_status}                           xpath=//XCUIElementTypeOther[@name="order_card"]/XCUIElementTypeOther[contains(@name,"${mobile['order']['title']}")]/XCUIElementTypeStaticText[contains(@name,'order_card_details') and contains(@value,"${mobile_additional['order']['label']['order_id']}")]/parent::XCUIElementTypeOther/preceding-sibling::XCUIElementTypeOther[contains(@name,"{{seller_name}}")]/XCUIElementTypeStaticText[@name="order_card_status" and @value="{{order_status}}"]
${orderhistory.order_number}                                xpath=//XCUIElementTypeOther[@name="order_card"]/XCUIElementTypeOther[contains(@name,"{{seller_name}}")]/following-sibling::XCUIElementTypeOther[contains(@name,"คำสั่งซื้อ")]/XCUIElementTypeStaticText[contains(@name,'order_card_details') and contains(@value,"${mobile_additional['order']['label']['order_id']}")]
${orderhistory.total_seller}                                xpath=//XCUIElementTypeOther[@name="order_card"]/XCUIElementTypeOther[contains(@label,"${mobile_additional['order']['label']['total_seller']}")]/following-sibling::XCUIElementTypeOther[contains(@label,"${mobile_additional['order']['label']['order_id']}")]
${orderhistory.order_card_details}                          xpath=//XCUIElementTypeStaticText[@name="order_card_details" and contains(@value,"${mobile_additional['order']['label']['order_id']}")]
${orderhistory.txt_order_success}                           xpath=//XCUIElementTypeOther[@name="{{element_to_find}}"]/following-sibling::XCUIElementTypeOther[@name="${mobile_additional['order']['message']['txt_order_success']}"]
${orderhistory.order_cancel_by_seller}                      xpath=//XCUIElementTypeOther[@name="{{element_to_find}}"]/following-sibling::XCUIElementTypeOther[@name="${mobile['order']['label']['orderCancelledBySeller']}"]
${orderhistory.txt_order_number}                            xpath=(//XCUIElementTypeOther[contains(@name,"${mobile['order']['label']['orderWithNumber']}")])[last()]
${orderhistory.txt_unpaid}                                  xpath=//XCUIElementTypeOther[@name="${mobile_additional['order']['label']['order_tracking']}"]//following-sibling::XCUIElementTypeOther[@name="${mobile_additional['order_history']['unpaid']}"]
${orderhistory.txt_tracking_delivery}                       xpath=//XCUIElementTypeStaticText[@name="${mobile_additional['order']['label']['order_id']}"]/parent::XCUIElementTypeOther/following-sibling::XCUIElementTypeOther[@name="${mobile['order']['button']['trackDelivery']}"]
${orderhistory.txt_order_last}                              xpath=(//XCUIElementTypeOther[@name="${mobile['order']['title']}"])[last()]
${orderhistory.no_order_now}                                chain=**/XCUIElementTypeStaticText[`label == "${mobile['order']['message']['noOrders']}"`]
${orderhistory.txt_see_orders_when_orders}                  chain=**/XCUIElementTypeStaticText[`label == "${mobile['order']['message']['explanationNoOrders']}"`]
${orderhistory.txt_search_by_category}                      id=${mobile_additional['order']['label']['search_by_category']}
${orderhistory.txt_total_scrollview}                        xpath=//XCUIElementTypeOther[contains(@name,"${mobile['order']['label']['all']}")]/parent::XCUIElementTypeScrollView
${orderhistory.txt_total}                                   chain=**/XCUIElementTypeStaticText[`label == "${mobile['order']['label']['all']}"`]
${orderhistory.txt_total_typeother}                         xpath=//XCUIElementTypeStaticText[@name="${mobile['order']['label']['all']}"]/following-sibling::XCUIElementTypeOther
${orderhistory.txt_must_pay}                                chain=**/XCUIElementTypeStaticText[`label == "${mobile['order']['label']['unpaid']}"`]
${orderhistory.txt_must_pay_typeother}                      xpath=//XCUIElementTypeStaticText[@value="${mobile['order']['label']['unpaid']}"]/following-sibling::XCUIElementTypeOther
${orderhistory.txt_prepare}                                 chain=**/XCUIElementTypeStaticText[`label == "${mobile['order']['label']['beingPrepared']}"`]
${orderhistory.txt_prepare_typeother}                       xpath=//XCUIElementTypeStaticText[@value="${mobile['order']['label']['beingPrepared']}"]/following-sibling::XCUIElementTypeOther 
${orderhistory.txt_delivery}                                chain=**/XCUIElementTypeStaticText[`label == "${mobile['order']['label']['shipped']}"`]
${orderhistory.txt_delivery_typeother}                      xpath=//XCUIElementTypeStaticText[@value="${mobile['order']['label']['shipped']}"]/following-sibling::XCUIElementTypeOther
${orderhistory.txt_delivered_success}                       chain=**/XCUIElementTypeStaticText[`label == "${mobile['order']['label']['delivered']}"`]
${orderhistory.txt_delivered_success_typeother}             xpath=//XCUIElementTypeStaticText[@value="${mobile['order']['label']['delivered']}"]//following-sibling::XCUIElementTypeOther
${orderhistory.txt_canceled}                                chain=**/XCUIElementTypeStaticText[`label == "${mobile['order']['label']['orderCancelled']}"`]
${orderhistory.txt_canceled_typeother}                      xpath=//XCUIElementTypeStaticText[@value="${mobile['order']['label']['orderCancelled']}"]/following-sibling::XCUIElementTypeOther
${orderhistory.total_selected_underline}                    xpath=//XCUIElementTypeStaticText[@value="${mobile['order']['label']['all']}"]/following-sibling::XCUIElementTypeOther[@name="top_tab_bar_tab_selected_underline"]
${orderhistory.txt_must_pay_selected_underline}             xpath=//XCUIElementTypeStaticText[@value="${mobile['order']['label']['unpaid']}"]/following-sibling::XCUIElementTypeOther[@name="top_tab_bar_tab_selected_underline"]
${orderhistory.txt_prepare_selected_underline}              xpath=//XCUIElementTypeStaticText[@value="${mobile['order']['label']['beingPrepared']}"]/following-sibling::XCUIElementTypeOther[@name="top_tab_bar_tab_selected_underline"]
${orderhistory.txt_delivery_selected_underline}             xpath=//XCUIElementTypeStaticText[@value="${mobile['order']['label']['shipped']}"]/following-sibling::XCUIElementTypeOther[@name="top_tab_bar_tab_selected_underline"]
${orderhistory.txt_delivered_success_selected_underline}    xpath=//XCUIElementTypeStaticText[@value="${mobile['order']['label']['delivered']}"]/following-sibling::XCUIElementTypeOther[@name="top_tab_bar_tab_selected_underline"]
${orderhistory.txt_canceled_selected_underline}             xpath=//XCUIElementTypeStaticText[@value="${mobile['order']['label']['orderCancelled']}"]/following-sibling::XCUIElementTypeOther[@name="top_tab_bar_tab_selected_underline"]
${orderhistory.order}                                       chain=**/XCUIElementTypeOther[`label == "${mobile['order']['title']}"`]
${orderhistory.txt_cancel}                                  chain=**/XCUIElementTypeStaticText[`label == "${mobile['order']['label']['cancelled']}"`]
${orderhistory.txt_cancel_typeother}                        xpath=//XCUIElementTypeStaticText[@value="${mobile['order']['label']['cancelled']}"]/following-sibling::XCUIElementTypeOther 
${orderhistory.txt_tab_name}                                chain=**/XCUIElementTypeStaticText[`label == "{{tab_name}}"`]
${orderhistory.txt_cancel_order}                            xpath=(//XCUIElementTypeScrollView/XCUIElementTypeOther/XCUIElementTypeOther[contains(@name,"${mobile['order']['label']['orderWithNumber']}") and contains(@name,"${mobile['order']['label']['cancelled']}")])[last()]
${orderhistory.txt_refund_cencel}                           xpath=(//XCUIElementTypeOther[contains(@name,"${mobile['order']['label']['refunded']}") and contains(@name,"${mobile['order']['label']['cancelled']}")])[last()]
${orderhistory.side_bar}                                    xpath=//XCUIElementTypeOther[@name="top_tab_bar_scrollbar"]/XCUIElementTypeScrollView
${orderhistory.txt_order}                                   xpath=//XCUIElementTypeScrollView/XCUIElementTypeOther[contains(@name,"${mobile_additional['order']['label']['makroPro']}")]/XCUIElementTypeOther[contains(@name,"${mobile_additional['order']['label']['makroPro']}")]
${orderhistory.order_status}                                xpath=//XCUIElementTypeScrollView//XCUIElementTypeOther[contains(@name,"${mobile_additional['order']['label']['order_id']}") and contains(@name,"{{order_status}}")]
${orderhistory.orderhistory_page_not_login}                 xpath=//XCUIElementTypeStaticText[@name="${mobile['order']['message']['loginRequired']}"]
${orderhistory.login_account_btn}                           xpath=//XCUIElementTypeOther[@name="${mobile['account']['button']['login']}"]
${orderhistory.create_account_btn}                          xpath=//XCUIElementTypeOther[@name="${mobile['account']['button']['createAccount']}"]
${orderhistory.orderhistory_page_empty}                     accessibility_id=order_tab_empty_list_title
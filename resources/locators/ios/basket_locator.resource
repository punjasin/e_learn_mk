***Settings***
Variables       ../../localisation/mobile/${lang}.yaml
Variables       ../../localisation/mobile/${lang}_additional.yaml

*** Variables ***
${basket.txt_empty_basket}                  chain=**/XCUIElementTypeStaticText[`label == "${mobile['basket']['message']['noItems']}"`]
${basket.txt_popup_swipe_delete}            chain=**/XCUIElementTypeStaticText[`label == "${mobile['basket']['message']['deleteItemSwipeInfo']}"`]
${basket.btn_close_popup_swipe_delete}      xpath=//XCUIElementTypeStaticText[@name="${mobile['basket']['message']['deleteItemSwipeInfo']}"]/preceding-sibling::XCUIElementTypeOther
${basket.btn_checkout}                      chain=**/XCUIElementTypeOther[`label == "${mobile['basket']['button']['checkout']}"`]
${basket.txt_basket}                        xpath=//XCUIElementTypeButton[@name="${mobile['basket']['title']}"]
${basket.add_to_basket}                     chain=**/XCUIElementTypeOther[`label == "${mobile_additional['basket']['button']['addToBasket']}"`]
${basket.btn_basket}                        chain=**/XCUIElementTypeButton[`label == "${mobile_additional['basket']['label']['basket']}"`]
${basket.last_checkout}                     chain=**/XCUIElementTypeOther[`label == "${mobile['basket']['button']['checkout']}"`][last()]
${basket.totel_price}                       xpath=(//XCUIElementTypeOther[contains(@name,"${mobile['basket']['label']['total']}")])[2]
${basket.txt_product_list}                  chain=**/XCUIElementTypeOther[`name CONTAINS "basket_list_item" AND label CONTAINS "{{productname}}"`]
${basket.txt_basket_qty}                    xpath=(//XCUIElementTypeOther[contains(@name,"{{productname}}")]/following-sibling::XCUIElementTypeOther)[1]
${basket.sent_within}                       chain=**/XCUIElementTypeOther[`label == "${mobile_additional['basket']['message']['delivery']}"`]
${basket.txt_global_delete}                 xpath=//XCUIElementTypeOther[@name="${mobile['global']['delete']}" and @accessible ="true"]
${basket.add_to_basket_success}             chain=**/XCUIElementTypeStaticText[`label == "${mobile_additional['basket']['message']['itemsAddedToBasket']}"`]
${basket.product_name_list}                 xpath=//XCUIElementTypeStaticText[@name="{{product_name_list}}[{{i}}]"]
${basket.orignalprice}                      xpath=//XCUIElementTypeStaticText[@name="{{productname}}"]/following-sibling::XCUIElementTypeOther[@name="{{orignalprice}} ฿"]
${basket.discountprice_and_orignalprice}    xpath=//XCUIElementTypeStaticText[@name="{{productname}}"]/following-sibling::XCUIElementTypeOther[@name="{{discountprice}} ฿ {{orignalprice}} ฿"]
${basket.increment_btn_wrapper}             chain=**/XCUIElementTypeOther[`name CONTAINS "basket_list_item" AND label CONTAINS "{{productname}}"`]/XCUIElementTypeOther/XCUIElementTypeOther[`label CONTAINS "{{productname}}"`]/XCUIElementTypeOther[`not label CONTAINS "{{productname}}"`]
${basket.decrement_btn_wrapper}             chain=**/XCUIElementTypeOther[`name CONTAINS "basket_list_item" AND label CONTAINS "{{product}}"`]/**/XCUIElementTypeOther[`name == "decrement_btn_wrapper"`]
${basket.shipping_fee}                      xpath=//XCUIElementTypeOther[@name="${mobile['basket']['message']['deliveryFeeMessage']}"]
${basket.productname}                       xpath=//XCUIElementTypeStaticText[@name="{{productname}}"]
${basket.txt_product_qty_input}             xpath=//XCUIElementTypeOther[contains(@name,"basket_list_item") and contains(@label,"{{product}}")]//XCUIElementTypeOther[@name="increment_btn_wrapper"]/preceding-sibling::XCUIElementTypeOther[1]
${basket.success}                           xpath=//XCUIElementTypeOther[@name="${mobile['global']['done']}"]
${basket.txt_disable_checkout}              xpath=//XCUIElementTypeOther[@name="${mobile['basket']['button']['checkout']}" or @name="${mobile['basket']['button']['makePayment']}"]/XCUIElementTypeOther[@enabled='false']
${basket.txt_enable_checkout}               xpath=//XCUIElementTypeOther[@name="${mobile['basket']['button']['checkout']}" or @name="${mobile['basket']['button']['makePayment']}"]/XCUIElementTypeOther[@enabled='true']
${basket.product_remove_form_basket}        xpath=//XCUIElementTypeStaticText[@name="${mobile['basket']['message']['productRemoved']}"]

${basket.quantity_counter_container}                   xpath=//XCUIElementTypeOther[XCUIElementTypeStaticText[@name="{{productname}}"]]/following-sibling::XCUIElementTypeOther[@name="quantity_counter_container"]/XCUIElementTypeOther
${basket.delete}                                       chain=**/XCUIElementTypeOther[`label CONTAINS "{{productname}}"`]/**/XCUIElementTypeOther[`label == "${mobile['global']['delete']}"`]/XCUIElementTypeOther[`label == "${mobile['global']['delete']}"`]
${basket.basket_summary_section_shipping_fee_field}    chain=**/XCUIElementTypeOther[`name == "basket_summary_section_shipping_fee_field"`]/**/XCUIElementTypeStaticText[`label CONTAINS "฿"`]
${basket.basket_summary_section_discount_field}        chain=**/XCUIElementTypeOther[`name == "basket_summary_section_discount_field"`]/**/XCUIElementTypeStaticText[`label CONTAINS "฿"`]
${basket.basket_list}                                  chain=**/XCUIElementTypeOther[`name="basket_list"`]/XCUIElementTypeScrollView
${basket.basket_summary_section_total_field}           chain=**/XCUIElementTypeOther[`name == "basket_summary_section_total_field"`]
${basket_feature.contains_expected_price}              chain=**/XCUIElementTypeOther[`name == "basket_summary_section_total_field"`]/XCUIElementTypeOther[`label CONTAINS "${mobile['basket']['label']['total']}" AND label CONTAINS "{{expected_price}} ฿"`]
${basket.txt_badge_product}                            xpath=//XCUIElementTypeOther[contains(@name,"basket_list_item") and contains(@label,"{{badge_name}} {{product_name}}")]
${basket.txt_minimum_order_warning}                    xpath=//XCUIElementTypeStaticText[@label="${mobile['basket']['message']['minimumSpend']}"]
${basket.delivery_by_1P_brand_title}                   accessibility_id=${mobile['basket']['message']['deliveredBy']}
${basket.choose_delivery_date}                         accessibility_id=${mobile['basket']['message']['chooseDeliveryDate']}
${basket.info_tooltip_icon}                            xpath=//XCUIElementTypeOther[@name="basket_section"]/XCUIElementTypeOther[contains(@name,"${mobile['basket']['message']['deliveredBy']}")]/XCUIElementTypeOther[@name="shipment_info_icon_in_basket"]
${basket.delivery_handle_by_1P_brand_title}            xpath=//XCUIElementTypeStaticText[@name="${mobile['basket']['message']['deliveryHandledByBrandTitle']}"]
${basket.delivery_brand_description}                   xpath=//XCUIElementTypeStaticText[@name="${mobile['basket']['message']['deliveryHandledByBrandDescription']}"]
${basket.delivery_by_3P_brand_title}                   accessibility_id=${mobile['basket']['message']['soldBy']}
${basket.delivery_range_date}                          xpath=//XCUIElementTypeStaticText[@name="${mobile['basket']['message']['soldBy']}"]/following-sibling::XCUIElementTypeStaticText
${basket.info_3P_tooltip_icon}                         xpath=//XCUIElementTypeOther[@name="basket_section"]/XCUIElementTypeOther[contains(@name,"${mobile['basket']['message']['soldBy']}")]/XCUIElementTypeOther[@name="shipment_info_icon_in_basket"]
${basket.delivery_partner_title}                       xpath=//XCUIElementTypeStaticText[@name="${mobile['basket']['message']['deliveryHandledByPartnerTitle']}"]
${basket.txt_product_unit}                             xpath=//XCUIElementTypeOther[contains(@name,"basket_list_item")]/XCUIElementTypeOther[contains(@name,"{{productname}} {{unit}}")]
${basket.txt_discount_price}                           xpath=//XCUIElementTypeOther[contains(@name,"basket_list_item")]/XCUIElementTypeOther[contains(@name,"{{productname}}") and contains(@name,"{{discountprice}}")]
${basket.txt_productname_orignal_price}                xpath=//XCUIElementTypeOther[contains(@name,"basket_list_item")]/XCUIElementTypeOther[contains(@name,"{{productname}}") and contains(@name,"{{orignalprice}}")]
${basket.txt_product_discount_label}                   xpath=//XCUIElementTypeOther[@name="basket_summary_section_discount_field" and contains(@label,"${mobile['basket']['label']['discount']}")]
${basket.txt_product_discount}                         xpath=//XCUIElementTypeOther[@name="${mobile['basket']['label']['discount']}"]/following-sibling::XCUIElementTypeOther
${basket.btn_close_3P_tooltip}                         xpath=(//android.widget.TextView[@text='${mobile['basket']['message']['deliveryHandledByPartnerTitle']}']/parent::android.view.ViewGroup/parent::android.view.ViewGroup/android.view.ViewGroup)[1]
${basket.txt_subtotal}                                 xpath=//XCUIElementTypeOther[@name="basket_summary_section_subtotal_field" and contains(@label,"${mobile['basket']['label']['subtotal']} {{total}}")]
${basket.txt_total}                                    xpath=//XCUIElementTypeOther[@name="basket_summary_section_total_field" and contains(@label,"${mobile['basket']['label']['total']} {{total}}")]
${basket.txt_point_add_success}                    xpath=//XCUIElementTypeOther[@name="toast_success"]/following-sibling::XCUIElementTypeOther[@name='${mobile['points']['message']['pointsRedeeemed']}']
${basket.btn_makro_point_expand}                   xpath=//XCUIElementTypeOther[@name="points_form"]//XCUIElementTypeOther[@name="icon_button"]
${basket.txt_total_point}                          accessibility_id=${mobile['points']['label']['totalPoints']}
${basket.txt_pay_by_point}                         accessibility_id=${mobile['points']['label']['redeemPoints']}
${basket.arrow_point_symbol}                       xpath=//XCUIElementTypeOther[@name="points_form"]/XCUIElementTypeOther[contains(@name,"${mobile['points']['label']['redeemPoints']}")]/XCUIElementTypeOther[not(@name)]
${basket.btn_makro_point_confirm}                  accessibility_id=points_apply_button
${basket.txt_point_input}                          accessibility_id=points_input
${basket.txt_remove_point_for_use_coupon}          accessibility_id=${mobile['points']['label']['messageDiscount']}
${basket.txt_makro_pro_point}                      chain=**/XCUIElementTypeOther[`label == "${mobile['points']['label']['makroPoints']}"`]
${basket.txt_amount_thb_point}                     xpath=//XCUIElementTypeStaticText[@name="${mobile['points']['label']['redeemPoints']}"]/following-sibling::XCUIElementTypeStaticText[@name="-{{total_amount}} ฿"]
${basket.btn_delete_point}                         accessibility_id=points_delete_button
${basket.btn_close_icon_input}                     xpath=//XCUIElementTypeTextField[@name="points_input"]/parent::XCUIElementTypeOther/following-sibling::XCUIElementTypeOther
${basket.txt_point_amount_placeholder}             chain=**/XCUIElementTypeStaticText[`label == "${mobile['points']['input']['placeholder']}"`]
${basket.txt_point_delete_success}                 xpath=//XCUIElementTypeOther[@name="toast_warning"]/following-sibling::XCUIElementTypeOther[@name='${mobile['points']['message']['pointsRestored']}']
${basket.basket_list_item}                         xpath=//XCUIElementTypeOther[contains(@name,'basket_list_item')]
${basket.txt_basket_list_item}                     //XCUIElementTypeOther[contains(@name,'basket_list_item')]
${basket.basket_list_item_textview_index}          xpath=(//XCUIElementTypeOther[contains(@name,'basket_list_item')]/XCUIElementTypeOther)[{{i}}]/XCUIElementTypeOther[contains(@name,'฿')]/XCUIElementTypeOther
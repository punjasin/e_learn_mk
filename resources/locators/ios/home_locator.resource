***Settings***
Variables       ../../localisation/mobile/${lang}.yaml
Variables       ../../localisation/mobile/${lang}_additional.yaml

*** Variables ***
${navigation.btn_myorder}                            chain=**/XCUIElementTypeButton[`label == "${mobile['tab']['orders']}"`]
${navigation.btn_moremenu}                           xpath=//XCUIElementTypeButton[@name="${mobile['tab']['more']}"]
${navigation.btn_basket}                             xpath=//XCUIElementTypeButton[contains(@name,'${mobile['tab']['basket']}')]
${navigation.btn_shopping_cart}                      chain=**/XCUIElementTypeButton[`label == "${mobile['tab']['shopping']}"`]
${navigation.btn_favourite}                          chain=**/XCUIElementTypeButton[`label == "${mobile['tab']['favourites']}"`]
${homepage.zipcode_selector}                         chain=**/XCUIElementTypeOther[`name == "location-selector"`]
${homepage.zipcode_title}                            chain=**/XCUIElementTypeStaticText[`label == "${mobile['multistore']['label']['addZipCodeSubdistrictDialogTitle']}"`]
${homepage.zipcode_selector_scrollview}              chain=**/XCUIElementTypeOther[`name == "${mobile_additional['other_label']['subdristrict_selector']}"`]/XCUIElementTypeScrollView
${homepage.zipcode_input_container}                  chain=**/XCUIElementTypeTextField[`name == "${mobile_additional['other_textbox']['zipcode']}"`]
${homepage.zipcode_select_subdistrict}               chain=**/XCUIElementTypeOther[`name == "${mobile_additional['other_label']['subdristrict_selector']}"`]/**/XCUIElementTypeStaticText[`name == "${mobile_additional['other_label']['subdristict_banner']}" AND label == "{{subdistrict}}"`]                       
${homepage.zipcode_selected}                         chain=**/XCUIElementTypeOther[`name == "location-selector" AND label CONTAINS "{{zipcode}}"`]
${homepage.btn_save_zipcode}                         chain=**/XCUIElementTypeOther[`label == "${mobile['global']['save']}" AND name == "${mobile_additional['other_button']['save_zipcode']}"`]
${homepage.txt_add_zip_code_dialog_title}            chain=**/XCUIElementTypeStaticText[`label == "${mobile['multistore']['label']['addZipCodeDialogTitle']}"`]
${homepage.input_zipcode}                            chain=**/XCUIElementTypeTextField[`name == "input_zipcode"`]
${homepage.txt_title_your_zipcode}                   chain=**/XCUIElementTypeStaticText[`label == "{{title_your_zipcode}}"`]
${homepage.txt_zip_code_dialog_text}                 chain=**/XCUIElementTypeStaticText[`label == "${mobile['multistore']['label']['zipcodeDialogText']}"`]
${homepage.zipcode_subdistrict_dropdown}             chain=**/XCUIElementTypeOther[`name == "zipcode_subdistrict_dropdown"`]/XCUIElementTypeScrollView
${homepage.subdistrict_txt}                          xpath=//XCUIElementTypeOther[@name="zipcode_subdistrict_dropdown"]//XCUIElementTypeStaticText[@name="subdistrict_txt" and normalize-space(@label)="{{subdistrict}}"] 
${homepage.zipcode_save}                             chain=**/XCUIElementTypeOther[`label == "${mobile['global']['save']}" AND name == "zipcode-save"`]
${homepage.toast_success}                            chain=**/XCUIElementTypeOther[`label == "${mobile['multistore']['message']['zipcodeSaved']}"`]/XCUIElementTypeOther[`name == "toast_success"`]
${homepage.icon_button}                              chain=**/XCUIElementTypeOther[`name == "icon_button"`]/XCUIElementTypeOther/XCUIElementTypeOther/XCUIElementTypeOther
${homepage.txt_error}                                chain=**/XCUIElementTypeStaticText[`label == "{{error}}"`]
${homepage.btn_continue_on_out_of_delivery_area}     chain=**/XCUIElementTypeOther[`label == "${mobile_additional['home']['btn_continue_on_out_of_delivery_area']}"`]
${homepage.working_on_expanding_delivery_area}       chain=**/XCUIElementTypeStaticText[`label == "${mobile_additional['home']['working_on_expanding_delivery_area']}"`]
${homepage.out_fo_delivery_area}                     chain=**/XCUIElementTypeStaticText[`label == "${mobile['multistore']['outsideAreaModal']['description']}"`]
${homepage.btn_continue}                             accessibility_id=zipcode-save
${homepage.btn_update}                               chain=**/XCUIElementTypeOther[`label == "${mobile['multistore']['outsideAreaModal']['updateBtn']}"`]
${homepage.txt_we_are_unable_to_deliver}             chain=**/XCUIElementTypeOther[`label == "${mobile['multistore']['message']['weAreUnableToDeliver']}"`]
${homepage.btn_accept_terms_and_conditions}          chain=**/XCUIElementTypeOther[`label == "${mobile_additional['home']['btn_accept_terms_and_conditions']}" AND accessible  == ${true}`]
${homepage.fresh_list_container}                     chain=**/XCUIElementTypeOther[`name == "fresh_list_container"`]
${homepage.txt_see_all}                              xpath=//XCUIElementTypeStaticText[@name="promotion_list_title" and contains(@label,"{{category_name}}")]/following-sibling::XCUIElementTypeOther[@name="${mobile_additional['home']['see_all']}"]
${homepage.fresh_list_container_product_item_gid}    chain=**/XCUIElementTypeOther[`name == "fresh_list_container"`]/**/XCUIElementTypeOther[`name CONTAINS "product_item_gid"`]/**/XCUIElementTypeStaticText[`label == "${mobile['product']}"`]
${homepage.fresh_list_container_imageview}           chain=**/XCUIElementTypeOther[`name == "fresh_list_container"`]/**/XCUIElementTypeScrollView
${homepage.product_item_gid_product}                 chain=**/XCUIElementTypeOther[`name CONTAINS "product_item_gid"`]/**/XCUIElementTypeStaticText[`label == "{{product}}"`]
${homepage.txt_category_name}                        xpath=//XCUIElementTypeStaticText[@name="promotion_list_title" and contains(@label,"{{category_name}}")]
${homepage.txt_total_point}                          xpath=//XCUIElementTypeOther[@label='${mobile['home']['label']['viewProPoints']} {{total_point}}' and @accessible='true']
${homepage.txt_zipcode_outside_area}                 accessibility_id=input_numeric_error_message_${mobile['multistore']['message']['outsideAreaErrorInput']}
${homepage.select_mmid}                              xpath=//XCUIElementTypeOther[@name="${mobile['global']['select']}"]
${homepage.first_recent}                             xpath=//XCUIElementTypeStaticText[@name="${mobile['order']['label']['recentOrders']}"]//parent::XCUIElementTypeOther//following-sibling::XCUIElementTypeOther//XCUIElementTypeOther[contains(@name,'${mobile_additional['order']['label']['order']}')]
${homepage.txt_all_subdistrict}                      xpath=//XCUIElementTypeOther[@name="zipcode_subdistrict_dropdown"]//XCUIElementTypeStaticText[@name="subdistrict_txt"]
${homepage.first_product}                            xpath=//XCUIElementTypeStaticText[normalize-space(@value)="{{target_category}}" and @name="promotion_list_title"]//parent::XCUIElementTypeOther//following-sibling::XCUIElementTypeOther//XCUIElementTypeScrollView/XCUIElementTypeOther/XCUIElementTypeOther

***Settings***
Variables       ../../localisation/mobile/${lang}.yaml
Variables       ../../localisation/mobile/${lang}_additional.yaml

*** Variables ***
${navigation.btn_myorder}                            xpath=//android.widget.Button/android.widget.TextView[@text='${mobile['tab']['orders']}']
${navigation.btn_moremenu}                           xpath=//android.widget.Button/android.widget.TextView[@text='${mobile['tab']['more']}']
${navigation.btn_basket}                             xpath=//android.widget.Button/android.widget.TextView[@text='${mobile['tab']['basket']}']
${navigation.btn_shopping_cart}                      xpath=//android.widget.Button/android.widget.TextView[@text='${mobile['tab']['shopping']}']
${navigation.btn_favourite}                          xpath=//android.widget.Button/android.widget.TextView[@text='${mobile['tab']['favourites']}']
${homepage.txt_zipcode_selector}                     xpath=//android.widget.TextView[@content-desc="${mobile_additional['other_label']['zipcode_selector']}"]
${homepage.zipcode_title}                            xpath=//android.widget.TextView[@text="${mobile['multistore']['label']['addZipCodeSubdistrictDialogTitle']}"]
${homepage.zipcode_selector_scrollview}              xpath=//android.widget.ScrollView[@content-desc="${mobile_additional['other_label']['subdristrict_selector']}"]
${homepage.zipcode_input_container}                  xpath=//android.widget.EditText[@content-desc="${mobile_additional['other_textbox']['zipcode']}"]
${homepage.zipcode_select_subdistrict}               xpath=//android.widget.ScrollView[@content-desc="${mobile_additional['other_label']['subdristrict_selector']}"]//android.widget.TextView[@content-desc="${mobile_additional['other_label']['subdristict_banner']}" and @text="{{subdistrict}}"]
${homepage.zipcode_selected}                         xpath=//android.widget.TextView[@text="${mobile['home']['label']['deliveryTo']}"]/following-sibling::android.widget.TextView[contains(@text,"{{zipcode}}")]
${homepage.btn_save_zipcode}                         xpath=//android.view.ViewGroup[@content-desc="${mobile_additional['other_button']['save_zipcode']}" and @enabled="true"]
${homepage.txt_add_zip_code_dialog_title}            xpath=//android.widget.TextView[@text="${mobile['multistore']['label']['addZipCodeDialogTitle']}"]
${homepage.add_zip_code_dialog_subtitle}             xpath=//android.widget.TextView[@text="${mobile['multistore']['label']['addZipCodeDialogSubtitle']}"]
${homepage.input_zipcode}                            accessibility_id=input_zipcode
${homepage.txt_title_your_zipcode}                   xpath=//android.widget.TextView[@text="{{title_your_zipcode}}"]
${homepage.txt_zip_code_dialog_text}                 xpath=//android.widget.TextView[@text="${mobile['multistore']['label']['zipcodeDialogText']}"]
${homepage.zipcode_subdistrict_dropdown}             xpath=//android.widget.ScrollView[@content-desc="zipcode_subdistrict_dropdown"]
${homepage.subdistrict_txt}                          xpath=//android.widget.TextView[@content-desc="subdistrict_txt" and contains(@text,"{{subdistrict}}")]
${homepage.zipcode_save}                             xpath=//android.view.ViewGroup[@content-desc="zipcode-save" and @enabled="true"]
${homepage.toast_success}                            xpath=//android.widget.TextView[@text="${mobile['multistore']['message']['zipcodeSaved']}"]/preceding-sibling::android.view.ViewGroup[@content-desc="toast_success"]
${homepage.icon_button}                              xpath=//android.view.ViewGroup[@content-desc="icon_button"]
${homepage.txt_error}                                xpath=//android.widget.TextView[@text="{{error}}"]
${homepage.btn_continue_on_out_of_delivery_area}     xpath=//android.view.ViewGroup[@content-desc="zipcode-save"]/android.widget.TextView[@text ="${mobile_additional['home']['btn_continue_on_out_of_delivery_area']}"]
${homepage.working_on_expanding_delivery_area}       xpath=//android.widget.TextView[@text="${mobile_additional['home']['working_on_expanding_delivery_area']}"]
${homepage.out_fo_delivery_area}                     xpath=//android.widget.TextView[@text="${mobile['multistore']['outsideAreaModal']['description']}"]
${homepage.btn_continue}                             accessibility_id=zipcode-save
${homepage.btn_update}                               xpath=//android.widget.TextView[@text="${mobile['multistore']['outsideAreaModal']['updateBtn']}"]
${homepage.txt_we_are_unable_to_deliver}             xpath=//android.widget.TextView[@text="${mobile['multistore']['message']['weAreUnableToDeliver']}"]
${homepage.btn_accept_terms_and_conditions}          xpath=//android.view.ViewGroup[android.widget.TextView[@text="${mobile_additional['home']['btn_accept_terms_and_conditions']}"]]
${homepage.txt_category_name}                        xpath=//android.widget.TextView[@content-desc="promotion_list_title" and contains(@text,"{{category_name}}")] 
${homepage.txt_see_all}                              xpath=(//android.widget.TextView[@content-desc="promotion_list_title" and contains(@text,"{{category_name}}")]/following-sibling::android.view.ViewGroup/android.widget.TextView[@text="${mobile['fresh']['button']['seeAll']}"])[1]
${homepage.fresh_list_container_product_item_gid}    xpath=//android.view.ViewGroup[@content-desc="fresh_list_container"]//android.widget.HorizontalScrollView//android.view.ViewGroup[contains(@content-desc,"product_item_gid")]/android.widget.TextView[@text="{{product}}"]
${homepage.fresh_list_container_imageview}           xpath=//android.view.ViewGroup[@content-desc="fresh_list_container"]//android.widget.HorizontalScrollView//android.widget.ImageView
${homepage.product_item_gid}                         xpath=//android.view.ViewGroup[contains(@content-desc,"product_item_gid")]/android.widget.TextView[@text='{{product}}']
${homepage.location_selector_zipcode}                xpath=//android.widget.TextView[@content-desc="location-selector-zipcode"]
${homepage.txt_makropoint_title}                     xpath=//android.widget.TextView[@text="${mobile['loyalty']['intro']['header']}"]
${homepage.btn_create_makrocard}                     xpath=//android.view.ViewGroup/android.widget.TextView[@text="${mobile['loyalty']['intro']['generate_membership_card']}"]
${homepage.btn_confirm_create_card}                  xpath=//android.view.ViewGroup/android.widget.TextView[@text="${mobile['global']['yesAndConfirm']}"]
${homepage.member_card_container}                    xpath=//android.view.ViewGroup[@content-desc="member_card_generating_template_container"]
${homepage.txt_total_point}                          xpath=//android.widget.TextView[@text="${mobile['home']['label']['viewProPoints']}"]/following-sibling::android.widget.TextView[@text="{{total_point}}"]
${homepage.promotion_group}                          accessibility_id=promotion_list_container
${homepage.btn_add_promo_first_item}                 xpath=(//android.view.ViewGroup[@content-desc="promotion_list_container"]//android.view.ViewGroup[@content-desc="icon_button"])[1]
${homepage.btn_trash}                                accessibility_id=trash_btn_icon
${homepage.txt_toast_remove_product}                 xpath=//android.widget.TextView[@text='${mobile['basket']['message']['productRemoved']}']
${homepage.txt_first_product_promotion_item}         xpath=(//android.view.ViewGroup[@content-desc="promotion_list_container"]//android.widget.TextView[@content-desc="list_item_title"])[1]
${homepage.txt_product_name}                         xpath=//android.widget.TextView[@text="{{productname}}"]
${homepage.txt_zipcode_outside_area}                 accessibility_id=input_numeric_error_message_${mobile['multistore']['message']['outsideAreaErrorInput']}
${homepage.banner}                                   xpath=//android.view.ViewGroup[@content-desc="content_carousel_item_active_{{bannername}}"]
${homepage.youtubePage}                              xpath=//android.view.View[@content-desc="YouTube"]
${homepage.infoPage}                                 xpath=//android.view.View[@resource-id="onetrust-consent-sdk"]
${homepage.collectionPage}                           xpath=//android.widget.TextView[@content-desc="list_item_title"]
${homepage.bannerPDP}                                xpath=//android.widget.TextView[@text="${mobile_additional['banner']['bannerNescafe']}"]
${homepage.select_mmid}                              xpath=//android.view.ViewGroup[@content-desc="link_account_toast_container"]//android.widget.TextView[@text="${mobile['global']['select']}"]
${homepage.section_banner}                           xpath=//android.widget.ScrollView/android.view.ViewGroup/android.view.ViewGroup/android.widget.HorizontalScrollView[1]
${homepage.section_recent_order}                     xpath=//android.widget.ScrollView/android.view.ViewGroup/android.view.ViewGroup/android.widget.HorizontalScrollView[2]
${homepage.section_collections}                      xpath=//android.widget.TextView[@content-desc="promotion_list_title"]
${homepage.section_image}                            xpath=//android.widget.ScrollView/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup//android.widget.ImageView
${homepage.section_recent_order_item}                xpath=//android.widget.ScrollView/android.view.ViewGroup/android.view.ViewGroup/android.widget.HorizontalScrollView[2]/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup
${homepage.txt_recent_order_item}                    xpath=//android.widget.ScrollView/android.view.ViewGroup/android.view.ViewGroup/android.widget.HorizontalScrollView[2]/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup[{{index}}]//android.widget.TextView
${homepage.txt_see_all_recent_order}                 xpath=//android.widget.ScrollView/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup/android.widget.TextView[@text="${mobile['global']['seeAll']}"]
${homepage.first_recent}                             xpath=//android.widget.TextView[@text="${mobile['order']['label']['recentOrders']}"]//following-sibling::android.widget.HorizontalScrollView//android.widget.TextView[contains(@text,"${mobile_additional['order']['label']['order']}")]
${homepage.txt_all_subdistrict}                      xpath=//android.view.ViewGroup[@content-desc="subdistrict_column"]/android.view.ViewGroup[@content-desc="subdistrict_row"]/android.widget.TextView
${homepage.first_product}                            xpath=//android.widget.TextView[normalize-space(@text)="{{target_category}}" and @content-desc="promotion_list_title"]//following-sibling::android.widget.HorizontalScrollView//android.widget.TextView[@content-desc="list_item_title"]

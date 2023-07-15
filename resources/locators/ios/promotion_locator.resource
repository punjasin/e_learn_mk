***Settings***
Variables       ../../localisation/mobile/${lang}.yaml
Variables       ../../localisation/mobile/${lang}_additional.yaml

*** Variables ***
${promotion.icon_button}                 chain=**/XCUIElementTypeOther[`name=="promotion_list_container"`]/**/XCUIElementTypeOther[`name == "icon_button"`]
${promotion.fresh_list_container}        chain=**/XCUIElementTypeOther[`name=="fresh_list_container"`]
${promotion.latest_promotion}            chain=**/XCUIElementTypeStaticText[`label == "${mobile['promotions']['label']['title']}"`]
${promotion.promotion_typeother}         //XCUIElementTypeOther[@name="promotion_list_container"]//XCUIElementTypeScrollView/XCUIElementTypeOther/XCUIElementTypeOther
${promotion.promotion_scrollview}        chain=**/XCUIElementTypeOther[`name=="promotion_list_container"`]/**/XCUIElementTypeScrollView
${promotion.product_item_gid}            xpath=(//XCUIElementTypeOther[normalize-space(@name)='${mobile_additional['promotions']['label']['latest_promotion']}']/following-sibling::XCUIElementTypeOther//XCUIElementTypeScrollView/XCUIElementTypeOther/XCUIElementTypeOther)[{{sequent}}]
${promotion.add_to_cart_gid}             chain=**/XCUIElementTypeOther[`name == "promotion_list_container"`]/**/XCUIElementTypeOther[`name CONTAINS "product_item_gid" AND label CONTAINS "{{productname}}"`]/XCUIElementTypeOther[`name CONTAINS "qty_counter_gid"`]/XCUIElementTypeOther[`name CONTAINS "add_to_cart_gid"`]
${promotion.promotion_list_container}    xpath=//XCUIElementTypeOther[@name="promotion_list_container"]
${promotion.view_all}                    chain=**/XCUIElementTypeOther[`name == "promotion_list_container"`]/**/XCUIElementTypeOther[`label == "${mobile['promotions']['button']['seeAll']}"`]
${promotion.txt_latest_promotion}        xpath=//XCUIElementTypeStaticText[normalize-space(@name)="${mobile_additional['promotions']['label']['latest_promotion_only']}"]
${promotion.search_cancel}               xpath=//XCUIElementTypeOther[@name="${mobile_additional['promotions']['label']['search_product']} ${mobile['global']['cancel']}"]/XCUIElementTypeOther[@accessible='true']
${promotion.product_item_gid_1}          xpath=(//XCUIElementTypeOther[contains(@name,"product_item_gid:")])
${promotion.product_item_gid_2}          xpath=(//XCUIElementTypeOther[contains(@name,"product_item_gid:")])[{{position}}]//XCUIElementTypeStaticText[2]
${promotion.latest_promotion_productname}    xpath=//XCUIElementTypeStaticText[@name="list_item_title" and @value="{{productname}}"]
${promotion.promotion_list}                  xpath=(//XCUIElementTypeOther[normalize-space(@name)='${mobile_additional['promotions']['label']['latest_promotion']}']/following-sibling::XCUIElementTypeOther
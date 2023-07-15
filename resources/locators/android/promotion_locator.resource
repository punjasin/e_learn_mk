***Settings***
Variables       ../../localisation/mobile/${lang}.yaml
Variables       ../../localisation/mobile/${lang}_additional.yaml

*** Variables ***
${promotion.promotion_list_container}        xpath=//android.view.ViewGroup[@content-desc="promotion_list_container"]
${promotion.fresh_list_container}            xpath=//android.view.ViewGroup[@content-desc="fresh_list_container"]
${promotion.ourassortment}                   xpath=//android.widget.TextView[@text="${mobile['global']['ourAssortment']}"]
${promotion.promotion_list_title}            xpath=//android.widget.TextView[@content-desc="promotion_list_title"]
${promotion.latest_promotion}                xpath=//android.widget.TextView[@text='${mobile['promotions']['label']['title']}']/following-sibling::android.widget.HorizontalScrollView//android.widget.ImageView
${promotion.add_to_cart_gid}                 xpath=//android.view.ViewGroup[contains(@content-desc,"product_item_gid")]/android.widget.TextView[@text='{{product}}']/following-sibling::android.view.ViewGroup[contains(@content-desc,"qty_counter_gid")]/android.view.ViewGroup[contains(@content-desc,"add_to_cart_gid")]
${promotion.latest_promotion_productname}    xpath=//android.widget.TextView[@content-desc="list_item_title" and @text='{{productname}}']
${promotion.icon_button}                     xpath=//android.widget.TextView[@text='{{productname}}']/following-sibling::android.view.ViewGroup//android.view.ViewGroup[@content-desc="icon_button"]
${promotion.view_all}                        xpath=//android.view.ViewGroup[@content-desc="promotion_list_container"]//android.widget.TextView[@text='${mobile['promotions']['button']['seeAll']}']
${promotion.txt_latest_promotion}            xpath=//android.widget.TextView[normalize-space(@text)='${mobile_additional['promotions']['label']['latest_promotion_only']}']
${promotion.searchinput}                     xpath=//android.widget.EditText[@resource-id='searchInput']/ancestor::android.view.ViewGroup/preceding-sibling::android.view.ViewGroup/android.view.ViewGroup
${promotion.product_item_gid_1}              xpath=(//android.view.ViewGroup[contains(@content-desc,"product_item_gid:")])[{{position}}]/android.widget.TextView[1]
${promotion.product_item_gid_2}              xpath=(//android.view.ViewGroup[contains(@content-desc,"product_item_gid:")])[{{position}}]/android.widget.TextView[2]
${promotion.product_item_gid}                xpath=(//android.view.ViewGroup[contains(@content-desc,"product_item_gid:")])[{{sequent}}]
${promotion.promotion_list}                  xpath=//android.view.ViewGroup[@content-desc="promotion_list_container"]/android.widget.HorizontalScrollView
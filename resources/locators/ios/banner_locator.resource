***Settings***
Variables       ../../localisation/mobile/${lang}.yaml
Variables       ../../localisation/mobile/${lang}_additional.yaml

*** Variables ***
${banner.promotion_list_container}                 xpath=//XCUIElementTypeOther[@name="promotion_list_container"]/preceding-sibling::XCUIElementTypeOther/XCUIElementTypeOther/XCUIElementTypeOther[2]/XCUIElementTypeOther
${banner.txt_contains_bannername}                  xpath=//XCUIElementTypeOther[contains(@name,"content_carousel_item_active_{{bannername}}")]
${banner.content_carousel_item}                    xpath=//XCUIElementTypeOther[contains(@name,"content_carousel_item")]
${banner.content_carousel_item_active}             xpath=//XCUIElementTypeOther[@name="content_carousel_item_active_{{bannername}}"]
${banner.contains_content_carousel_item_active}    xpath=//XCUIElementTypeOther[contains(@name,"content_carousel_item_active_")]
${banner.btn_shopping}                             xpath=//XCUIElementTypeButton[@name="${mobile['tab']['shopping']}"]
${banner.main_category_dry_food}                   xpath=//XCUIElementTypeOther[@label='${mobile_additional['main_category']['dry food']}']
${banner.txt_searchinput}                          chain=**/XCUIElementTypeTextField[`name == "searchInput"`]
${banner.statictext_main_category}                 xpath=//XCUIElementTypeStaticText[contains(@name,'{{main_category}}')]
${banner.txt_sub_category}                         xpath=//XCUIElementTypeOther[contains(@name,'{{sub_category}}')]
${banner.statictext_sub_category}                  xpath=//XCUIElementTypeStaticText[contains(@name,'{{sub_category}}')]
${banner.product_item_gid}                         xpath=(//XCUIElementTypeOther[contains(@name,"product_item_gid:")])
${banner.statictext_product}                       xpath=//XCUIElementTypeStaticText[@label='{{product}}'] 
${banner.favourite_heart}                          chain=**/XCUIElementTypeOther[`name CONTAINS "favourite_heart"`]
${banner.webview_content}                          xpath=//XCUIElementTypeOther[@name="webview_content"]/XCUIElementTypeWebView
${banner.webview_close_icon}                       xpath=//XCUIElementTypeOther[@name="webview_close_icon"]
${banner.bannertitle}                              xpath=//XCUIElementTypeOther[normalize-space(@name)="{{bannertitle}}"]
${banner.scrollview_typeimage}                     xpath=//XCUIElementTypeScrollView//XCUIElementTypeImage
${banner.txt_html}                                 xpath=//XCUIElementTypeOther[@name="html"]
${banner.icon_button}                              xpath=//XCUIElementTypeOther[@name="icon_button"]

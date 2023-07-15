***Settings***
Variables       ../../localisation/mobile/${lang}.yaml
Variables       ../../localisation/mobile/${lang}_additional.yaml

*** Variables ***
${banner.content_carousel_pagination}          xpath=//android.view.ViewGroup[@content-desc='content_carousel_pagination']/android.view.ViewGroup
${banner.content_carousel_pagination_count}    //android.view.ViewGroup[@content-desc='content_carousel_pagination']/android.view.ViewGroup
${banner.content_carousel_item_active}         xpath=//android.view.ViewGroup[contains(@content-desc,'content_carousel_item_active_{{bannername}}')]
${banner.content_carousel_item_}               xpath=//android.view.ViewGroup[contains(@content-desc,'content_carousel_item_')]
${banner.banner}                               xpath=//android.view.ViewGroup[contains(@content-desc,'{{banner1}}')]
${banner.txt_footer_botton}                    xpath=//android.widget.Button/android.widget.TextView[@text='${mobile['tab']['shopping']}']
${banner.txt_dry_food_category}                xpath=//android.widget.TextView[@text='${mobile_additional['main_category']['dry food']}']
${banner.search_input}                         xpath=//android.widget.EditText[@resource-id='searchInput']
${banner.txt_main_category}                    xpath=//android.widget.TextView[contains(@text,'{{main_category}}')]
${banner.txt_sub_category}                     xpath=//android.widget.TextView[contains(@text,'{{sub_category}}')]
${banner.product_item_gid}                     xpath=//android.view.ViewGroup[contains(@content-desc,'product_item_gid:')]
${banner.txt_product}                          xpath=//android.view.ViewGroup//following-sibling::android.widget.TextView[@text='{{product}}'] 
${banner.favourite_heart}                      xpath=//android.view.ViewGroup[contains(@content-desc,"favourite_heart")]
${banner.webkit}                               xpath=//android.widget.TextView[@text='']/../following-sibling::android.view.ViewGroup/android.webkit.WebView
${banner.webview}                              xpath=//android.widget.TextView[@text='']/following-sibling::android.view.ViewGroup
${banner.bannertitle}                          xpath=//android.view.View[@text='{{bannertitle}}']
${banner.imageview}                            xpath=//android.widget.ScrollView//android.widget.ImageView
${banner.bannertitle_viewgroup}                xpath=//android.view.View[@text='{{bannertitle}}']/../preceding-sibling::android.view.ViewGroup/android.view.ViewGroup
${banner.html}                                 xpath=//android.view.ViewGroup[@resource-id='html']
${banner.viewgroup}                            xpath=//android.view.View/../preceding-sibling::android.view.ViewGroup/android.view.ViewGroup

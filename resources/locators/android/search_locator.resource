***Settings***
Variables       ../../localisation/mobile/${lang}.yaml
Variables       ../../localisation/mobile/${lang}_additional.yaml

*** Variables ***
${search_page.input_container}                          xpath=//android.widget.EditText[@resource-id='${mobile_additional['other_textbox']['search']}']
${search_page.btn.see_more}                             xpath=//android.widget.TextView[@text="${mobile['global']['seeAll']}"]
${search_page.input_search}                             xpath=//android.widget.EditText[@resource-id='searchInput']
${search_page.input_search_placeholder}                 xpath=//android.widget.EditText[@text='${mobile['search']['label']['searchPlaceholder']}']
${search_page.searching_from_product_category}          xpath=//android.widget.TextView[@text='${mobile['search']['label']['weAreSorry']}']/following-sibling::android.widget.TextView[contains(@text,"${mobile_additional['search']['label']['searching_from_product_category']}")]
${search_page.see_more}                                 xpath=//android.widget.TextView[@text="${mobile['search']['label']['showAll']}"]
${search_page.increment_btn_wrapper}                    xpath=//android.widget.TextView[@text='{{product}}']/following-sibling::android.view.ViewGroup//android.view.ViewGroup[@content-desc="increment_btn_wrapper"]
${search_page.decrement_btn_wrapper}                    xpath=//android.widget.TextView[@text='{{product}}']/following-sibling::android.view.ViewGroup//android.view.ViewGroup[@content-desc="decrement_btn_wrapper"]
${search_page.qty_input}                                accessibility_id=qty_input
${search_page.product_image}                            xpath=//android.widget.TextView[@text='{{product}}']//preceding-sibling::android.view.ViewGroup/android.widget.ImageView
${search_page.product_from_suspended_shop}              xpath=//android.widget.TextView[contains(text(),'${product_data['product_from_suspended_shop']}')]
${search_page.no_result}                                xpath=//android.widget.TextView[@text='${mobile_additional['search']['label']['no_result']}']
${search_page.txt_search_from_product_category}         xpath=//android.widget.TextView[@text="${mobile['search']['button']['ctaBrowseCategory']}"]
${search_page.txt_please_search_agin_by_new_keyword}    xpath=//android.widget.TextView[@text="${mobile['search']['button']['ctaTrydifferentKeyword']}"]
${search_page.product_card}                             xpath=//android.widget.TextView[@text="{{product}}"]

${search_advance.input_search}                 xpath=//android.widget.EditText[@resource-id="searchInput"]
${search_advance.inputtext}                    xpath=//android.widget.EditText
${search_advance.txt_wording}                  xpath=//android.widget.TextView[@text="{{wording}}"]
${search_advance.txt_wording2_in}              xpath=//android.widget.TextView[@text="{{wording}}" or @text="{{wording2}}"]/../following-sibling::android.view.ViewGroup//android.widget.TextView[@text="${mobile['global']['in']}"]
${search_advance.txt_wording2_categoryname}    xpath=//android.widget.TextView[@text="{{wording}}" or @text="{{wording2}}"]/../following-sibling::android.view.ViewGroup//android.widget.TextView[@text=" {{categoryname}}"]
${search_advance.txt_searchtotal}              xpath=//android.widget.TextView[@text="${mobile_additional['search']['label']['product']} ({{searchtotal}})"]
${search_advance.product_item_gid}             xpath=//android.view.ViewGroup[contains(@content-desc,"product_item_gid:")]
${search_advance.see_all}                      xpath=//android.widget.TextView[@text="${mobile['global']['seeAll']}"]
${search_advance.txt_productname}              xpath=//android.widget.TextView[@text="{{productname}}"]
${search_advance.txt_searchtotal_list}         xpath=//android.widget.TextView[contains(@text,"{{searchtotal}} ${mobile['search']['label']['resultsFor']}")]
${search_advance.icon_button}                  xpath=//android.view.ViewGroup[@content-desc="icon_button"]
${search_advance.txt_sort}                     xpath=//android.widget.TextView[@text="${mobile['search']['label']['sort']}"]
${search_advance.search_filter_menu_button}    xpath=//android.view.ViewGroup[@content-desc="search_filter_menu_button"]
${search_advance.txt_filter_by}                xpath=//android.widget.TextView[@text="${mobile['search']['label']['filterBy']}"]
${search_advance.sorttype}                     xpath=//android.view.ViewGroup[@content-desc="{{sorttype}}"]
${search_advance.filtertype}                   xpath=//android.widget.TextView[@text="{{filtertype}}"]
${search_advance.filtersubtype}                xpath=//android.widget.TextView[@text="{{filtersubtype}}"]
${search_advance.txt_ok}                       xpath=//android.widget.TextView[@text="${mobile['global']['ok']}"]
${search_advance.txt_apply}                    xpath=//android.widget.TextView[@text="${mobile['global']['apply']}"]
${search_advance.show_result}                  xpath=//android.widget.TextView[@text="${mobile['search']['button']['showResults']}"]
${search_advance.txt_sort_back}                xpath=//android.widget.TextView[@text="${mobile['search']['label']['sort']}"]/..
${search_advance.filter_by_icon_button}        xpath=//android.widget.TextView[@text="${mobile['search']['label']['filterBy']}"]/preceding-sibling::android.view.ViewGroup[@content-desc="icon_button"]
${search_advance.txt_subtype}                  xpath=//android.widget.TextView[@text="{{type}}"]/following-sibling::android.widget.TextView[@text="({{sub}})"]
${search_advance.txt_subnumber}                xpath=//android.widget.TextView[@text="{{type}}"]/following-sibling::android.widget.TextView[@text="({{number}})"]
${search_advance.btn_claer}                    xpath=//android.widget.TextView[@text="${mobile['search']['label']['reset']}"]
${search_advance.show_result_back}             xpath=//android.widget.FrameLayout/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup[2]
${search_advance.txt_brandname_number}         xpath=//android.widget.TextView[@text="{{brandname}}"]/following-sibling::android.widget.TextView[@text="{{number}}"]
${search_advance.list_number}                  xpath=//android.view.ViewGroup[@content-desc="search_filter_menu_button"]//android.widget.TextView[@text="{{number}}"] 
${search_advance.sensitivecase}                xpath=//android.view.ViewGroup[contains(@content-desc,"product_item_gid:")]/android.widget.TextView[contains(@text,'{{word}}')or contains(@text,'{{sensitivecase}}')]
${search_advance.position}                     xpath=(//android.view.ViewGroup[contains(@content-desc,"product_item_gid:")])[{{position}}]/android.widget.TextView[@content-desc="list_item_title"]
${search_advance.position_error}               xpath=(//android.view.ViewGroup[contains(@content-desc,"product_item_gid:")])[{{position_error}}]/android.widget.TextView[@content-desc="list_item_title"]
${search_advance.scrollview_txt}               xpath=//android.widget.ScrollView/android.view.ViewGroup/android.view.ViewGroup[1]//android.widget.TextView/preceding-sibling::android.widget.TextView
${search_advance.productname_icon_button}      xpath=//android.widget.TextView[@text='{{productname}}']/following-sibling::android.view.ViewGroup//android.view.ViewGroup[@content-desc="icon_button"]
${search_advance.disable_icon_button}          xpath=//android.widget.TextView[@text='{{product}}']/following-sibling::android.view.ViewGroup//android.view.ViewGroup[@content-desc="icon_button"][@enabled='false']
${search_advance.txt_badge_product}            xpath=//android.widget.TextView[@text="{{badge_name}}"]/parent::android.view.ViewGroup/following-sibling::android.widget.TextView[@text="{{product_name}}"]

${search.txt_product}                    xpath=//android.widget.TextView[@text='{{product}}']
${search.txt_list_item_price}            xpath=//android.view.ViewGroup[contains(@content-desc, "qty_counter_gid://shopify/Product/")]/android.view.ViewGroup/android.widget.TextView
${search.txt_list_item_price_1}          xpath=(//android.view.ViewGroup[contains(@content-desc, "qty_counter_gid://shopify/Product/")]/android.view.ViewGroup/android.widget.TextView)[1]
${search.txt_list_item_price_2}          xpath=(//android.view.ViewGroup[contains(@content-desc, "qty_counter_gid://shopify/Product/")]/android.view.ViewGroup/android.widget.TextView)[2]
${search.txt_list_item_price}            xpath=(//android.view.ViewGroup[@content-desc="list_item_price"])[1]/android.widget.TextView
${search_page.product_price}             xpath=//android.widget.TextView[@text="{{product}}"]/following-sibling::android.view.ViewGroup/android.view.ViewGroup//android.widget.TextView
${search_page.product_title}             xpath=//android.widget.TextView[@content-desc="list_item_title"]
${search_page.product_title_2}           //android.widget.TextView[@content-desc="list_item_title"]
${search_page.txt_total_found}           xpath=//android.view.ViewGroup[@content-desc="search_sorter_menu_button"]/preceding-sibling::android.widget.TextView
${search_page.txt_percent_promo}         xpath=(//android.view.ViewGroup[contains(@content-desc,"qty_counter_gid")]//android.widget.TextView[contains(@text,'%')])[{index}]
${search_page.sort_button}               xpath=//android.view.ViewGroup[@content-desc="search_sorter_menu_button" and @enabled="true"]
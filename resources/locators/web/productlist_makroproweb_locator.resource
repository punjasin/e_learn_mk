***Settings***
Variables       ../../localisation/web/${lang}.yaml
Variables       ../../localisation/web/${lang}_additional.yaml

*** Variables ***
${productlist_makroproweb.txt_product_header_name}              xpath=//h1[contains(text(),'{{product_name}}')]
${productlist_makroproweb.txt_productlist_header}               xpath=//div/p[text()="${web['product']['title']}"]
${productlist_makroproweb.txt_showing_product}                  xpath=//div/div/p[contains(text(),"${web['product']['subtitle']}")]
${productlist_makroproweb.btn_sortby}                           xpath=//p[text()="${web['search']['sortBy']}"]/following-sibling::div//p
${productlist_makroproweb.btn_sort_name}                        xpath=//li/p[text()="{{sort_by_name}}"]
${productlist_makroproweb.txt_all_prices}                       xpath=//p[contains(text(),'฿')]
${productlist_makroproweb.btn_all_number_page}                  xpath=//nav[@class="PaginationNav"]//li/button[not(text()="${web['global']['next']}")]
${productlist_makroproweb.btn_out_of_product_first}             xpath=(//button[text()="${web['labels']['outOfStock']}"])[1]
${productlist_makroproweb.btn_filter_all_prices}                xpath=(//div[@data-cy="accordion-test"])[1]//input[not(@checked)]
${productlist_makroproweb.btn_filter_have_stock}                xpath=//span[text()="${web['search']['label']['inStockOnly']}"]/parent::span/preceding-sibling::span/input
${productlist_makroproweb.btn_filter_by_brand}                  xpath=//span[text()="{{brand_name}}"]/parent::span/preceding-sibling::div//input
${productlist_makroproweb.txt_all_product_brand}                xpath=//p[text()="${web['product']['title']}"]/following-sibling::div/div//p[text()="{{brand_name}}"]
${productlist_makroproweb.btn_first_product_add_basket}         xpath=(//button[text()="${web_additional['basket']['add']}"])[1]
${productlist_makroproweb.btn_first_out_of_product}             xpath=(//button[text()="${web['labels']['outOfStock']}"])[1]
${productlist_makroproweb.btn_discount_product}                 xpath=//span[text()="${filter_sub_type['discount']}"]/parent::span/preceding-sibling::span//input
${productlist_makroproweb.txt_all_product_percent}              xpath=//p[text()="${web['product']['title']}"]/following-sibling::div/div//*[contains(normalize-space(text()), "%")]
${productlist_makroproweb.btn_clear_all_filter}                 xpath=//button[text()="${web['search']['clearfilter']}"]
${productlist_makroproweb.btn_no_filter_product}                xpath=//h6[text()="${web['search']['label']['filterProductsNotFound']}"]
${productlist_makroproweb.btn_expand_icon}                      xpath=//p[text()="{{filter_type}}"]/parent::div/following-sibling::div/*[local-name() = 'svg' and @data-testid="AddIcon"]
${productlist_makroproweb.txt_product_name}                     xpath=//div[text()="{{product_name}}"]
${productlist_makroproweb.txt_product_qty}                      xpath=//div[text()="{{product_name}}"]/parent::div/parent::div//div[@class='MuiBox-root css-sevwnq']
${productlist_makroproweb.btn_add_basket_each_product}          xpath=//div[text()="{{product_name}}"]//ancestor::div/following-sibling::div/div//*[local-name() = 'svg'][@data-testid='AddIcon']
${productlist_makroproweb.btn_add_qty_popup}                    xpath=//div[div[text()="${web_additional['productlist']['label']['selectQuantity']}"]]/following-sibling::div//*[local-name() = "svg" and @data-testid="AddIcon"]
${productlist_makroproweb.btn_add_to_basket_popup}              xpath=//button[contains(text(),"${web_additional['productlist']['button']['addToBasket']}")]
${productlist_makroproweb.txt_delivery_1P_banner}               xpath=//div[text()="{{product_name}}"]/following-sibling::p[text()="${web['delivery']['deliveryIn']}"]
${productlist_makroproweb.input_basket_item}                    xpath=//div[text()="{{product_name}}"]//ancestor::div/following-sibling::div//input[@name="quantity"]
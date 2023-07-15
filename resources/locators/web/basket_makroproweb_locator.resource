***Settings***
Variables       ../../localisation/web/${lang}.yaml
Variables       ../../localisation/web/${lang}_additional.yaml

*** Variables ***
${basket_makroproweb.input_basket_item}                   xpath=//b[text()="{{product_name}}"]//ancestor::div/following-sibling::div//input[@name="quantity"]
${basket_makroproweb.txt_qty_value}                       xpath=//b[text()="{{product_name}}"]//ancestor::div/following-sibling::div//input[@value="{{qty}}"]
${basket_makroproweb.btn_add_item}                        xpath=//b[text()="{{product_name}}"]//ancestor::div/following-sibling::div/div//button/*[local-name() = 'svg'][@data-testid='AddIcon']
${basket_makroproweb.btn_remove_item}                     xpath=//b[text()="{{product_name}}"]//ancestor::div/following-sibling::div/div//button/*[local-name() = 'svg'][@data-testid='RemoveIcon']
${basket_makroproweb.txt_no_items}                        xpath=//div[@class='MuiBox-root css-qsaw8']/h4
${basket_makroproweb.btn_close_basket}                    xpath=//button/*[local-name() = 'svg'][@data-testid='CloseOutlinedIcon']
${basket_makroproweb.btn_make_payment}                    xpath=//button[text()="${web_additional['basket']['button']['makePayment']}"]
${basket_makroproweb.basket_header}                       xpath=//h4[text()="${web_additional['basket']['header']}"]
${basket_makroproweb.number_of_product}                   xpath=//div[div[*[h4[text()="${web_additional['basket']['header']}"] ]]]//following-sibling::div//a/p/b
${basket_makroproweb.btn_bin}                             xpath=//b[text()="{{product_name}}"]//ancestor::div/following-sibling::div/button/*[local-name() = 'svg'][@data-testid='DeleteOutlineIcon']
${basket_makroproweb.btn_payment}                         xpath=//button[text()="${web_additional['basket']['button']['makePayment']}"]
${basket_makroproweb.txt_total_price}                     xpath=//div/p[text()="${web['total']}"]/parent::div/following-sibling::div/p
${basket_makroproweb.txt_1p_vendor_name}                  xpath=//p/small[contains(text(),"${web_additional['checkout']['deliveredBy']} {{1p_vendor_name}}")]
${basket_makroproweb.txt_3p_vendor_name}                  xpath=//p/small[contains(text(),"${web_additional['basket']['seller']['soldby']} {{3p_vendor_name}}")]
${basket_makroproweb.txt_product_price}                   xpath=//b[text()="{{product_name}}"]//ancestor::div/following-sibling::div//p[contains(@class,"plp")]
${basket_makroproweb.btn_all_bin}                         xpath=//button/*[local-name() = 'svg'][@data-testid='DeleteOutlineIcon']
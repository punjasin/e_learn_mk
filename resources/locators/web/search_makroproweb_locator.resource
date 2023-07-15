***Settings***
Variables       ../../localisation/web/${lang}.yaml
Variables       ../../localisation/web/${lang}_additional.yaml

*** Variables ***
${search_makroproweb.txt_input_search}          xpath=//*[name()="svg"]/parent::div/following-sibling::div/input
${search_makroproweb.txt_suggest_dropdown}      xpath=//div[@role="tooltip"]/div//strong
${search_makroproweb.txt_first_suggest}         xpath=//div[@role="tooltip"]//div/p[1]
${search_makroproweb.txt_search_result}         xpath=//h1[text()='${web['search']['result']} "{{search_keyword}}"']
${search_makroproweb.txt_result_list}           xpath=//div[@data-popper-placement="bottom-start"]/div/div/div
${search_makroproweb.btn_add_to_basket}         xpath=//div[text()="{{product_name}}"]/parent::div/following-sibling::div/button[text()='${web_additional['basket']['add']}']
${search_makroproweb.btn_see_all}               xpath=//button[text()="${web_additional['search']['seeAll']}"]
${search_makroproweb.txt_qty}                   xpath=//div[@data-popper-placement="bottom-start"]//div[text()="{{product_name}}"]/parent::div/following-sibling::div//input
${search_makroproweb.btn_search_close}          xpath=//*[name()="svg"]/parent::div/following-sibling::div/input/ancestor::div[contains(@class,'MuiInputBase')]//following-sibling::div[contains(@class,'MuiBox-root')]//*[name()="svg"]
${search_makroproweb.all_dropdownlist}          xpath=//div[@role="tooltip"]/div
${search_makroproweb.btn_increase_qty}          xpath=//div[div[p[text()="Products"]]]/following::div//*[name()="svg" and @data-testid="AddIcon"]
${search_makroproweb.btn_of_product}            xpath=//div[text()="{{product_name}}"]/parent::div/following-sibling::div/button
${search_makroproweb.txt_product_name}          xpath=//div[text()="{{product_name}}"]/parent::div/parent::div/div/span/img

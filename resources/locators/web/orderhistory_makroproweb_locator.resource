***Settings***
Variables       ../../localisation/web/${lang}.yaml
Variables       ../../localisation/web/${lang}_additional.yaml

*** Variables ***
${orderhistory_makroproweb.txt_order_status}        xpath=//p[text()="{{seller_name}}"]/preceding-sibling::div/p[text()="{{order_number}}"]/parent::div/parent::div/parent::div/following-sibling::div//div[text()="{{order_status}}"]
${orderhistory_makroproweb.txt_order_number}        xpath=(//p[text()="{{seller_name}}"]/preceding-sibling::div/p)[1]
${orderhistory_makroproweb.txt_header}              xpath=//p[text()="${web['orderHistory']}"]
${orderhistory_makroproweb.txt_order_seller}        xpath=//p[text()="{{seller_name}}"]/preceding-sibling::div/p[text()="{{order_number}}"]
${orderhistory_makroproweb.txt_all_order}           xpath=//p[text()="{{order_number}}"]
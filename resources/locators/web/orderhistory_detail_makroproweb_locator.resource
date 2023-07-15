***Settings***
Variables       ../../localisation/web/${lang}.yaml
Variables       ../../localisation/web/${lang}_additional.yaml

*** Variables ***
${orderhistory_detail_makroproweb.txt_order_date}        xpath=//p[text()="${web['label']['orderWithNumber']}"]/parent::div/following-sibling::div//p[text()="{{delivery_slot}}"]
${orderhistory_detail_makroproweb.txt_payment_method}    xpath=//p[text()="${web['label']['paymentInfo']}"]/following-sibling::div/p[contains(text(),"${web['label']['paymentMethod']}")]
${orderhistory_detail_makroproweb.txt_payment_status}    xpath=//p[text()="${web['label']['paymentInfo']}"]/following-sibling::div/p[contains(text(),"${web['label']['status']}")]
${orderhistory_detail_makroproweb.btn_back_history}      xpath=//a[text()="${web['label']['backToHistory']}"]
${orderhistory_detail_makroproweb.txt_quantity}          xpath=//p[contains(@class,"quantity")]
${orderhistory_detail_makroproweb.txt_product_name}      xpath=//p[text()="{{product_name}}"]
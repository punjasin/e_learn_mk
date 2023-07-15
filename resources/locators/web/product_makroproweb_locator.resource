***Settings***
Variables       ../../localisation/web/${lang}.yaml
Variables       ../../localisation/web/${lang}_additional.yaml

*** Variables ***
${product_makroproweb.btn_add_to_basket}            xpath=//h1[text()="{{product_name}}"]/following-sibling::div//button[text()='${web_additional['basket']['add']}']
${product_makroproweb.txt_quantity}                 xpath=//input[@name="quantity"]
${product_makroproweb.btn_add_item}                 xpath=//input/following-sibling::*[local-name() = 'svg' and @data-testid="AddIcon"]
${product_makroproweb.btn_decrease_item}            xpath=//*[local-name() = 'svg' and @data-testid="RemoveIcon"]
${product_makroproweb.btn_outofstock}               xpath=//h1[text()="{{product_name}}"]/following-sibling::div//span[text()="${web['labels']['outOfStock']}"]
${product_makroproweb.txt_delivery_1P}              xpath=//h1[text()="{{product_name}}"]/following-sibling::p[text()="${web['delivery']['deliveryIn']}"]
${product_makroproweb.txt_order_before}             xpath=//div/p/strong[text()="${web['delivery']['orderBefore11pm']}"]
${product_makroproweb.txt_order_after}              xpath=//div/p/strong[text()="${web['delivery']['orderAfter11pm']}"]
${product_makroproweb.txt_delivery1P_before}        xpath=//div/p[contains(text(),"${web['delivery']['fastDeliveryWithinTomorrow']}")]
${product_makroproweb.txt_delivery1P_after}         xpath=//div/p[contains(text(),"${web['delivery']['fastDeliveryInTwoDays']}")]
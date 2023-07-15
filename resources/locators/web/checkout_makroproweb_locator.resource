***Settings***
Variables       ../../localisation/web/${lang}.yaml
Variables       ../../localisation/web/${lang}_additional.yaml

*** Variables ***
${checkout_makroproweb.checkout_header}               xpath=//h3[text()="${web_additional['basket']['button']['checkout']}"]
${checkout_makroproweb.basketsummary_header}          xpath=//h5[text()="${web['basketSummary']}"]
${checkout_makroproweb.txt_slot_date}                 xpath=//div[p[text()="${web['deliveryDate']}"]]/following-sibling::div/div/p[text()="{{slot_date}}"]
${checkout_makroproweb.last_timeslot}                 xpath=(//div[p[text()="${web['deliveryDate']}"]]/following-sibling::div/div/p[contains(text(),"${web_additional['timeslots']}")])[last()]
${checkout_makroproweb.txt_date_slot}                 xpath=(//div[p[text()="${web['deliveryDate']}"]]/following-sibling::div/div/p[contains(text(),"${web_additional['timeslots']}")])[last()]/preceding-sibling::p
${checkout_makroproweb.last_deliverytime_timeslot}    xpath=//p[text()="${web['deliveryTimeSlot']}"]/following-sibling::div/div[last()]
${checkout_makroproweb.txt_deliverydate}              xpath=//p[text()="${web_additional['checkout']['deliveredBy']} {{delivery_from_name}}"]/following-sibling::p
${checkout_makroproweb.btn_gotopayment}               xpath=//button[text()="${web['goToPayment']}"]
${checkout_makroproweb.txt_selectyourdeliveryslot}    xpath=//p[text()="${web_additional['checkout']['deliveredBy']} {{delivery_from_name}}"]/following-sibling::p[text()="${web['selectYourDeliverySlot']}"]
${checkout_makroproweb.txt_1p_delivery_by}            xpath=//p[text()="${web_additional['checkout']['deliveryByMakroPro']}"]/following-sibling::p
${checkout_makroproweb.txt_total_price}               xpath=//p[text()="${web['total']}"]/following-sibling::p
${checkout_makroproweb.btn_view_my_order}             xpath=//button[text()="${web['viewMyOrder']}"]
${checkout_makroproweb.order_completed}               xpath=//h3[text()="${web['orderPlaced2']}"]
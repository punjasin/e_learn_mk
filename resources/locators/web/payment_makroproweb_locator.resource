***Settings***
Variables       ../../localisation/web/${lang}.yaml
Variables       ../../localisation/web/${lang}_additional.yaml

*** Variables ***
${payment_makroproweb.txt_payment_header}                     xpath=//h1[text()="${web_additional['payment']['selectPaymentChannel']}"]
${payment_makroproweb.txt_payment_option}                     xpath=//p[text()="{{payment_option}}"]
${payment_makroproweb.txt_card_number}                        xpath=//input[@name="cardNumber"]
${payment_makroproweb.txt_card_holder_name}                   xpath=//input[@name="cardHolderName"]
${payment_makroproweb.txt_expiry_date}                        xpath=//input[@name="expiryDate"]
${payment_makroproweb.txt_cvv}                                xpath=//input[@name="cvv"]
${payment_makroproweb.btn_pay_amount}                         xpath=//button/div[text()="${web_additional['payment']['payAmount']}"]
${payment_makroproweb.btn_switch}                             xpath=//input[@role="switch"]/preceding-sibling::div[1]
${payment_makroproweb.btn_switch_enable}                      xpath=//input[@role="switch" and @aria-checked="true"]
${payment_makroproweb.txt_payment_was_declined}               xpath=//h1[text()="${web_additional['payment']['paymentWasDecline']}"]
${payment_makroproweb.btn_back_to_merchant}                   xpath=//button/div[text()="${web_additional['payment']['backToMerchant']}"]
${payment_makroproweb.txt_payment_unsuccessful}               xpath=//h3[text()="${web['paymentUnsuccessful']}"]
${payment_makroproweb.txt_payment_unsuccessful_description}    xpath=//p[text()="${web['resetPassword']['notMyNumber']['title']}"]
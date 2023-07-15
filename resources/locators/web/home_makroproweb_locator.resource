***Settings***
Variables       ../../localisation/web/${lang}.yaml
Variables       ../../localisation/web/${lang}_additional.yaml

*** Variables ***
${home_makroproweb.btn_cookie}                   id=onetrust-accept-btn-handler
${home_makroproweb.txt_zipcode_input}            xpath=//div/label[text()="${web['multiStore']['zipCode']}"]/following-sibling::div/input
${home_makroproweb.zipcode_select_subdistrict}   xpath=//div/p[contains(@class,"MuiTypography-root") and text()="{{subdistrict}}"]
${home_makroproweb.btn_save}                     xpath=//button[text()="${web['global']['save']}"]
${home_makroproweb.txt_zipcode_title}            xpath=//p[text()="${web['multiStore']['newZipCodeTitle']}"]
${home_makroproweb.txt_zipcode_selected}         xpath=//p[text()='${web['multiStore']['zipCode']}: {{zipcode}}']
${home_makroproweb.btn_lang}                     xpath=//button[text()="{{lang}}"]
${home_makroproweb.txt_cart_total}               xpath=//button[@aria-label='cart']/span/span
${home_makroproweb.btn_cart}                     xpath=//button[@aria-label='cart']
${home_makroproweb.user_icon}                    xpath=//a[contains(@href,"${web_additional['global_text']['login']}")]/button
${home_makroproweb.txt_outside_area_error}       xpath=//p[text()="${web['multiStore']['zipcodeIsNotSupportedByMakroPro']}"]
${home_makroproweb.txt_all_subdistrict}          xpath=//p[text()="${web['multiStore']['newZipCodeTitle']}"]/following-sibling::div/div/p
${home_makroproweb.banner_image}                 xpath=//div[contains(@class, 'slick-slide') and (@aria-hidden='false')]//div[contains(@data-test-id,"banner")]//img
${home_makroproweb.banner_right_arrow}           xpath=(//div[contains(@class,"slick-slider slick-initial")]/div/*[local-name()='svg' and @data-testid="ChevronRightIcon"])[1]
${home_makroproweb.banner_left_arrow}            xpath=(//div[contains(@class,"slick-slider slick-initial")]/div/*[local-name()='svg' and @fill="none"])[1]
${home_makroproweb.all_banner_image}             xpath=//div[contains(@class,"slick-slider slick-initial")]/ul/li
${home_makroproweb.makro_logo}                   xpath=//div/a[@aria-label="makro logo"]
${home_makroproweb.btn_categories}               xpath=//button[text()="${web['header']['categories']}"]
${home_makroproweb.btn_main_category}            xpath=//ul[@role="menu"]//div[text()="{{main_category}}"]/following-sibling::*[local-name() = 'svg']
${home_makroproweb.btn_sub_category}             xpath=//div[contains(text(),"{{main_category}}")]/following-sibling::div/div[text()="{{sub_category}}"]
${home_makroproweb.txt_delivery_1P_product}      xpath=//p[contains(text(),"{{category_name}}")]/parent::div//div[text()="{{product_name}}"]/following-sibling::p[text()="${web['delivery']['deliveryIn']}"]
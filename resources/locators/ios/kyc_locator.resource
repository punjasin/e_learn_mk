***Settings***
Variables       ../../localisation/mobile/${lang}.yaml
Variables       ../../localisation/mobile/${lang}_additional.yaml

*** Variables ***
${kyc.txt_we_here_to_grow_your_business}       chain=**/XCUIElementTypeStaticText[`label == "${mobile['business']['label']['growYourBusiness']}"`]
${kyc.txt_start_filling_in_details}            chain=**/XCUIElementTypeOther[`label == "${mobile['business']['button']['fillOutDetails']}"`]
${kyc.txt_do_it_later}                         chain=**/XCUIElementTypeOther[`label == "${mobile['business']['button']['doItLater']}"`]
${kyc.txt_enter_business_details}              accessibility_id=${mobile['business']['contactInfoStep']['title']}
${kyc.name_surname_input}                      xpath=//XCUIElementTypeOther[@name="${mobile_additional['kyc']['name_surname']}"]/XCUIElementTypeTextField[@name="input"]
${kyc.business_name_input}                     xpath=//XCUIElementTypeOther[@name="${mobile_additional['kyc']['business_name']}"]/XCUIElementTypeTextField[@name="input"]
${kyc.phone_number_input}                      xpath=//XCUIElementTypeOther[@name="${mobile_additional['kyc']['phone_number']}"]/XCUIElementTypeTextField[@name="input"]
${kyc.input_phone_number}                      xpath=//XCUIElementTypeOther[@name="${mobile_additional['kyc']['phone_number']}"]//XCUIElementTypeTextField[@name="input"]
${kyc.txt_phone_number_must_be}                chain=**/XCUIElementTypeStaticText[`label == "${mobile_additional['kyc']['phone_number_must_be']}"`]
${kyc.continue_by_enable}                      xpath=//XCUIElementTypeOther[@name="${mobile_additional['kyc']['continue']}" and @enabled="{{enabled}}"]
${kyc.continue_true}                           xpath=//XCUIElementTypeOther[@name="${mobile_additional['kyc']['continue']}" and @accessible="true"]
${kyc.txt_choose_your_business_type}           accessibility_id=${mobile['business']['label']['selectYourType']}
${kyc.ios_touchable_wrapper}                   chain=**/XCUIElementTypeOther[`name == "ios_touchable_wrapper"`]
${kyc.topic_ios_touchable_wrapper}             xpath=//XCUIElementTypeOther[@name="{{topic}}"]//XCUIElementTypeOther[@name="ios_touchable_wrapper"]
${kyc.business_label_other}                    xpath=//XCUIElementTypeOther[contains(@name,"{{topic}}")]/following-sibling::XCUIElementTypeOther[@name="${mobile_additional['kyc']['please_specify_not_required']}"]//XCUIElementTypeTextField[@name="business.label.other"]
${kyc.txt_topic_detail}                        chain=**/XCUIElementTypeStaticText[`label == "{{topic_detail}}"`]
${kyc.txt_other_types_of_businesses}           xpath=//XCUIElementTypeStaticText[@name="${mobile['business']['label']['otherBusinessType']}"]
${kyc.input}                                   chain=**/XCUIElementTypeTextField[`name == "input"`]
${kyc.true_done}                               xpath=//XCUIElementTypeOther[@name="${mobile['global']['done']}" and @accessible="true"]
${kyc.txt_enabled_done}                        xpath=//XCUIElementTypeOther[@name="${mobile['global']['done']}" and @enabled="{{enabled}}"]
${kyc.thank_received_your_business_details}    chain=**/XCUIElementTypeOther[`label == "${mobile_additional['kyc']['thank_received_your_business_details']}"`]
${kyc.required_information}                    chain=**/XCUIElementTypeOther[`label == "{{kyc_field}} ${mobile['global']['required']}"`]
${kyc.unnecessary}                             chain=**/XCUIElementTypeOther[`label == "{{kyc_field}} ${mobile_additional['kyc']['unnecessary']}"`]

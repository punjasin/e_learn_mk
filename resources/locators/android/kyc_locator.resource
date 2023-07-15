***Settings***
Variables       ../../localisation/mobile/${lang}.yaml
Variables       ../../localisation/mobile/${lang}_additional.yaml

*** Variables ***
${kyc.txt_we_here_to_grow_your_business}     xpath=//android.widget.TextView[@text="${mobile['business']['label']['growYourBusiness']}"]
${kyc.txt_start_filling_in_details}          xpath=//android.widget.TextView[@text="${mobile['business']['button']['fillOutDetails']}"]
${kyc.txt_do_it_later}                       xpath=//android.widget.TextView[@text="${mobile['business']['button']['doItLater']}"]
${kyc.txt_enter_business_details}            xpath=//android.widget.TextView[@text="${mobile['business']['contactInfoStep']['title']}"]
${kyc.name_surname_input}                    xpath=//android.widget.EditText[@text="${mobile['business']['contactInfoStep']['label']['contactName']}"]
${kyc.business_name_input}                   xpath=//android.widget.EditText[@text="${mobile_additional['kyc']['business_name']}"]
${kyc.phone_number_input}                    xpath=//android.widget.EditText[@text="${mobile_additional['kyc']['phone_number']}"]
${kyc.input_phone_number}                    xpath=//android.widget.TextView[@text='${mobile_additional['kyc']['phone_number']}']/parent::android.view.ViewGroup//android.widget.EditText
${kyc.txt_phone_number_must_be}              xpath=//android.widget.TextView[@text="${mobile_additional['kyc']['phone_number_must_be']}"]
${kyc.txt_continue}                          xpath=//android.widget.TextView[@text="${mobile_additional['kyc']['continue']}"]
${kyc.txt_choose_your_business_type}         xpath=//android.widget.TextView[@text="${mobile['business']['label']['selectYourType']}"]
${kyc.android_touchable_wrapper}             xpath=//android.view.ViewGroup[@resource-id="android_touchable_wrapper"]
${kyc.select_dialog_listview}                xpath=//android.widget.ListView[@resource-id="com.makromangoapp.qa:id/select_dialog_listview"]/android.widget.CheckedTextView[@text="{{name}}"]
${kyc.topic_android_touchable_wrapper}       xpath=//android.widget.TextView[@text="{{topic}}"]/following-sibling::android.view.ViewGroup[@resource-id="android_touchable_wrapper"]
${kyc.topic_business_label_other}            xpath=//android.widget.TextView[@text='{{topic}}']/following-sibling::android.view.ViewGroup//android.widget.EditText[@content-desc='business.label.other']
${kyc.txt_topic_detail}                      xpath=//android.widget.TextView[@text="{{topic_detail}}"]
${kyc.txt_other_types_of_businesses}         xpath=//android.widget.TextView[@text="${mobile['business']['label']['otherBusinessType']}"]
${kyc.txt_done}                              xpath=//android.widget.TextView[@text="${mobile['global']['done']}"]
${kyc.txt_received_your_business_details}    xpath=//android.widget.TextView[@text="${mobile_additional['kyc']['received_your_business_details']}"]
${kyc.required_information}                  xpath=//android.widget.TextView[@text='${mobile['global']['required']}']/preceding-sibling::android.view.ViewGroup//android.widget.EditText[@text='{{kyc_field}}']
${kyc.unnecessary}                           xpath=//android.widget.TextView[@text='${mobile_additional['kyc']['unnecessary']}']/preceding-sibling::android.view.ViewGroup//android.widget.EditText[@content-desc='{{kyc_field}}']
${kyc.txt_enabled_continue}                  xpath=//android.view.ViewGroup[@enabled='{{enabled}}']/android.widget.TextView[@text='${mobile_additional['kyc']['continue']}']
${kyc.txt_enabled_done}                      xpath=//android.view.ViewGroup[@enabled='{{enabled}}']/android.widget.TextView[@text='${mobile['global']['done']}']
${kyc.input}                                 accessibility_id=input
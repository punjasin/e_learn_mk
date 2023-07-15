***Settings***
Variables       ../../localisation/mobile/${lang}.yaml
Variables       ../../localisation/mobile/${lang}_additional.yaml

*** Variables ***
${feedback.txt_give_feedback_title}     xpath=//android.widget.TextView[@text='${mobile['feedback']['label']['rateUs']}']
${feedback.txt_give_feedback_desc}      xpath=//android.widget.TextView[@text='${mobile['feedback']['label']['howExperience']}']
${feedback.btn_close_give_feedback}     xpath=//android.widget.TextView[@text='${mobile['feedback']['label']['howExperience']}']/preceding-sibling::android.view.ViewGroup[@content-desc='${mobile_additional['other_button']['icon_button']}']
${feedback.icon_button_1}               xpath=//android.widget.TextView[@text='${mobile['feedback']['label']['howExperience']}']/following-sibling::android.view.ViewGroup[@content-desc='icon_button'][1]
${feedback.feedback_rating_input}       xpath=//android.widget.EditText[@content-desc="feedback_rating_input"]
${feedback.icon_button_2}               xpath=//android.widget.TextView[@text='${mobile['feedback']['label']['howExperience']}']/following-sibling::android.view.ViewGroup[@content-desc='icon_button'][2]
${feedback.icon_button}                 xpath=//android.widget.TextView[@text='${mobile['feedback']['label']['howExperience']}']/preceding-sibling::android.view.ViewGroup[@content-desc='icon_button']
${feedback.feedback_rating_send_btn}    xpath=//android.view.ViewGroup[@content-desc="feedback_rating_send_btn"]
${feedback.txt_thank}                   xpath=//android.widget.TextView[@text='${mobile['feedback']['label']['thankYou']}']
${feedback.txt_your_comment}            xpath=//android.widget.TextView[@text='${mobile['feedback']['label']['thankYouDescription']}']
${feedback.txt_done}                    xpath=//android.widget.TextView[@text="${mobile['global']['done']}"]
${feedback.thank_icon_button}           xpath=//android.widget.TextView[@text='${mobile['feedback']['label']['thankYou']}']/preceding-sibling::android.view.ViewGroup[@content-desc='icon_button']

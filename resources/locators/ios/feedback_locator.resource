***Settings***
Variables       ../../localisation/mobile/${lang}.yaml
Variables       ../../localisation/mobile/${lang}_additional.yaml

*** Variables ***
${feedback.txt_give_feedback_title}     chain=**/XCUIElementTypeStaticText[`label == "${mobile['feedback']['label']['rateUs']}"`]
${feedback.txt_give_feedback_desc}      chain=**/XCUIElementTypeStaticText[`label == "${mobile['feedback']['label']['howExperience']}"`]
${feedback.btn_close_give_feedback}     xpath=//XCUIElementTypeStaticText[@name="${mobile['feedback']['label']['rateUs']}"]/following-sibling::XCUIElementTypeOther[@name="${mobile_additional['other_button']['icon_button']}"]
${feedback.icon_button}                 xpath=//XCUIElementTypeStaticText[@name="${mobile['feedback']['label']['howExperience']}"]/following-sibling::XCUIElementTypeOther/XCUIElementTypeOther[@name="icon_button"]
${feedback.icon_button_1}               xpath=//XCUIElementTypeStaticText[@name="${mobile['feedback']['label']['howExperience']}"]/following-sibling::XCUIElementTypeOther/XCUIElementTypeOther[@name="icon_button"][1]
${feedback.icon_button_2}               xpath=//XCUIElementTypeStaticText[@name="${mobile['feedback']['label']['howExperience']}"]/following-sibling::XCUIElementTypeOther/XCUIElementTypeOther[@name="icon_button"][2]
${feedback.icon_button_rateus}          xpath=//XCUIElementTypeStaticText[@name="${mobile['feedback']['label']['rateUs']}"]/following-sibling::XCUIElementTypeOther[@name="icon_button"]
${feedback.comment_sent}                chain=**/XCUIElementTypeOther[`label == "${mobile['feedback']['label']['rateUs']}"`]
${feedback.feedback_rating_input}       chain=**/XCUIElementTypeTextView[`name == "feedback_rating_input"`]
${feedback.feedback_rating_send_btn}    chain=**/XCUIElementTypeOther[`name == "feedback_rating_send_btn"`]
${feedback.txt_thank}                   chain=**/XCUIElementTypeStaticText[`label == "${mobile['feedback']['label']['thankYou']}"`]
${feedback.txt_your_comment}            chain=**/XCUIElementTypeStaticText[`label == "${mobile['feedback']['label']['thankYouDescription']}"`]
${feedback.txt_your_comment_success}    chain=**/XCUIElementTypeOther[`label == "${mobile_additional['feedback']['label']['txt_your_comment_success']}"`]/**/XCUIElementTypeOther[`name == "icon_button"`]
${feedback.txt_enjoying_maknet}         chain=**/XCUIElementTypeStaticText[`label == "${mobile_additional['feedback']['label']['enjoying_maknet']}"`]
${feedback.rating}                      chain=**/XCUIElementTypeOther[`label == "${mobile_additional['feedback']['label']['rating']}"`]
${feedback.not_now}                     chain=**/XCUIElementTypeButton[`label == "${mobile_additional['feedback']['label']['not_now']}"`]
${feedback.success}                     chain=**/XCUIElementTypeOther[`label == "${mobile_additional['feedback']['label']['success']}"`]

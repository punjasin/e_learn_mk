***Settings***
Variables       ../../localisation/mobile/${lang}.yaml
Variables       ../../localisation/mobile/${lang}_additional.yaml

*** Variables ***
${tnc_btn.accept_terms_and_condition}        chain=**/XCUIElementTypeOther[`label == "${mobile_additional['home']['btn_accept_terms_and_conditions']}"`]
${tnc_txt.terms_and_condition_title}         chain=**/XCUIElementTypeStaticText[`label == "${mobile_additional['tnc']['popup_title_terms_and_conditions']}"`]
${tnc_txt.terms_and_condition_desc}          chain=**/XCUIElementTypeStaticText[`label == "${mobile_additional['tnc']['popup_desc_terms_and_conditions']}"`]
${tnc_btn.accept_terms_and_condition_lbl}    chain=**/XCUIElementTypeOther[`label == "${mobile['global']['accept']}"`][3]
${tnc_txt.digital_services}                  chain=**/XCUIElementTypeStaticText[`label CONTAINS "${mobile_additional['tnc']['digital_services']}"`]
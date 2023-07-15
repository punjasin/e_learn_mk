***Settings***
Variables       ../../localisation/mobile/${lang}.yaml
Variables       ../../localisation/mobile/${lang}_additional.yaml

*** Variables ***
${popup.btn_dont_allow}            chain=**/XCUIElementTypeButton[`label == "Don’t Allow"`]
${keyboard.btn_done}               chain=**/XCUIElementTypeOther[`label == "${mobile['global']['done']}"`]
${keyboard.btn_cancel}             chain=**/XCUIElementTypeOther[`label == "${mobile['global']['cancel']}"`]
${keyboard.btn_delete}             chain=**/XCUIElementTypeKey[`label == "Delete"`]
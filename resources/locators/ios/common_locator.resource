***Settings***
Variables       ../../localisation/mobile/${lang}.yaml
Variables       ../../localisation/mobile/${lang}_additional.yaml

*** Variables ***
${mobile_common.btn_mylist}            chain=**/XCUIElementTypeButton[`label == "${mobile_additional['common']['mylist']}"`]
${mobile_common.btn_shopping}          chain=**/XCUIElementTypeButton[`label == "${mobile_additional['common']['shopping']}"`]
${mobile_common.edit_text}             xpath=//XCUIElementTypeOther/XCUIElementTypeTextField
${mobile_common.search_input}          chain=**/XCUIElementTypeTextField[`name == "searchInput"`]
${mobile_common.webview_close_icon}    chain=**/XCUIElementTypeOther[`name == "webview_close_icon"`]
${mobile_common.loader}                chain=**/XCUIElementTypeOther[`name == "loader_container"`]
${mobile_common.icon_button}           xpath=//XCUIElementTypeOther[contains(@name,"${mobile_additional['more']['label']['search_product']}")]/following-sibling::XCUIElementTypeOther[@accessible = "true"]
${mobile_common.pickerwheel}           //XCUIElementTypePickerWheel
${mobile_common.pickerwheel_value}     chain=**/XCUIElementTypePickerWheel[`value == "{{value}}"`]
${mobile_common.btn_done}              xpath=//XCUIElementTypeButton[@name="${mobile['global']['done']}"]
${mobile_common.btn_done_button}       xpath=//XCUIElementTypeOther[@name="done_button"]
${mobile_common.btn_th_basket}         xpath=//XCUIElementTypeButton[contains(@name,'${mobile_additional['common']['basket']}')]
${mobile_common.switch_en}             xpath=//XCUIElementTypeStaticText[@name="EN locale"]/following-sibling::XCUIElementTypeSwitch
${mobile_common.btn_en_basket}         xpath=//XCUIElementTypeButton[contains(@name,'${mobile['tab']['basket']}')]
${mobile_common.typeother}             chain=**/XCUIElementTypeOther[`label == ""`]
${mobile_common.btn_more}              chain=**/XCUIElementTypeButton[`label == "${mobile_additional['common']['more']}"`]
${mobile_common.btn_label_done}        chain=**/XCUIElementTypeOther[`label == "${mobile_additional['common']['done']}"`]
${mobile_common.btn_do_not_allow}      chain=**/XCUIElementTypeButton[`label == "${mobile_additional['common']['do_not_allow']}"`]
${mobile_common.txt_desc}              chain=**/XCUIElementTypeOther[`label CONTAINS "{{string}}"`]
${mobile_common.toast}                 chain=**/XCUIElementTypeOther[`name CONTAINS "toast_success" OR name CONTAINS "toast_warning"`]
${mobile_common.default_scroll_view}   xpath=//XCUIElementTypeWindow
***Settings***
Variables       ../../localisation/mobile/${lang}.yaml
Variables       ../../localisation/mobile/${lang}_additional.yaml

*** Variables ***
${jt_tracking.url_bar}          xpath=//XCUIElementTypeOther[@name="URL"]
${jt_tracking.txt_url}          xpath=//XCUIElementTypeTextField[@name="URL"]
${jt_tracking.txt_cancel}       xpath=//XCUIElementTypeStaticText[@name="Cancel"]
${jt_tracking.caim_next_day}    xpath=//XCUIElementTypeStaticText[@name="${mobile_additional['jt_tracking']['caim_next_day']}"]/parent::XCUIElementTypeOther/following-sibling::XCUIElementTypeOther/XCUIElementTypeTextField 
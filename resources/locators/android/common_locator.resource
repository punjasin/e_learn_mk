***Settings***
Variables       ../../localisation/mobile/${lang}.yaml
Variables       ../../localisation/mobile/${lang}_additional.yaml

*** Variables ***
${mobile_common.btn_mylist}              xpath=//android.widget.Button/android.widget.TextView[@text='${mobile_additional['common']['mylist']}']
${mobile_common.btn_shopping}            xpath=//android.widget.Button/android.widget.TextView[@text='${mobile_additional['common']['shopping']}']
${mobile_common.edit_text}               xpath=//android.widget.EditText
${mobile_common.search_input}            xpath=//android.view.ViewGroup[@content-desc='content_carousel_pagination']
${mobile_common.webview_close_icon}      xpath=//android.view.ViewGroup[@content-desc="webview_close_icon"]
${mobile_common.loader}                  accessibility_id=loader_container
${mobile_common.icon_button}             xpath=//android.view.ViewGroup[@content-desc="icon_button"]
${mobile_common.welcome_to_chrome}       xpath=//android.widget.TextView[@text='${mobile_additional['common']['welcome_to_chrome']}']
${mobile_common.btn_terms_accept}        xpath=//android.widget.Button[@resource-id='com.android.chrome:id/terms_accept']
${mobile_common.txt_browse_faster}       xpath=//android.widget.TextView[@text='${mobile_additional['common']['browse_faster']}']
${mobile_common.btn_next_button}         xpath=//android.widget.Button[@resource-id='com.android.chrome:id/next_button']
${mobile_common.txt_turn_on_sync}        xpath=//android.widget.TextView[@text='${mobile_additional['common']['turn_on_sync']}']
${mobile_common.btn_negative_button}     xpath=//android.widget.Button[@resource-id='com.android.chrome:id/negative_button']
${mobile_common.txt_noti_title}          xpath=//android.widget.TextView[@resource-id='android:id/title' and contains(@text,'{{noti_title}}')]
${mobile_common.txt_noti_body_big}       xpath=//android.widget.TextView[@resource-id='android:id/big_text' and contains(@text,'{{noti_body}}')]
${mobile_common.txt_noti_body}           xpath=//android.widget.TextView[@resource-id='android:id/text' and contains(@text,'{{noti_body}}')]
${mobile_common.txt_title}               xpath=//android.widget.TextView[@resource-id='android:id/title']
${mobile_common.txt_big_text}            xpath=//android.widget.TextView[@resource-id='android:id/big_text']
${mobile_common.txt_text}                xpath=//android.widget.TextView[@resource-id='android:id/text']
${mobile_common.terms_accept}            id=com.android.chrome:id/terms_accept
${mobile_common.negative_button}         id=com.android.chrome:id/negative_button
${mobile_common.button_once}             id=android:id/button_once
${mobile_common.profile_pager_chrome}    xpath=//com.android.internal.widget.ViewPager[@resource-id="android:id/profile_pager"]//android.widget.TextView[@text="${mobile_additional['common']['chrome']}"]
${mobile_common.open_with_chrome}        xpath=//android.widget.TextView[@resource-id="android:id/title" and @text="${mobile_additional['common']['open_with_chrome']}"]
${mobile_common.translate_infobar}       id=com.android.chrome:id/translate_infobar_content
${mobile_common.btn_infobar_close}       id=com.android.chrome:id/infobar_close_button
${mobile_common.txt_desc}                xpath=//android.widget.TextView[contains(@text, "{{string}}")]
${mobile_common.toast}                   xpath=//android.view.ViewGroup[contains(@content-desc,"toast_success") or contains(@content-desc,"toast_warning")]

${mobile_common.btn_open}                 accessibility_id=Open
${mobile_common.tittle_app}                     xpath=//android.widget.TextView[@text="Deep Link Tester"]
${mobile_common.input_link}                     id=org.thewheatfield.android.deeplinks:id/location
${mobile_common.go_to_URI}                      id=org.thewheatfield.android.deeplinks:id/goToLocation
${mobile_common.default_scroll_view}            xpath=//android.widget.ScrollView
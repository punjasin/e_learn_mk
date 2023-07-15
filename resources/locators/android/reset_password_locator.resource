***Settings***
Variables       ../../localisation/mobile/${lang}.yaml
Variables       ../../localisation/mobile/${lang}_additional.yaml

*** Variables ***
${reset_password.reset_password_header}               xpath=//android.view.View[@text="${mobile['resetPassword']['title']['resetPassword']}"]
${reset_password.input_current_password}              xpath=//android.widget.EditText[@content-desc="input" and @text="${mobile['resetPassword']['label']['oldPassword']}"]
${reset_password.input_new_password}                  xpath=//android.widget.EditText[@content-desc="input" and @text="${mobile['resetPassword']['label']['newPassword']}"]
${reset_password.input_confirm_new_password}          xpath=//android.widget.EditText[@content-desc="input" and @text="${mobile['resetPassword']['label']['confirmNewPassword']}"]
${reset_password.validation_new_password}             xpath=//android.widget.EditText[@content-desc="input" and @text="${mobile['resetPassword']['label']['newPassword']}"]/parent::android.view.ViewGroup/parent::android.view.ViewGroup/following-sibling::android.widget.TextView[@text="โปรดระบุ"][1]
${reset_password.validation_confirm_new_password}     xpath=//android.widget.EditText[@content-desc="input" and @text="${mobile['resetPassword']['label']['confirmNewPassword']}"]/parent::android.view.ViewGroup/parent::android.view.ViewGroup/following-sibling::android.widget.TextView[@text="โปรดระบุ"][1]
${reset_password.new_password_not_match}              xpath=//android.widget.TextView[@text="${mobile['resetPassword']['label']['confirmNewPassword']}"]/parent::android.view.ViewGroup/following-sibling::android.widget.TextView[@text="${mobile['resetPassword']['message']['passwordDoesNotMutch']}"]
${reset_password.current_password}                    xpath=//android.widget.EditText[@content-desc="input" and @text="${mobile['resetPassword']['label']['oldPassword']}"]/parent::android.view.ViewGroup/android.view.ViewGroup
${reset_password.new_password}                        xpath=//android.widget.EditText[@content-desc="input" and @text="${mobile['resetPassword']['label']['newPassword']}"]/parent::android.view.ViewGroup/android.view.ViewGroup
${reset_password.confirm_new_password}                xpath=//android.widget.EditText[@content-desc="input" and @text="${mobile['resetPassword']['label']['confirmNewPassword']}"]/parent::android.view.ViewGroup/android.view.ViewGroup
${reset_password.confirm_reset_password}              xpath=//android.widget.TextView[@text="${mobile['resetPassword']['button']['updatePassword']}"]/parent::android.view.ViewGroup[@enabled="false"]

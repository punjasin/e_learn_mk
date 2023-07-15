*** Settings ***
Resource            ../../../resources/locators/web/forgot_makroproweb_locator.resource
Resource            ../../../common/web/web_common.resource

*** Keywords ***
Verify reset password title with instruction display
    DobbyWebCommon.Wait until element is visible except stale       ${forgot_makroproweb.txt_reset_password_title}
    DobbyWebCommon.Wait until element is visible except stale       ${forgot_makroproweb.txt_reset_instruction}
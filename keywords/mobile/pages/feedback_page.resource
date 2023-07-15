*** Settings ***
Resource        ../../../resources/locators/${platform}/feedback_locator.resource
Resource        ../../../resources/locators/${platform}/common_locator.resource
Resource        ../../../common/mobile/mobile_common.resource

*** Keywords ***
Verify feedback popup display
    IF   "${platform}" == "${platform_list['android']}"
        DobbyAppCommon.Wait until element is visible except stale    ${feedback.txt_give_feedback_title}
        DobbyAppCommon.Wait until element is visible except stale    ${feedback.txt_give_feedback_desc}
        DobbyAppCommon.Wait until element is visible except stale    ${feedback.btn_close_give_feedback}
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        DobbyAppCommon.Wait until element is visible except stale    ${feedback.txt_give_feedback_title}       timeout=${short_timeout}
        DobbyAppCommon.Wait until element is visible except stale    ${feedback.txt_give_feedback_desc}     timeout=${short_timeout}
        DobbyAppCommon.Wait until element is visible except stale    ${feedback.icon_button_rateus}        timeout=${short_timeout}
    END

Click thumbs-up
    IF   "${platform}" == "${platform_list['android']}"
        DobbyAppCommon.Tap element when ready     ${feedback.icon_button_1}
        DobbyAppCommon.Wait until element is visible except stale   ${feedback.feedback_rating_input}
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        DobbyAppCommon.Wait until element is visible except stale       ${feedback.icon_button}
        DobbyAppCommon.Tap element when ready     ${feedback.icon_button_1}
        DobbyAppCommon.Wait until element is visible except stale       ${feedback.comment_sent}
    END

Click thumbs-down
    IF   "${platform}" == "${platform_list['android']}"
        DobbyAppCommon.Tap element when ready     ${feedback.icon_button_2}
        DobbyAppCommon.Wait until element is visible except stale   ${feedback.feedback_rating_input}
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        DobbyAppCommon.Wait until element is visible except stale       ${feedback.icon_button}
        DobbyAppCommon.Tap element when ready     ${feedback.icon_button_2}
        DobbyAppCommon.Wait until element is visible except stale       ${feedback.comment_sent}
    END

Click x button to close feedback popup
    IF   "${platform}" == "${platform_list['android']}"
        DobbyAppCommon.Tap element when ready      ${feedback.icon_button}
        AppiumLibrary.Wait until page does not contain element      ${feedback.txt_give_feedback_title}
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        DobbyAppCommon.Tap element when ready       ${feedback.icon_button_rateus}
        AppiumLibrary.Wait until page does not contain element      ${feedback.txt_give_feedback_title}
    END

Enter feedback on feedback box
    [Arguments]     ${feedback}
    DobbyAppCommon.Input text to element when ready     ${feedback.feedback_rating_input}  ${feedback}

Click send feedback
    IF   "${platform}" == "${platform_list['android']}"
        DobbyAppCommon.Wait until element is visible except stale   ${feedback.feedback_rating_send_btn}        timeout=${short_timeout}
        DobbyAppCommon.Tap element when ready       ${feedback.feedback_rating_send_btn}
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        DobbyAppCommon.Tap element when ready    ${feedback.feedback_rating_send_btn}
    END

Verify thank you popup display
    DobbyAppCommon.Wait until element is visible except stale    ${feedback.txt_thank}
    DobbyAppCommon.Wait until element is visible except stale    ${feedback.txt_your_comment}

Tap done button on thank you popup
    IF   "${platform}" == "${platform_list['android']}"
        DobbyAppCommon.Tap element when ready     ${feedback.txt_done}
        AppiumLibrary.Wait until page does not contain element      ${feedback.txt_thank}
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        DobbyAppCommon.Tap element when ready     ${feedback.success}
        AppiumLibrary.Wait until page does not contain element      ${feedback.txt_thank}
    END

Click x button to close thank you popup
    IF   "${platform}" == "${platform_list['android']}"
        DobbyAppCommon.Tap element when ready      ${feedback.thank_icon_button}
        AppiumLibrary.Wait until page does not contain element      ${feedback.txt_thank}
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        DobbyAppCommon.Tap element when ready      ${feedback.txt_your_comment_success}
        AppiumLibrary.Wait until page does not contain element      ${feedback.txt_thank}
    END

Verify feedback popup not display
    AppiumLibrary.Page should not contain element     ${feedback.txt_give_feedback_title}

# iOS

Verify rating popup display
    DobbyAppCommon.Wait until element is visible except stale   ${feedback.txt_enjoying_maknet}
    DobbyAppCommon.Wait until element is visible except stale   ${feedback.rating}

Click not now button on rating popup
    DobbyAppCommon.Tap element when ready   ${feedback.not_now}

Verify rating popup not display
    AppiumLibrary.Page should not contain element   ${feedback.txt_enjoying_maknet}
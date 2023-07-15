*** Settings ***
Resource        ../pages/feedback_page.resource

*** Keywords ***
Skip to give a feedback
    feedback_page.Verify feedback popup display
    feedback_page.Click x button to close feedback popup

Give a feedback
    [Documentation]   ${thumps} must be  'thumps-up'  or 'thumps-up'
    [Arguments]     ${thumps}   ${message}
    IF   "${platform}" == "${platform_list['android']}"
        IF   '${thumps}'=='${feedback_data['thumbs-up']}'
            feedback_page.Click thumbs-up 
        ELSE IF    '${thumps}'=='${feedback_data['thumbs-down']}'
            feedback_page.Click thumbs-down 
        END
        feedback_page.Enter feedback on feedback box    ${message}
        feedback_page.Click send feedback
        feedback_page.Verify thank you popup display
        feedback_page.Tap done button on thank you popup
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        IF   '${thumps}'=='${feedback_data['thumbs-up']}'
            feedback_page.Click thumbs-up 
        ELSE IF     '${thumps}'=='${feedback_data['thumbs-down']}'
            feedback_page.Click thumbs-down 
        END
        feedback_page.Enter feedback on feedback box    ${message}
        feedback_page.Click send feedback
        ${rating_show}    Run keyword and return status   Skip to rating if popup display
        feedback_page.Verify thank you popup display
        feedback_page.Tap done button on thank you popup    
    END    

Skip to feedback if popup display
    ${feedback_show}    Run keyword and return status   DobbyAppCommon.Wait until element is visible except stale    ${feedback.txt_give_feedback_title}       timeout=${long_timeout}
    Run keyword if      '${feedback_show}'=='${true}'   feedback_page.Click x button to close feedback popup

# iOS

Skip to rating if popup display
    ${rating_show}    Run keyword and return status   feedback_page.Verify rating popup display
    Run keyword if      '${rating_show}'=='${True}'   feedback_page.Click not now button on rating popup
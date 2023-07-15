*** Settings ***
Resource        ../pages/onboarding_page.resource

*** Keywords ***
Skip onboarding process if exist
    onboarding_page.Verify CVP page appear            ${short_timeout}
    onboarding_page.Click skip
    onboarding_feature.Accpect all privacy if exist
    onboarding_page.Click start shoppping

Skip onboarding process if register
    onboarding_page.Verify CVP page appear            ${short_timeout}
    onboarding_page.Click skip
    onboarding_feature.Accpect all privacy if exist
    onboarding_feature.Click create account

Verify CVP content - online market
    onboarding_page.Verify CVP content  ${mobile['onboarding']['label']['titleSlide1']} 
    onboarding_page.Verify CVP content  ${mobile['onboarding']['label']['subtitleSlide1']} 

Verify CVP content - product quantity
    onboarding_page.Verify CVP content  ${mobile['onboarding']['label']['titleSlide2']} 
    onboarding_page.Verify CVP content  ${mobile['onboarding']['label']['subtitleSlide2']} 

Verify CVP content - delivery
    onboarding_page.Verify CVP content  ${mobile['onboarding']['label']['titleSlide3']} 
    onboarding_page.Verify CVP content  ${mobile['onboarding']['label']['subtitleSlide3']} 

Accpect all privacy if exist
    ${privacy_content_displayed}      Run keyword and return status    onboarding_page.Verify Privacy and content page display
    IF  ${privacy_content_displayed}
        onboarding_page.Click accept all privacy content
    END

Click next on CVP 3 page
    onboarding_page.Verify CVP content  ${mobile['onboarding']['label']['titleSlide1']} 
    onboarding_page.Click next
    onboarding_page.Verify CVP content  ${mobile['onboarding']['label']['titleSlide2']} 
    onboarding_page.Click next
    onboarding_page.Verify CVP content  ${mobile['onboarding']['label']['titleSlide3']}

Click back on CVP 3 page
    onboarding_page.Verify CVP content  ${mobile['onboarding']['label']['titleSlide3']} 
    onboarding_page.Click back
    onboarding_page.Verify CVP content  ${mobile['onboarding']['label']['titleSlide2']} 
    onboarding_page.Click back
    onboarding_page.Verify CVP content  ${mobile['onboarding']['label']['titleSlide1']}

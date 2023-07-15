*** Settings ***
Resource        ../pages/more_page.resource

*** Keywords ***
Verify more page menu
    more_page.Verify CS contact method
    more_page.Verify FAQ menu
    more_page.Verify inform Customer service office hours
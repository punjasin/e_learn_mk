*** Settings ***
Resource        ../pages/kyc_page.resource

*** Keywords ***
Input business info and click continue
    [Arguments]     ${name}=${kyc['name']}    ${business}=${kyc['business_name']}     ${phone}=${kyc['mobile_no']}
    IF   "${platform}" == "${platform_list['android']}"
        kyc_page.Fill name and surname      ${name}
        kyc_page.Fill business name     ${business}
        kyc_page.Fill phone number      ${phone}
        DobbyAppCommon.Hide keyboard until success
        kyc_page.Tap continue
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        kyc_page.Fill name and surname      ${name}
        kyc_page.Fill business name     ${business}
        kyc_page.Fill phone number      ${phone}
        mobile_common.Tap finish to hide keyboard
        kyc_page.Tap continue
    END
    
Click do later if kyc exist
    ${status}       Run keyword and return status       kyc_page.Verify current page is KYC
    IF  ${status}
        kyc_page.Click do later
    END

Input business type and detail for restaurant and click finish
    [Arguments]     ${foodtype}=${mobile_additional['kyc']['foodtype']['drinks']}      ${branch}=${mobile_additional['kyc']['branch']['1_branch']}  
    ...     ${average_seat}=${mobile_additional['kyc']['average_seat']['less_than_20']}      ${customer_pay}=${mobile_additional['kyc']['customer_pay']['less_than_50']}  
    kyc_page.Verify current page is KYC step 2
    kyc_page.Click select business type     ${mobile_additional['kyc']['restaurant']['business_restaurant']}
    kyc_page.Tap continue
    kyc_page.Click select kyc detail    ${mobile_additional['kyc']['restaurant']['restaurant_detail_l1']}    ${foodtype}         
    kyc_page.Click select kyc detail    ${mobile_additional['kyc']['restaurant']['restaurant_detail_l2']}    ${branch}  
    kyc_page.Tap continue
    kyc_page.Click select kyc detail    ${mobile_additional['kyc']['restaurant']['restaurant_detail_l3']}    ${average_seat}
    kyc_page.Click select kyc detail    ${mobile_additional['kyc']['restaurant']['restaurant_detail_l4']}    ${customer_pay}
    kyc_page.Tap finish fill information
    kyc_page.Verify thank you popup

Input business type and detail for hotel and click finish
    [Arguments]     ${branch}=${mobile_additional['kyc']['branch']['more_than_1']['more_1_branch']}      ${rooms}=${mobile_additional['kyc']['rooms']['less_than_10']}     ${stars}=${mobile_additional['kyc']['stars']['less_than_2']}     
    kyc_page.Verify current page is KYC step 2
    kyc_page.Click select business type     ${mobile_additional['kyc']['hotel']['business_hotel']}
    kyc_page.Tap continue
    kyc_page.Click select kyc detail    ${mobile_additional['kyc']['hotel']['hotel_detail_l1']}    ${branch}
    Run keyword if  '${branch}'=='${mobile_additional['kyc']['branch']['more_than_1']['more_1_branch']}'    
    ...     kyc_page.Fill optional field when select other      ${mobile_additional['kyc']['hotel']['hotel_detail_l1']}          ${mobile_additional['kyc']['branch']['more_than_1']['number_branch']}
    kyc_page.Click select kyc detail    ${mobile_additional['kyc']['hotel']['hotel_detail_l2']}    ${rooms}  
    kyc_page.Tap continue
    kyc_page.Click select kyc detail    ${mobile_additional['kyc']['hotel']['hotel_detail_l3']}    ${stars}
    kyc_page.Tap finish fill information
    kyc_page.Verify thank you popup

Input business type and detail for catering and click finish
    [Arguments]     ${foodtype}=${mobile_additional['kyc']['foodtype']['bakery']}      ${served}=${mobile_additional['kyc']['served_per_month']['21_to_40']}      ${customer_pay}=${mobile_additional['kyc']['customer_pay']['less_than_50']}  
    kyc_page.Verify current page is KYC step 2
    kyc_page.Click select business type     ${mobile_additional['kyc']['catering']['business_catering']}
    kyc_page.Tap continue
    kyc_page.Click select kyc detail    ${mobile_additional['kyc']['catering']['catering_detail_l1']}    ${foodtype}         
    kyc_page.Click select kyc detail    ${mobile_additional['kyc']['catering']['catering_detail_l2']}    ${served}  
    kyc_page.Tap continue
    kyc_page.Click select kyc detail    ${mobile_additional['kyc']['catering']['catering_detail_l3']}    ${customer_pay}
    kyc_page.Tap finish fill information
    kyc_page.Verify thank you popup

Verify customer business type should be
    [Arguments]     ${type}     ${expected}
    Should contain     ${type}        ${expected}
    

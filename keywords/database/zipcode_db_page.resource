***Settings***
Resource        ../../common/database/db_common.resource

*** Keywords ***
Get all sub district by zipcode
    [Arguments]     ${zipcode}      ${db_detail}
    db_common.Connect to postgres database      ${db_detail}
    IF    "${lang}"=="th"
        ${sub_district_lang}    Set variable    thailand_sub_district."nameTh"
    ELSE
        ${sub_district_lang}    Set variable    thailand_sub_district."nameEn"
    END
    ${query} =   Catenate        select ${sub_district_lang} from thailand_sub_district
    ...                         inner join thailand_zip_code_districts_thailand_district
    ...                         on thailand_sub_district."districtId" = thailand_zip_code_districts_thailand_district."thailandDistrictId" 
    ...                         where thailand_zip_code_districts_thailand_district."thailandZipCodeId" = '${zipcode}'
    ...                         order by thailand_sub_district."nameEn" asc
    @{queryResults}   DatabaseLibrary.query     ${query}
    ${total_data}     Get length      ${queryResults}
    ${sub_district_data}     Create list
    FOR   ${index}    IN RANGE     0    ${total_data}
        Collections.Append to list      ${sub_district_data}   @{queryResults[${index}]}
    END
    db_common.Disconnect from database
    [Return]        ${sub_district_data}

Get store number product 1P
    [Arguments]    ${zipcode_number}    ${subdistrict}    ${db_detail}
    db_common.Connect to postgres database      ${db_detail}
    IF    "${lang}"=="th"
        ${sub_district_lang}    Set variable    subdistrict_th
    ELSE
        ${sub_district_lang}    Set variable    subdistrict_en
    END
    ${query} =   Catenate        select store_code from public.store_zipcode where zipcode ='${zipcode_number}' 
    ...    and ${sub_district_lang} ='${subdistrict}'
    ...    and  store_code  NOT ILIKE '3P_%'
    @{queryResults}   DatabaseLibrary.query     ${query}
    ${result}         Set variable          @{queryResults[0]}
    db_common.Disconnect from database
    ${result}         Convert to string     ${result}
    [Return]          ${result}
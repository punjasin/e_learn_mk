*** Settings ***
Resource        ../pages/favourite_page.resource
Resource        ../pages/favourite_detail_page.resource
Resource        ../pages/order_detail_page.resource
Resource        ./search_feature.resource

*** Keywords ***
Create new favourite list with name
    [Arguments]     ${name}     ${first_create}=${False}
    favourite_page.Click create new favourite list button
    favourite_page.Modal create new favourite list should display
    favourite_page.Enter name favourite list on modal  ${name}
    favourite_page.Click create button on on modal new favourite list
    favourite_page.Toast message should display create successful wtih list name   ${name}

Edit favourite list name
    [Arguments]     ${originalname}     ${newname}
    IF   "${platform}" == "${platform_list['android']}"
        favourite_detail_page.Click edit list name button on detail page  ${originalname}
        favourite_detail_page.Modal edit favourite list should display  ${originalname}
        favourite_page.Enter name favourite list on modal  ${newname}
        favourite_detail_page.Click update button on on modal edit favourite list
        favourite_detail_page.Toast message should display update list successful
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        favourite_page.Click edit list name button on detail page        ${originalname}
        favourite_page.Modal edit favourite list should display          ${originalname}
        favourite_page.Enter name favourite list on modal                ${newname}
        favourite_page.Click update button on on modal edit favourite list
        favourite_page.Toast message should display update list successful
    END

Delete favourite list with name
    [Arguments]     ${name}
    IF   "${platform}" == "${platform_list['android']}"
        favourite_page.Swipe left on list for delete  ${name}
        favourite_page.Click delete list button on list page  ${name}
        favourite_page.Confirm delete list on modal confirm delete list  ${name}
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        mobile_common.Tap favourite list menu
        favourite_page.Swipe left on list for delete  ${name}
        favourite_page.Confirm delete list on modal confirm delete list  ${name}
    END

Go to favourite lists page
    IF   "${platform}" == "${platform_list['android']}"
        mobile_common.Tap favourite list menu
        ${in_list_page}=    Run Keyword and return status   DobbyAppCommon.Wait until element is visible except stale  ${favourite_features.add_favourite_list_btn}   timeout=5s
        Run Keyword If   '${in_list_page}'!='${true}'    mobile_common.Tap favourite list menu
        AppiumLibrary.Wait Until Element Is Visible   ${favourite_features.txt_add_list}
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        mobile_common.Tap favourite list menu
        ${in_list_page}=    Run Keyword and return status   DobbyAppCommon.Wait until element is visible except stale  ${favourite_features.favourite_heart}   timeout=5s
        Run Keyword If   '${in_list_page}'!='${true}'    mobile_common.Tap favourite list menu
        AppiumLibrary.Wait Until Element Is Visible       ${favourite_features.txt_add_list}
    END

Delete favourite lists with name
    [Arguments]     @{names}
    IF   "${platform}" == "${platform_list['android']}"
        Go to favourite lists page
        FOR     ${name}     IN  @{names}
            ${no_list}=     Run Keyword and return status   AppiumLibrary.Page Should Contain Element   ${favourite_features.txt_not_list}
            Exit For Loop If	'${no_list}' == '${true}'	

            ${found_list}=   Run Keyword and return status    favourite_page.List should display on favourite list    ${name}
            Run Keyword If   '${found_list}'=='${true}'  Delete favourite list with name     ${name}
            ...     ELSE     Log     Not found list "${name}"  
        END
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        Go to favourite lists page
        FOR     ${name}     IN  @{names}
            ${no_list}=     Run Keyword and return status   AppiumLibrary.Page Should Contain Element   ${favourite_features.txt_not_list}
            Exit For Loop If	'${no_list}' == '${true}'	
        
            ${found_list}=   Run Keyword and return status    favourite_page.List should display on favourite list    ${name}
            Run Keyword If   '${found_list}'=='${true}'  Delete favourite list with name     ${name}
            ...     ELSE     Log     Not found list "${name}"  
        END
    END

Delete favourite list on list detail
    [Arguments]     ${name}
    IF   "${platform}" == "${platform_list['android']}"
        favourite_detail_page.Click delete list button on detail page  ${name}
        favourite_page.Confirm delete list on modal confirm delete list  ${name}
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        favourite_detail_page.Tap delete list button on detail page      ${name}
        favourite_page.Confirm delete list on modal confirm delete list  ${name}
    END

Search product and add to favourite list
    [Arguments]     ${productname}      @{name}
    IF   "${platform}" == "${platform_list['android']}"
        mobile_common.Tap shopping menu  accept_popup=False
        search_feature.Search product and go to PDP  ${productname}
        favourite_feature.Add product to favourite list     @{name}
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        mobile_common.Tap shopping menu
        search_feature.Search product and go to PDP  ${productname}
        favourite_feature.Add product to favourite list     @{name}
    END

Add product to favourite list
    [Arguments]     @{name}
    IF   "${platform}" == "${platform_list['android']}"
        favourite_page.Click favourite icon in PDP
        FOR     ${name}     IN      @{name}
            favourite_page.Select favourite list on modal list of favourite list    ${name}  
        END

        ${list_count}	    Get Matching Xpath Count	${favourite_features.favourite_list_item}
        ${checkbox_count}	Get Matching Xpath Count	${favourite_features.checkbox_filled_icon}

        favourite_page.Click save button on modal list of favourite list
        IF      '${list_count}'=='1'
            favourite_page.Toast message should display update add product to list successful
        ELSE
            IF  '${checkbox_count}'=='1'
                favourite_page.Toast message should display update add product to list successful
            ELSE
                favourite_page.Toast message should display update add product to more list successful      ${list_count}
            END
        END
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        favourite_page.Click favourite icon in PDP
        FOR     ${name}     IN      @{name}
            favourite_page.Select favourite list on modal list of favourite list    ${name}  
        END
        favourite_page.Click save button on modal list of favourite list
    END

Delete product from favourite list by type quantity 0
    [Arguments]     ${product}
    IF   "${platform}" == "${platform_list['android']}"
        favourite_detail_page.Type product quantity on list  ${product}  ${0}
        favourite_detail_page.Verify modal confirm delete product from list display  ${product}
        favourite_detail_page.Confirm delete product on modal confirm delete product from list  ${product}
        favourite_detail_page.Toast message should display update remove product to list successful
        favourite_detail_page.List detail should not display product  ${product}
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        favourite_detail_page.Type product quantity on list                                     ${product}  ${0}
        favourite_detail_page.Verify modal confirm delete product from list display             ${product}
        favourite_detail_page.Confirm delete product on modal confirm delete product from list  ${product}
        favourite_detail_page.Toast message should display update remove product to list successful
        favourite_detail_page.List detail should not display product                            ${product}
    END

Delete product from favourite list by swipe
    [Arguments]     ${product}
    IF   "${platform}" == "${platform_list['android']}"
        favourite_detail_page.Swipe left on product list for delete   ${product}
        favourite_detail_page.Click delete product button on list detail page  ${product}
        favourite_detail_page.Verify modal confirm delete product from list display  ${product}
        favourite_detail_page.Confirm delete product on modal confirm delete product from list  ${product}
        favourite_detail_page.Toast message should display update remove product to list successful
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        favourite_detail_page.Swipe left on product list for delete                                ${product}
        favourite_detail_page.Click delete product button on list detail page                      ${product}
        favourite_detail_page.Verify modal confirm delete product from list display                ${product}
        favourite_detail_page.Confirm delete product on modal confirm delete product from list     ${product}
        favourite_detail_page.Toast message should display update remove product to list successful
    END

List detail display product shipment by maknet on product
    [Arguments]     ${product}
    IF   "${platform}" == "${platform_list['android']}"
        favourite_detail_page.List detail display product shipment on product     ${product}       จัดส่งโดย Makro PRO
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        favourite_detail_page.List detail display product shipment on product     ${product}       จัดส่งโดย Makro PRO
    END

List detail display product shipment by partner on product
    [Arguments]     ${product}      ${sellername}
    IF   "${platform}" == "${platform_list['android']}"
        favourite_detail_page.List detail display product shipment on product     ${product}        ${sellername}
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        favourite_detail_page.List detail display product shipment on product     ${product}        ${sellername}
    END

Verify quantity and detail of product after click increase
    [Arguments]     ${product}      ${product_qty}
    favourite_detail_page.Click increase quantity button on list       ${product}
    favourite_detail_page.List detail display product with quantity    ${product}    ${product_qty}

Verify quantity and detail of product after click decrease
    [Arguments]     ${product}      ${product_qty}
    favourite_detail_page.Click decrease quantity button on list       ${product}
    favourite_detail_page.List detail display product with quantity    ${product}    ${product_qty}

Verify quantity and detail of product after click adjust
    [Arguments]     ${product}      ${product_qty}
    favourite_detail_page.Type product quantity on list                ${product}    ${product_qty}
    favourite_detail_page.List detail display product with quantity    ${product}    ${product_qty}

Process to login
    mobile_common.Tap favourite list menu
    favourite_page.Tap login button

Navigate and verify favourite list page not login
    mobile_common.Tap favourite list menu
    favourite_page.Verify favourite list page not login

# Android

Add product to favourite list from order history
    [Arguments]     @{name}     ${product}
    ${basket_list_item_gid_locator}    String.Replace string    ${favourite_features.basket_list_item_gid}    {{product}}    ${product}
    DobbyAppCommon.Tap element when ready       ${basket_list_item_gid_locator}
    FOR     ${name}     IN      @{name}
        favourite_page.Select favourite list on modal list of favourite list    ${name}  
    END

    ${list_count}	    Get Matching Xpath Count	${favourite_features.favourite_list_item}
    ${checkbox_count}	Get Matching Xpath Count	${favourite_features.checkbox_filled_icon}

    favourite_page.Click save button on modal list of favourite list
    IF      '${list_count}'=='1'
        favourite_page.Toast message should display update add product to list successful
    ELSE
        IF  '${checkbox_count}'=='1'
            favourite_page.Toast message should display update add product to list successful
        ELSE
            favourite_page.Toast message should display update add product to more list successful      ${list_count}
        END
    END

Navigate to list detail page
    [Arguments]    ${name}
    mobile_common.Tap favourite list menu
    favourite_page.Click on list for view list detail    ${name}

Add to favourite list from order detail page
    [Arguments]    ${name}
    order_detail_page.Click add all items to favorite list
    favourite_page.Select favourite list on modal list of favourite list    ${name}
    favourite_page.Click save button on modal list of favourite list
    favourite_page.Toast message should display update add product to list successful

Create new favourite list with name from order detail page
    [Arguments]     ${name}
    favourite_page.Click create new favourite list button
    favourite_page.Modal create new favourite list should display
    favourite_page.Enter name favourite list on modal  ${name}
    favourite_page.Click create button on on modal new favourite list

Create new favourite list with name from PDP
    [Arguments]     ${name}     ${no_list}=False
    IF  '${no_list}'=='False'
        Click create new favourite list button
    END
    favourite_page.Modal create new favourite list should display
    favourite_page.Enter name favourite list on modal       ${name}
    favourite_page.Click create button on on modal new favourite list
    favourite_page.Verify favourite list was selected        ${name}
    favourite_page.Click save button on modal list of favourite list

Click add all product to basket button with 0 quantity
    favourite_detail_page.Verify add all product to basket button should enable
    DobbyAppCommon.Tap element when ready     ${favourite_features.add_all_product_to_basket}
    basket_page.Verify unable to add product to basket popup
    basket_page.Click ok on popup

Click trash button and delete product from favourite list
    [Arguments]     ${product}
    favourite_detail_page.Click trash button on list  ${product}
    favourite_detail_page.Verify modal confirm delete product from list display  ${product}
    favourite_detail_page.Confirm delete product on modal confirm delete product from list  ${product}
    favourite_detail_page.Toast message should display update remove product to list successful
    favourite_detail_page.List detail should not display product  ${product}

Remove product from favourite list
    [Arguments]     @{name}
    favourite_page.Verify create new list displayed after tap heart icon
    FOR     ${name}     IN      @{name}
        favourite_page.Select favourite list on modal list of favourite list    ${name}  
    END
    favourite_page.Click save button on modal list of favourite list
    favourite_detail_page.Toast message should display update remove product to list successful	

# iOS

Delete favourite list with name by button
    [Arguments]     ${name}
    # favourite_page.Swipe left on list for delete  ${name}         #not ready
    favourite_page.Click delete list name button on detail page        ${name}
    favourite_page.Verify modal confirm delete list display            ${name}
    favourite_page.Confirm delete list on modal confirm delete list    ${name}

Delete product to favourite list 
    [Arguments]     @{name}
    favourite_page.Click favourite icon in PDP
    FOR     ${name}     IN      @{name}
        favourite_page.Select favourite list on modal list of favourite list    ${name}  
    END
    favourite_page.Click save button on modal list of favourite list
    favourite_page.Toast message should display update delete product to list successful

Create favourite list and add product in on PDP
    [Arguments]      ${name}    ${have_old_list}=${false}
    favourite_page.Click favourite icon in PDP
    Run keyword if  '${have_old_list}'=='${true}'    favourite_page.Click create new favourite list button
    favourite_page.Modal create new favourite list should display
    favourite_page.Enter name favourite list on modal        ${name}
    favourite_page.Click create button on on modal new favourite list
    favourite_page.Verify favourite list was selected        ${name}
    favourite_page.Click save button on modal list of favourite list

Verify quantity changed after tab decrease button
    [Arguments]     ${product_name}     ${decrease_amount}
    # currently we can’t inspect locator of increase quantity button on ios. 
    # As the result, the test fails. Once the problem is fixed by Dev, we will update locator to new one
    favourite_detail_page.Click decrease quantity button on list        ${product_name}
    ${expected_del_qty}    mobile_common.Get new qty after click decrease button   ${default['qty_favorite']}    ${decrease_amount}
    favourite_detail_page.List detail display product with quantity     ${product_name}  ${expected_del_qty}
    favourite_feature.Click trash button and delete product from favourite list     ${product_name}

Verify target badge display after add to favourite list
    [Arguments]     ${favourite_name}       ${badge_name}       ${product_name}
    favourite_page.Click favourite icon in PDP
    favourite_feature.Create new favourite list with name from PDP    ${favourite_name}    no_list=${True}
    favourite_page.Verify favourite icon that filled
    mobile_common.Tap favourite list menu
    favourite_page.Click on list for view list detail                 ${favourite_name}
    favourite_page.Verify target badge display on product in favourite list  ${badge_name}  ${product_name}
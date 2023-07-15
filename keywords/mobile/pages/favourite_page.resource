*** Settings ***
Resource        ../../../resources/locators/${platform}/favourite_locator.resource
Resource        ../../../resources/locators/${platform}/common_locator.resource
Resource        ../../../common/mobile/mobile_common.resource

*** Keywords ***
User location should be favourite list page
    DobbyAppCommon.Wait until element is visible except stale   ${favourite.txt_my_list}

Favourite list page should suggestion to login
    [Arguments]     
    User location should be favourite list page
    DobbyAppCommon.Wait until element is visible except stale   ${favourite.txt_please_login_for_use_mylist}
    DobbyAppCommon.Wait until element is visible except stale   ${favourite.txt_login}
    DobbyAppCommon.Wait until element is visible except stale   ${favourite.txt_create_new_account}

Favourite list page should display blank favourite list
    User location should be favourite list page
    DobbyAppCommon.Wait until element is visible except stale   ${favourite.txt_now_no_list}
    DobbyAppCommon.Wait until element is visible except stale   ${favourite.add_to_list_for_next_order}
    DobbyAppCommon.Wait until element is visible except stale   ${favourite.txt_add_new_list}

Click create new favourite list button
    [Arguments]     ${first_create}=${False}
    IF   "${platform}" == "${platform_list['android']}"
        DobbyAppCommon.Tap element when ready   ${favourite.txt_add_new_list}
        favourite_page.Modal create new favourite list should display
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        ${create_first_list}    Run keyword and return status    AppiumLibrary.Wait until element is visible    ${favourite.txt_add_new_list_1}
        IF    ${create_first_list} or ${first_create}
            DobbyAppCommon.Tap element when ready    ${favourite.txt_add_new_list_1}
        ELSE
            DobbyAppCommon.Tap element when ready    ${favourite.txt_add_new_list_favourite_list_btn}
        END
    END

Modal create new favourite list should display
    DobbyAppCommon.Wait until element is visible except stale   ${favourite.txt_create_new_list}
    DobbyAppCommon.Wait until element is visible except stale   ${favourite.list_name}
    DobbyAppCommon.Wait until element is visible except stale   ${favourite.specify_up_characters} 
    DobbyAppCommon.Wait until element is visible except stale   ${favourite.txt_create_list}
    

Enter name favourite list on modal
    [Arguments]     ${name}
    IF   "${platform}" == "${platform_list['android']}"
        DobbyAppCommon.Tap element when ready   ${favourite.edittext}
        DobbyAppCommon.Input text to element when ready      ${favourite.edittext}  ${name}
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        DobbyAppCommon.Input text to element when ready  ${favourite.input_container}  ${name}
    END

Click create button on on modal new favourite list
    DobbyAppCommon.Tap element when ready   ${favourite.txt_create_list} 

Toast message should display create successful wtih list name 
    [Arguments]     ${listname}
    ${create_list_success_locator}    String.Replace string    ${favourite.create_list_success}    {{listName}}    ${listname}
    mobile_common.Toast message should display and close   ${create_list_success_locator}

List should display on favourite list
    [Arguments]     ${listname}
    IF   "${platform}" == "${platform_list['android']}"
        ${favourite_list_item_locator}    String.Replace string    ${favourite.favourite_list_item}    {{listname}}    ${listname}
        DobbyAppCommon.Wait until element is visible except stale  ${favourite_list_item_locator}         timeout=5s
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        ${listname_last_locator}    String.Replace string    ${favourite.listname_last}    {{listname}}    ${listname}
        DobbyAppCommon.Wait until element is visible except stale   ${listname_last_locator}
    END

List should not display on favourite list
    [Arguments]     ${listname}
    IF   "${platform}" == "${platform_list['android']}"
        ${favourite_list_item_locator}    String.Replace string    ${favourite.favourite_list_item}    {{listname}}    ${listname}
        AppiumLibrary.Wait until page does not contain element   ${favourite_list_item_locator}
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        ${listname_last_locator}    String.Replace string    ${favourite.listname_last}    {{listname}}    ${listname}
        AppiumLibrary.Wait until page does not contain element   ${listname_last_locator}
    END

Swipe left on list for delete
    [Arguments]     ${listname}
    IF   "${platform}" == "${platform_list['android']}"
        ${favourite_list_item_locator}    String.Replace string    ${favourite.favourite_list_item}    {{listname}}    ${listname}
        ${1pos}=    Get Element Location    ${favourite_list_item_locator}
        Swipe   500      ${1pos}[y]      ${1pos}[x]     ${1pos}[y]     #swipe left
        DobbyAppCommon.Wait until element is visible except stale    ${favourite.txt_delete}
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        ${txt_listname_locator}    String.Replace string    ${favourite.txt_listname}    {{listname}}    ${listname}
        DobbyAppCommon.Wait until element is visible except stale    ${txt_listname_locator}
        ${getsize} =   AppiumLibrary.Get Element Size        ${txt_listname_locator}
        ${getcoor} =   Get element location    ${txt_listname_locator}
        ${center_x1}   Evaluate    ${getcoor['x']}-${getsize['width']}/2
        ${center_x2}   Evaluate    ${getcoor['x']}+${getsize['width']}/2
        Swipe         ${center_x2}  ${getcoor['y']}  ${center_x1}  ${getcoor['y']}
        Tap       chain=**/XCUIElementTypeOther[`label == "${global['delete']}" AND accessible ==${true} AND visible == ${true}`]
    END

Verify modal confirm delete list display
    [Arguments]     ${listname}
    IF   "${platform}" == "${platform_list['android']}"
        DobbyAppCommon.Wait until element is visible except stale   ${favourite.txt_delete_this_list}
        ${txt_want_to_delete_this_list_locator}    String.Replace string    ${favourite.txt_want_to_delete_this_list}    {{listName}}   ${listname}
        DobbyAppCommon.Wait until element is visible except stale   ${txt_want_to_delete_this_list_locator}
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        DobbyAppCommon.Wait until element is visible except stale   ${favourite.txt_delete_this_list}
    END

Confirm delete list on modal confirm delete list
    [Arguments]     ${listname}
    IF   "${platform}" == "${platform_list['android']}"
        DobbyAppCommon.Tap element when ready  ${favourite.txt_delete_list}
        mobile_common.Wait until loading complete
        favourite_page.List should not display on favourite list    ${listname}
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        DobbyAppCommon.Tap element when ready   ${favourite.txt_delete_list}
    END

Cancel delete list on modal confirm delete list
    DobbyAppCommon.Tap element when ready  ${favourite.txt_cancel}

Click on list for view list detail
    [Arguments]     ${listname}
    IF   "${platform}" == "${platform_list['android']}"
        ${favourite_list_item_locator}    String.Replace string    ${favourite.favourite_list_item}    {{listname}}    ${listname}
        DobbyAppCommon.Tap element when ready     ${favourite_list_item_locator}
        favourite_detail_page.User location should be list detail of list     ${listname}
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        ${favourite_list_item_listname_locator}    String.Replace string    ${favourite.favourite_list_item_listname}    {{listname}}    ${listname}
        DobbyAppCommon.Tap element when ready     ${favourite_list_item_listname_locator}
        favourite_detail_page.User location should be list detail of list     ${listname}
    END

Click favourite icon in PDP
    DobbyAppCommon.Tap element when ready     ${favourite.favourite_heart}

Select favourite list on modal list of favourite list
    [Arguments]     ${listname}
    IF   "${platform}" == "${platform_list['android']}"
        ${back_favourite_list_item_locator}    String.Replace string    ${favourite.back_favourite_list_item}    {{listname}}    ${listname}
        DobbyAppCommon.Tap element when ready    ${back_favourite_list_item_locator}
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        ${favourite_list_item_locator}    String.Replace string    ${favourite.favourite_list_item}    {{listname}}    ${listname}
        DobbyAppCommon.Tap element when ready    ${favourite_list_item_locator}
    END

Click save button on modal list of favourite list
    IF   "${platform}" == "${platform_list['android']}"
        DobbyAppCommon.Tap element when ready    ${favourite.txt_save}
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        DobbyAppCommon.Tap element when ready    ${favourite.btn_save}
    END

Toast message should display update add product to list successful	
    IF   "${platform}" == "${platform_list['android']}"
        mobile_common.Toast message should display and close   ${favourite.update_list_succress}
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        mobile_common.Toast message should display and close   ${favourite.toast_success}
    END

Toast message should display update add product to more list successful
    [Arguments]     ${number} 
    ${save_to_list_locator}    String.Replace string    ${favourite.save_to_list}    {{number}}    ${number}
    mobile_common.Toast message should display and close   ${save_to_list_locator}

Verify favourite icon that filled
    DobbyAppCommon.Wait until element is visible except stale   ${favourite.favourite_heart_filled_icon}

Verify favourite icon that unfilled
    DobbyAppCommon.Wait until element is visible except stale   ${favourite.favourite_heart_unfilled_icon}

Verify favourite list was selected
    [Arguments]     ${listname}
    ${checkbox_filled_icon_locator}    String.Replace string        ${favourite.checkbox_filled_icon}       {{listname}}    ${listname}
    DobbyAppCommon.Wait until element is visible except stale       ${checkbox_filled_icon_locator}

Tap register button
    DobbyAppCommon.Tap element when ready    ${favorite.create_account_btn}

Tap login button
    DobbyAppCommon.Tap element when ready    ${favorite.login_account_btn}

Verify favourite page new account does not have favourite list
    DobbyAppCommon.Wait until element is visible except stale    ${favourite_features.txt_not_list}
    DobbyAppCommon.Wait until element is visible except stale    ${favourite.txt_add_new_list}
    
Verify favourite list page not login
    DobbyAppCommon.Wait until element is visible except stale    ${favourite.favourite_page_not_login}
    DobbyAppCommon.Wait until element is visible except stale    ${favorite.login_account_btn}
    DobbyAppCommon.Wait until element is visible except stale    ${favorite.create_account_btn}

# Android

Favourite list display name on modal
    [Arguments]     ${originalname}
    ${originalname_locator}    String.Replace string    ${favourite.originalname}    {{originalname}}    ${originalname}
    DobbyAppCommon.Wait until element is visible except stale   ${originalname_locator}

Clear form input
    DobbyAppCommon.Clear text when ready           ${favourite.edittext}

Click exit button on modal new favourite list
    ${create_new_list_viewgroup_locator}    String.Replace string    ${favourite.create_new_list_viewgroup}    {{originalname}}    ${originalname}
    DobbyAppCommon.Tap element when ready   ${create_new_list_viewgroup_locator}

Click delete list button on list page
    [Arguments]     ${listname}
    DobbyAppCommon.Tap element when ready  ${favourite.txt_delete}
    sleep  2s
    favourite_page.Verify modal confirm delete list display    ${listname}

Click favourite icon that filled
    DobbyAppCommon.Tap element when ready     ${favourite.favourite_heart_filled_icon}

List should display on favourite list in order
    [Arguments]     ${listname}     ${ordering}
    ${ordering_locator}    String.Replace string    ${favourite.ordering}    {{ordering}}    ${ordering}
    Element attribute should match    ${ordering_locator}      text       ${listname} 

# Favourite list should contain product item     #not ready to implement due to makroclick migration
#     [Arguments]     ${favourite_list_name}
#     FOR     ${i}    IN RANGE    1   4
#         ${status}       Run keyword and return status       mobile_common.Wait until element is visible except stale  xpath=//android.view.ViewGroup[contains(@content-desc,"favourite_item_list_item")]   timeout=${short_timeout}
#         IF  '${status}'=='False'
#             mobile_common.tap basket menu
#             mobile_common.Click favourite list menu
#             favourite_page.Click on list for view list detail  ${favourite_list_name}
#         END
#         Exit for loop if        ${status}
#     END

#on order detail page
Verify favourite icon that filled on order detail page
    [Arguments]     ${product_name}
    ${product_favourite_heart_filled_icon_locator}    String.Replace string    ${favourite.product_favourite_heart_filled_icon}    {{product_name}}    ${product_name}
    DobbyAppCommon.Wait until element is visible except stale   ${product_favourite_heart_filled_icon_locator}

Verify favourite icon that unfilled on order detail page
    [Arguments]     ${product_name}
    ${product_favourite_heart_unfilled_icon_locator}    String.Replace string    ${favourite.product_favourite_heart_unfilled_icon}    {{product_name}}    ${product_name}
    DobbyAppCommon.Wait until element is visible except stale   ${product_favourite_heart_unfilled_icon_locator}
	
Enable favourites for order details via debug menu
    AppiumLibrary.Long Press    ${favourite.txt_basket}    duration=3000
    DobbyAppCommon.Wait until element is visible except stale   ${favourite.enable_favourites_details}
    AppiumLibrary.Element Attribute Should Match    ${favourite.enable_favourites_details_switch}    text    OFF
    DobbyAppCommon.Tap element when ready   ${favourite.enable_favourites_details_switch}
    AppiumLibrary.Element Attribute Should Match    ${favourite.enable_favourites_details_switch}    text    ON
    DobbyAppCommon.Tap element when ready   ${favourite.iconIcon}

Verify products title in favorite list
    [Arguments]     @{products_name}
    FOR    ${name}     IN      @{products_name}
        ${txt_name_locator}    String.Replace string    ${favourite.txt_name}    {{name}}    ${name}
        DobbyAppCommon.Wait until element is visible except stale   ${txt_name_locator}
    END

Verify products have unavailable tags
    [Arguments]     @{products_name}
    FOR    ${name}     IN      @{products_name}
        ${txt_name_out_of_area_locator}    String.Replace string    ${favourite.txt_name_out_of_area}    {{name}}    ${name}
        DobbyAppCommon.Wait until element is visible except stale   ${txt_name_out_of_area_locator}
    END

Click add all items to the basket button
    mobile_common.Find element                 ${favourite.add_all_to_basket}
    DobbyAppCommon.Tap element when ready     ${favourite.add_all_to_basket}

Click product in list details
    [Arguments]     ${product}
    IF   "${platform}" == "${platform_list['android']}"
        ${favourite_item_list_item_product_locator}    String.Replace string    ${favourite.favourite_item_list_item_product}    {{product}}    ${product}
        DobbyAppCommon.Tap element when ready     ${favourite_item_list_item_product_locator}
    ELSE IF    "${platform}" == "${platform_list['ios']}"
        ${txt_label_listname_locator}    String.Replace string    ${favourite_detail.txt_label_listname}    {{listname}}    ${product}
        DobbyAppCommon.Tap element when ready     ${txt_label_listname_locator}
    END  
    

# iOS

Click list name
    [Arguments]     ${list_name}
    ${favourite_list_item_locator}    String.Replace string    ${favourite.favourite_list_item}    {{list_name}}    ${list_name}
    ${txt_listname_locator}    String.Replace string    ${favourite.txt_listname}    {{list_name}}    ${list_name}
    DobbyAppCommon.Tap element when ready               ${favourite_list_item_locator}
    DobbyAppCommon.Wait until element is visible except stale       ${txt_listname_locator}

Click edit list name button on detail page
    [Arguments]     ${listname}
    ${listname_txt_locator}    String.Replace string    ${favourite.listname_txt}    {{list_name}}    ${list_name}
    DobbyAppCommon.Tap element when ready     ${listname_txt_locator}

Modal edit favourite list should display
    [Arguments]     ${originalname}
    DobbyAppCommon.Wait until element is visible except stale   ${favourite.edit_listname}
    ${txt_originalname_locator}    String.Replace string    ${favourite.txt_originalname}    {{originalname}}    ${originalname}
    DobbyAppCommon.Wait until element is visible except stale   ${txt_originalname_locator}
    DobbyAppCommon.Wait until element is visible except stale   ${favourite.specify_up_characters}
    DobbyAppCommon.Wait until element is visible except stale   ${favourite.txt_update}

Input favourite list name
    [Arguments]     ${name}
    DobbyAppCommon.Input text to element when ready         ${favourite.rne_input_text}    ${name}

Click update button on on modal edit favourite list
    DobbyAppCommon.Tap element when ready               ${favourite.txt_update}

Toast message should display update list successful
    mobile_common.Toast message should display and close   ${favourite.list_has_been_updated}

Click delete list name button on detail page
    [Arguments]     ${listname}
    ${listname_locator}    String.Replace string    ${favourite.listname_2}    {{list_name}}    ${list_name}
    DobbyAppCommon.Tap element when ready     ${listname_locator}

Toast message should display update delete product to list successful
    mobile_common.Toast message should display and close   ${favourite.this_product_delete_form_list}

List should display on favourite detail list
    [Arguments]     ${listname}
    ${txt_name_listname_locator}    String.Replace string    ${favourite.txt_name_listname}    {{list_name}}    ${list_name}
    DobbyAppCommon.Wait until element is visible except stale   ${txt_name_listname_locator}

Favourite list page should display blank favourite detail list
    User location should be favourite list page
    DobbyAppCommon.Wait until element is visible except stale   ${favourite.noItems}

Verify create new list displayed after tap heart icon
    favourite_page.Click favourite icon in PDP
    DobbyAppCommon.Wait until element is visible except stale   ${favourite.txt_add_list}

Verify target badge display on product in favourite list
    [Arguments]     ${badge_name}   ${product_name}
    ${badge_locator}     String.Replace string      ${favorite.txt_badge_product}   {{badge_name}}    ${badge_name}
    ${product_with_badge_locator}   String.Replace string       ${badge_locator}   {{product_name}}   ${product_name}
    DobbyAppCommon.Wait until element is visible except stale   ${product_with_badge_locator}
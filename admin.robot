*** Settings ***
Library    SeleniumLibrary
Library    FakerLibrary

*** Variables ***
${admin_url}    http://laraveltest.loc/admin/login

*** Test Cases ***
Scenario: Access test site as admin
    Given the admin opens test site
    When login with invalid credentials should fail
    And login with valid credentials should success to monitor users
Scenario : Edit User
    Given the admin wants to edit user
    And update the account information
Scenario : Filter User
    Given the admin filters the user by name asc and desc
    And input data in search box
    Then search
Scenario : Delete User
    Given the admin wants to delete a user
Scenario : Done 
    Given the admin close test site

*** Keywords ***
The admin opens test site
    Open Browser    ${admin_url}    firefox
    Sleep    2s
    Maximize Browser Window
    Sleep    5s
Login with invalid credentials should fail
    Input Text    id=email    admin@gmail.com
    Input Password    id=password    123456
    Click Button    id=btnLogin
    Sleep    5s    
Login with valid credentials should success to monitor users
    Input Text    id=email    admin@gmail.com
    Input Password    id=password    1q2w3e4r
    Click Button    id=btnLogin
    Sleep    5s    
The admin wants to edit user
    Click Button    id=edit_10
Update the account information
    ${gender}    Random Element    ['Male', 'Female']
    Select from list by value   xpath://select[@name='gender']    ${gender}
    ${education}    Random Element    ['Elementary', 'High School','College','Master','Professional Doctorate']
    Select from list by value   xpath://select[@name='education']    ${education}
    Input Text    name=description    Test Admin
    Click Button    id=userEditFormSubmit   
    Sleep    5s
The admin filters the user by name asc and desc
    Select From List By Value    xpath://select[@name='order_field']    name
    Select From List By Value    xpath://select[@name='order_direction']    asc
    Click Button    id=sort
    Sleep    2s
    Select From List By Value    xpath://select[@name='order_direction']    desc
    Click Button    id=sort
    Sleep    2s
Input data in search box
    Input Text    id=search    robot
Search
    Click Button    id=search_text
    Sleep    5s
The admin wants to delete a user
    Click Button    id=del_10
    Click Button    id=del_confirm_10
    Sleep    5s
The admin close test site
    Close Browser
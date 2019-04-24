*** Settings ***
Library    SeleniumLibrary
Library    FakerLibrary

*** Variables ***
${url}  http://laraveltest.loc/login

*** Test Cases ***
Scenario: User access test site
    Given the user opens test site
Scenario: Register
    Given the user wants to create an account
    When register with existing email should fail
    When register with less than 6 character password should fail
    When register with confirm password that does not match should fail
    When input unique email and atleast 6 character password should success
    And logout to relogin account
    Then login with valid credentials
Scenario : Dashboard Filter
    Given the user filters the table by name asc and desc
    And input data in search box
    Then search
Scenario : Edit User
    Given the user wants to edit account information
    And update the account information
    Then the user wants to view updated account information in dashboard list
Scenario : Done 
    Given the user close test site

*** Keywords ***
The user opens test site
    Open Browser    ${url}    chrome
    Sleep    2s
    Maximize Browser Window
    Sleep    5s
The user wants to create an account
    Click Element    id=register
Register with existing email should fail
    Input Text    name=name    Robot Test
    Input Text    name=email    bagaresrethkevin@gmail.com
    Input Password    name=password    123456
    Input Password    name=password_confirmation    123456
    ${gender}    Random Element    ['Male', 'Female']
    Select from list by value   xpath://select[@name='gender']    ${gender}
    ${education}    Random Element    ['Elementary', 'High School','College','Master','Professional Doctorate']
    Select from list by value   xpath://select[@name='education']    ${education}
    Input Text    name=address    Jomar Store, Cagayan de Oro City
    Input Text    name=description    Test Desc
    Click Button    id=submit
    Sleep    5s
Register with less than 6 character password should fail
    Input Text    name=name    Robot Test
    Input Text    name=email   robot@gmail.com
    Input Password    name=password    1234
    Input Password    name=password_confirmation    1234
    ${gender}    Random Element    ['Male', 'Female']
    Select from list by value   xpath://select[@name='gender']    ${gender}
    ${education}    Random Element    ['Elementary', 'High School','College','Master','Professional Doctorate']
    Select from list by value   xpath://select[@name='education']    ${education}
    Input Text    name=address    Jomar Store, Cagayan de Oro City
    Input Text    name=description    Test Desc
    Click Button    id=submit
    Sleep    5s
Register with confirm password that does not match should fail
    Input Text    name=name    Robot Test
    Input Text    name=email   robot@gmail.com
    Input Password    name=password    123456
    Input Password    name=password_confirmation    1234
    ${gender}    Random Element    ['Male', 'Female']
    Select from list by value   xpath://select[@name='gender']    ${gender}
    ${education}    Random Element    ['Elementary', 'High School','College','Master','Professional Doctorate']
    Select from list by value   xpath://select[@name='education']    ${education}
    Input Text    name=address    Jomar Store, Cagayan de Oro City
    Input Text    name=description    Test Desc
    Click Button    id=submit
    Sleep    5s   
Input unique email and atleast 6 character password should success
    Input Text    name=name    Robot Test
    Input Text    name=email    robot@gmail.com
    Input Password    name=password    123456
    Input Password    name=password_confirmation    123456
    ${gender}    Random Element    ['Male', 'Female']
    Select from list by value   xpath://select[@name='gender']    ${gender}
    ${education}    Random Element    ['Elementary', 'High School','College','Master','Professional Doctorate']
    Select from list by value   xpath://select[@name='education']    ${education}
    Input Text    name=address    Jomar Store, Cagayan de Oro City
    Input Text    name=description    Test Desc
    Click Button    id=submit
Logout to relogin account
    Click Element    id=navbarDropdown
    Click Element    id=logout
    Sleep    5s
Login with valid credentials
    Input Text    id=email    robot@gmail.com
    Input Password    id=password    123456
    Click Button    id=btnLogin
    Sleep    5s
The user filters the table by name asc and desc
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
The user wants to edit account information
    Click Element    id=navbarDropdown
    Click Element    id=profile
    Click Element    id=btnEdit
Update the account information
    ${gender}    Random Element    ['Male', 'Female']
    Select from list by value   xpath://select[@name='gender']    ${gender}
    ${education}    Random Element    ['Elementary', 'High School','College','Master','Professional Doctorate']
    Select from list by value   xpath://select[@name='education']    ${education}   
    Input Text    name=address    Fligno, Cagayan de Oro City
    Input Text    name=description    Test Update
    Click Button    id=save
The user wants to view updated account information in dashboard list
    Click Element    id=navbarDropdown
    Click Element    id=dashboard
    Sleep    5s
The user close test site
    Close Browser
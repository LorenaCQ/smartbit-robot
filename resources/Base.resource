*** Settings ***
Documentation        Arquivo principal do projeto Robot

Library        JSONLibrary

Library        Browser
Library        libs/Account.py
Library        libs/Database.py

Resource       pages/Landing.resource
Resource       pages/Welcome.resource
Resource       pages/Login.resource
Resource       pages/Accounts.resource

Resource       pages/components/Toast.resource
Resource       pages/components/BoxNotice.resource

*** Keywords ***
Start session
    New Browser    browser=chromium    headless=False
    New Page    http://localhost:3000

Get json fixture
    [Arguments]    ${file_name}    ${scenario}

    ${data}    Load Json From File
    ...    ${EXECDIR}/resources/fixtures/${file_name}.json
    ...    encoding=utf-8
    
    [RETURN]    ${data}[${scenario}]
*** Settings ***
Documentation        Suite de testes de adesoes de planos

Resource        ../resources/Base.resource

Test Setup       Start session
Test Teardown    Take Screenshot

*** Test Cases ***

Deve poder realizar uma nova adesao

    ${account}    Create Dictionary
    ...           name=Paulo Cintura
    ...           email=paulo@teste.com
    ...           cpf=26189490050
    
    ${plan}    Set Variable    Plano Black

    ${credit_card}    Create Dictionary
    ...    number=4242424242424242
    ...    holder=Paulo Cintura
    ...    month=12
    ...    year=2023
    ...    cvv=123
    
    Delete Account By Email    ${account}[email]
    Insert Account    ${account}

    Go to login page
    Submit login form    sac@smartbit.com    pwd123
    User is logged in    sac@smartbit.com

    Go to memberships
    Go to enroll form
    Select account          ${account}[name]    ${account}[cpf]

    Select plan             ${plan}
    Fill payment card       ${credit_card}
    
    Click    css=button[type=submit] >> text=Cadastrar

    Toast should be    Matrícula cadastrada com sucesso.
    
    Sleep    5

*** Keywords ***
Go to memberships
    Click    css=a[href="/memberships"]

    Wait For Elements State    css=h1 >> text=Matrículas
    ...    visible    5

Go to enroll form
    Click    css=a[href="/memberships/new"]
    Wait For Elements State    css=h1 >> text=Nova matrícula
    ...    visible    5

Select account
    [Arguments]    ${name}    ${cpf}

    Fill Text    css=input[aria-label=select_account]    	${name}
    Click        css=[data-testid="${cpf}"]

Select plan
    [Arguments]    ${plan_name}
    Fill Text    css=input[aria-label=select_plan]    	${plan_name}
    #Click    css=div[id*=option] >> text=${plan_name}
    Click    css=div[class$=option] >> text=${plan_name}

Fill payment card
    [Arguments]    ${card}

    Fill Text    css=input[name=card_number]    ${card}[number]
    Fill Text    css=input[name=card_holder]    ${card}[holder]
    Fill Text    css=input[name=card_month]     ${card}[month]
    Fill Text    css=input[name=card_year]      ${card}[year]
    Fill Text    css=input[name=card_cvv]       ${card}[cvv]

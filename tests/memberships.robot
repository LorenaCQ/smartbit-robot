*** Settings ***
Documentation        Suite de testes de adesoes de planos

Resource        ../resources/Base.resource

Test Setup       Start session
Test Teardown    Take Screenshot

*** Test Cases ***

Deve poder realizar uma nova adesao

    ${data}    Get json fixture    memberships   create
    
    Delete Account By Email    ${data}[account][email]
    Insert Account    ${data}[account]

    SignIn admin
    Go to memberships
    Create new membership    ${data}
    Toast should be    Matrícula cadastrada com sucesso.

Nao deve realizar adesao duplicada
    [Tags]    dup
    
    ${data}    Get json fixture    memberships   duplicate

    Delete Account By Email    ${data}[account][email]
    Insert Account    ${data}[account]
    
    SignIn admin
    Go to memberships
    Create new membership    ${data}
    Sleep    8
    Create new membership    ${data}
    Toast should be    O usuário já possui matrícula.
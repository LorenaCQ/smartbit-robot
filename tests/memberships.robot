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

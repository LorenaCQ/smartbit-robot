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

    Insert Membership    ${data}

    SignIn admin
    Go to memberships
    Create new membership    ${data}
    Toast should be    O usuário já possui matrícula.

Deve buscar por nome
    [Tags]    search

    ${data}    Get json fixture    	memberships    search

    Insert Membership    ${data}

    SignIn admin
    Go to memberships
    Search by name           ${data}[account][name]
    Should filter by name    ${data}[account][name]

Deve excluir uma matricula
    [Tags]    remove

    ${data}    Get json fixture    	memberships    remove

    Insert Membership    ${data}

    SignIn admin
    Go to memberships
    Request removal    ${data}[account][name]
    Confirm removal
    Membership should not be visible    ${data}[account][name]
*** Settings ***
Documentation        Cenarios de testes do Login SAC

Resource        ../resources/Base.resource

Test Setup       Start session
Test Teardown    Take Screenshot

*** Test Cases ***
Deve logar como Gestor da Academia
    Go to login page
    Submit login form    sac@smartbit.com    pwd123
    User is logged in    sac@smartbit.com

Nao deve logar com senha incorreta
    [Tags]    inv_pass

    Go to login page
    Submit login form    sac@smartbit.com    abc123

    Toast should be    As credenciais de acesso fornecidas são inválidas. Tente novamente!

Nao deve logar com email não cadastrado
    [Tags]    email_404

    Go to login page
    Submit login form    404@smartbit.com    abc123

    Toast should be    As credenciais de acesso fornecidas são inválidas. Tente novamente!

Tentativa de login com dados incorretos
    [Template]    Login With verify notice

    ${EMPTY}            ${EMPTY}    Os campos email e senha são obrigatórios.
    ${EMPTY}            pwd123      Os campos email e senha são obrigatórios.
    sac@smartbit.com    ${EMPTY}    Os campos email e senha são obrigatórios.
    www.teste.com.br    pwd123    Oops! O email informado é inválido

*** Keywords ***
Login With verify notice
    [Arguments]    ${email}    ${password}    ${output_message}

    Go to login page
    Submit login form   ${email}    ${password}
    Notice should be    ${output_message}
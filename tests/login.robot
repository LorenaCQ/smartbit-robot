*** Settings ***
Documentation        Cenarios de testes do Login SAC

Resource        ../resources/Base.resource

Test Setup    Start session
Test Teardown    Take Screenshot

*** Test Cases ***
Deve logar como Gestor da Academia
    Go to login page
    
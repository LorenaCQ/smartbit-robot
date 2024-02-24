*** Settings ***
Documentation        Suite de testes de adesoes de planos

Resource        ../resources/Base.resource

Test Setup       Start session
Test Teardown    Take Screenshot

*** Test Cases ***

Deve poder realizar uma nova adesao
    Go to login page
    Submit login form    sac@smartbit.com    pwd123
    User is logged in    sac@smartbit.com

    Go to Enrolls

*** Keywords ***
Go to Enrolls
    Click    css=a[href="/memberships"]

    Wait For Elements State    css=h1 >> text=Matrículas
    ...    visible    5
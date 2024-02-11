*** Settings ***
Documentation        Cenarios de testes de pre-cadastro de clientes

Resource        ../resources/Base.resource

Test Setup    Start session
Test Teardown    Take Screenshot

*** Test Cases ***
Deve iniciar o cadastro do cliente
    #PREPARACAO

    ${account}    Get Fake Account

    Submit signup form    ${account}
    Verify welcome message

# Campo nome deve ser obrigatorio teste
#     #Com essa Tag executa somente os casos de teste que a possuem. Na hora de executar precisa digitar
#     #robot -d ./logs -i required tests/signup.robot
#     [Tags]    required
#     #PREPARACAO

#     ${account}        Create Dictionary
#     ...    name=${EMPTY}
#     ...    email=teste@teste.com
#     ...    cpf=54092703040

#     Submit signup form    ${account}
#     Notice should be        Por favor informe o seu nome completo

       
# Campo email deve ser obrigatorio
#     #Com a Tag executa somente os casos de teste que a possuem. Na hora de executar precisa digitar
#     #robot -d ./logs -i nome_da_tag tests/signup.robot
#     [Tags]    required
    
#     ${account}        Create Dictionary
#     ...    name=Lorena Cecilio
#     ...    email=${EMPTY}
#     ...    cpf=54092703040

#     Submit signup form    ${account}
#     Notice should be        Por favor, informe o seu melhor e-mail


# Campo cpf deve ser obrigatorio
#     #Com a Tag executa somente os casos de teste que a possuem. Na hora de executar precisa digitar
#     #robot -d ./logs -i nome_da_tag tests/signup.robot
#     [Tags]    required
#     #PREPARACAO

#      ${account}        Create Dictionary
#     ...    name=Lorena Cecilio
#     ...    email=teste@teste.com
#     ...    cpf=${EMPTY}

#     Submit signup form    ${account}
#     Notice should be        Por favor, informe o seu CPF

# E-mail no formato invalido
#     #Com a Tag executa somente os casos de teste que a possuem. Na hora de executar precisa digitar
#     #robot -d ./logs -i nome_da_tag tests/signup.robot
#     [Tags]    inv
#     #PREPARACAO

#     ${account}        Create Dictionary
#     ...    name=Lorena Cecilio
#     ...    email=teste*teste.com
#     ...    cpf=54092703040

#     Submit signup form    ${account}
#     Notice should be        Oops! O email informado é inválido

# CPF no formato invalido
#     #Com a Tag executa somente os casos de teste que a possuem. Na hora de executar precisa digitar
#     #robot -d ./logs -i nome_da_tag tests/signup.robot
#     [Tags]    inv
#     ${account}        Create Dictionary
#     ...    name=Lorena Cecilio
#     ...    email=teste@teste.com
#     ...    cpf=5409270304a

#     Submit signup form    ${account}
#     Notice should be        Oops! O CPF informado é inválido

Tentativa de pre-cadastro
    [Template]        Attemp signup
    ${EMPTY}          teste@teste.com    54092703040     Por favor informe o seu nome completo
    Lorena Cecilio    ${EMPTY}           54092703040     Por favor, informe o seu melhor e-mail
    Lorena Cecilio    teste@teste.com    ${EMPTY}        Por favor, informe o seu CPF
    Lorena Cecilio    teste*teste.com    54092703040     Oops! O email informado é inválido
    Lorena Cecilio    teste@teste.com    5409270304a     Oops! O CPF informado é inválido

*** Keywords ***
Attemp signup
    [Arguments]        ${name}    ${email}    ${cpf}    ${output_message}

    ${account}        Create Dictionary
    ...    name=${name}
    ...    email=${email}
    ...    cpf=${cpf}

    Submit signup form    ${account}
    Notice should be        ${output_message}
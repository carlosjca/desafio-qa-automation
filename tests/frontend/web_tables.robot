*** Settings ***
Documentation       Criar, editar e deletar registros em Web Tables
Resource            ../../resources/base.resource
Resource            ../../resources/pages/home_page.resource
Resource            ../../resources/pages/web_tables_page.resource

Suite Setup         Abrir browser
Suite Teardown      Fechar browser
Test Setup          Dado que estou na tela Web Tables

*** Variables ***
@{COPIA_REGISTROS}

*** Test Cases ***
Criar editar e deletar um registro
    ${chave_email}=    When crio um novo registro
    Then o registro deve aparecer na tabela    ${chave_email}
    And Sleep    3s
    When edito o nome e sobrenome do registro    ${chave_email}    Nome_Novo    Sobrenome_Novo
    And Sleep    3s
    Then o nome e sobrenome na tabela devem ser    ${chave_email}    Nome_Novo    Sobrenome_Novo
    When deleto o registro    ${chave_email}
    And Sleep    3s
    Then o registro nao deve mais aparecer    ${chave_email}

Criar 12 registros dinamicamente e deletar todos
    Given que a tabela exibe 20 linhas por pagina
    When crio 12 registros dinamicamente
    Then todos os 12 registros devem aparecer na tabela
    When deleto todos os registros criados
    Then nenhum dos registros criados deve aparecer


*** Keywords ***
Dado que estou na tela Web Tables
    Navegar para    Elements    Web Tables

crio um novo registro
    ${chave_email}=    Criar novo registro
    RETURN    ${chave_email}

o registro deve aparecer na tabela
    [Arguments]    ${chave_email}
    Linha do registro deve existir    ${chave_email}

edito o nome e sobrenome do registro
    [Arguments]    ${chave_email}    ${novo_nome}    ${novo_sobrenome}
    Editar registro    ${chave_email}    ${novo_nome}    ${novo_sobrenome}

o nome e sobrenome na tabela devem ser
    [Arguments]    ${chave_email}    ${nome}    ${sobrenome}
    Validar nome e sobrenome na linha    ${chave_email}    ${nome}    ${sobrenome}

deleto o registro
    [Arguments]    ${chave_email}
    Deletar registro    ${chave_email}

o registro nao deve mais aparecer
    [Arguments]    ${chave_email}
    Linha do registro nao deve existir    ${chave_email}

que a tabela exibe 20 linhas por pagina
    Exibir 20 linhas por pagina

crio ${quantidade} registros dinamicamente
    Criar varios registros    ${quantidade}

todos os ${quantidade} registros devem aparecer na tabela
    ${total}=    Get Length    ${REGISTROS_CRIADOS}
    Should Be Equal As Integers    ${total}    ${quantidade}
    FOR    ${email}    IN    @{REGISTROS_CRIADOS}
        Linha do registro deve existir    ${email}
    END

deleto todos os registros criados
    ${copia}=    Create List    @{REGISTROS_CRIADOS}
    Set Test Variable    @{COPIA_REGISTROS}    @{copia}
    Deletar todos os registros criados

nenhum dos registros criados deve aparecer
    FOR    ${email}    IN    @{COPIA_REGISTROS}
        Linha do registro nao deve existir    ${email}
    END

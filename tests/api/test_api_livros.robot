*** Settings ***
Documentation       Teste API
Library             Collections
Library             ../../libs/api_demoqa.py

*** Test Cases ***
Teste API De Livros
    [Documentation]    Cria usuario, gera token, valida autorizacao, lista livros,
    ...    reserva dois livros e consulta os detalhes do usuario.

    # 1) Criar usuario
    ${usuario}=    Gerar Nome De Usuario
    ${senha}=    Gerar Senha Valida
    ${user_id}=    Criar Usuario    ${usuario}    ${senha}
    Should Not Be Empty    ${user_id}
    Log To Console    \nUsuario criado: ${usuario} (ID: ${user_id})

    # 2) Gerar token
    ${token}=    Gerar Token    ${usuario}    ${senha}
    Should Not Be Empty    ${token}

    # 3) Confirmar autorizacao
    ${autorizado}=    Usuario Esta Autorizado    ${usuario}    ${senha}
    Should Be True    ${autorizado}    Usuario nao esta autorizado

    # 4) Listar livros disponiveis
    ${livros}=    Listar Livros
    ${total}=    Get Length    ${livros}
    Should Be True    ${total} >= 2    A loja precisa ter ao menos 2 livros
    Log To Console    Livros disponiveis: ${total}

    # 5) Reservar dois livros (os dois primeiros da lista)
    ${isbn_1}=    Set Variable    ${livros}[0][isbn]
    ${isbn_2}=    Set Variable    ${livros}[1][isbn]
    @{isbns}=    Create List    ${isbn_1}    ${isbn_2}
    Reservar Livros    ${user_id}    ${token}    ${isbns}
    Log To Console    Livros reservados: ${livros}[0][title] e ${livros}[1][title]

    # 6) Listar detalhes do usuario com os livros reservados
    ${detalhes}=    Obter Detalhes Do Usuario    ${user_id}    ${token}
    Should Be Equal    ${detalhes}[userId]    ${user_id}
    Should Be Equal    ${detalhes}[username]    ${usuario}
    ${qtd_livros}=    Get Length    ${detalhes}[books]
    Should Be Equal As Integers    ${qtd_livros}    2
    ${isbns_do_usuario}=    Create List    ${detalhes}[books][0][isbn]    ${detalhes}[books][1][isbn]
    List Should Contain Value    ${isbns_do_usuario}    ${isbn_1}
    List Should Contain Value    ${isbns_do_usuario}    ${isbn_2}
    Log    ${detalhes}

    # Limpeza (opcional): remove o usuario criado
    [Teardown]    Log To Console    Fluxo de API finalizado.

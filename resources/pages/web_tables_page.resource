*** Settings ***
Library     Collections
Library     ../../libs/dados_aleatorios.py
Resource    ../base.resource


*** Variables ***
@{REGISTROS_CRIADOS}       @{EMPTY}


*** Keywords ***
Exibir 20 linhas por pagina
    Scroll Element Into View    //select[@class='form-control']
    Select From List By Value    //select[@class='form-control']    20

Abrir formulario de novo registro
    Clicar usando Scroll    id=addNewRecordButton
    Wait Until Element Is Visible    id=registration-form-modal

Preencher registro
    [Arguments]    ${nome}    ${sobrenome}    ${email}    ${idade}    ${salario}    ${departamento}
    Input Text    id=firstName    ${nome}
    Input Text    id=lastName    ${sobrenome}
    Input Text    id=userEmail    ${email}
    Input Text    id=age    ${idade}
    Input Text    id=salary    ${salario}
    Input Text    id=department    ${departamento}

Salvar registro
    Click Element    id=submit
    Wait Until Element Is Not Visible    id=registration-form-modal

Criar novo registro
    [Documentation]    Cria um registro com dados aleatorios e devolve o email (usado como chave).
    ${nome}=    Gerar Nome
    ${sobrenome}=    Gerar Sobrenome
    ${email}=    Gerar Email
    Abrir formulario de novo registro
    Preencher registro    ${nome}    ${sobrenome}    ${email}
    ...    ${{ str(__import__('random').randint(18, 70)) }}
    ...    ${{ str(__import__('random').randint(2000, 9000)) }}
    ...    QA
    ${chave_email}=    Set Variable    ${email}
    Salvar registro
    Append To List    ${REGISTROS_CRIADOS}    ${chave_email}
    RETURN    ${chave_email}

Criar varios registros
    [Arguments]    ${quantidade}
    FOR    ${i}    IN RANGE    ${quantidade}
        Criar novo registro
    END

Linha do registro deve existir
    [Arguments]    ${chave_email}
    Wait Until Page Contains Element    xpath=//tr[.//td[normalize-space(.)='${chave_email}']]

Linha do registro nao deve existir
    [Arguments]    ${chave_email}
    Wait Until Page Does Not Contain Element    xpath=//tr[.//td[normalize-space(.)='${chave_email}']]

Editar registro
    [Arguments]    ${chave_email}    ${novo_nome}    ${novo_sobrenome}
    Clicar usando Scroll    xpath=//tr[.//td[normalize-space(.)='${chave_email}']]//span[@title='Edit']
    Wait Until Element Is Visible    id=registration-form-modal
    Input Text    id=firstName    ${novo_nome}
    Input Text    id=lastName    ${novo_sobrenome}
    Salvar registro

Validar nome e sobrenome na linha
    [Arguments]    ${chave_email}    ${nome_esperado}    ${sobrenome_esperado}
    Wait Until Element Contains
    ...    xpath=//tr[.//td[normalize-space(.)='${chave_email}']]
    ...    ${nome_esperado}
    Wait Until Element Contains
    ...    xpath=//tr[.//td[normalize-space(.)='${chave_email}']]
    ...    ${sobrenome_esperado}

Deletar registro
    [Arguments]    ${chave_email}
    Clicar usando Scroll    xpath=//tr[.//td[normalize-space(.)='${chave_email}']]//span[@title='Delete']
    Linha do registro nao deve existir    ${chave_email}
    Remove Values From List    ${REGISTROS_CRIADOS}    ${chave_email}

#Deletar todos os registros criados
#    FOR    ${registro}    IN    @{REGISTROS_CRIADOS}
#        ${quantidade}=    Get Element Count    xpath=//tr[.//td[normalize-space(.)='${registro}']]
#        IF    ${quantidade} > 0
#            Deletar registro    ${registro}
#        END
#    END
#    ${vazia}=    Create List
#    Set Suite Variable    ${REGISTROS_CRIADOS}    ${vazia}

Deletar todos os registros criados
    ${copia}=    Create List    @{REGISTROS_CRIADOS}
    FOR    ${registro}    IN    @{copia}
        ${quantidade}=    Get Element Count    xpath=//tr[.//td[normalize-space(.)='${registro}']]
        IF    ${quantidade} > 0
            Deletar registro    ${registro}
        END
    END
    ${vazia}=    Create List
    Set Suite Variable    ${REGISTROS_CRIADOS}    ${vazia}

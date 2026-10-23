*** Settings ***
Library     Collections
Resource    ../base.resource


*** Variables ***
${ITENS_DA_LISTA}       css=#demo-tabpane-list .list-group-item
@{ORDEM_CRESCENTE}      One    Two    Three    Four    Five    Six


*** Keywords ***
Obter ordem atual
    ${elementos}=    Get WebElements    ${ITENS_DA_LISTA}
    ${ordem}=    Create List
    FOR    ${elemento}    IN    @{elementos}
        ${texto}=    Get Text    ${elemento}
        Append To List    ${ordem}    ${texto}
    END
    RETURN    ${ordem}

Mover item para a posicao
    [Documentation]    Arrasta o item pelo texto ate a posicao desejada (comeca em 0).
    [Arguments]    ${nome_do_item}    ${posicao_destino}
    ${ordem}=    Obter ordem atual
    ${posicao_atual}=    Get Index From List    ${ordem}    ${nome_do_item}
    ${diferenca}=    Evaluate    ${posicao_destino} - ${posicao_atual}
    IF    ${diferenca} == 0    RETURN
    ${locator}=    Set Variable    xpath=//div[@id='demo-tabpane-list']//div[contains(@class,'list-group-item') and text()='${nome_do_item}']
    ${largura}    ${altura}=    Get Element Size    ${locator}
    ${deslocamento}=    Evaluate    ${diferenca} * ${altura} + (5 if ${diferenca} > 0 else -5)
    Drag And Drop By Offset    ${locator}    0    ${deslocamento}
    Sleep    0.5s

Embaralhar a lista
    [Documentation]    Garante que a lista nao esta ordenada antes do teste de ordenacao.
    Mover item para a posicao    Six    0
    Mover item para a posicao    Five    1

Ordenar a lista em ordem crescente
    FOR    ${indice}    ${nome}    IN ENUMERATE    @{ORDEM_CRESCENTE}
        Mover item para a posicao    ${nome}    ${indice}
    END

Validar que a lista esta em ordem crescente
    ${ordem}=    Obter ordem atual
    Lists Should Be Equal    ${ordem}    ${ORDEM_CRESCENTE}

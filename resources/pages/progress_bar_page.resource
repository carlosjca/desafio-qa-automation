*** Settings ***
Resource    ../base.resource


*** Variables ***
${BARRA}            css=div[role='progressbar']
${BOTAO_RESET}      id=resetButton
${LIMITE_PARADA}    20


*** Keywords ***
Obter valor da barra
    ${texto}=    Get Text    ${BARRA}
    ${numero}=    Evaluate    int("${texto}".replace("%", "").strip() or 0)
    RETURN    ${numero}

Clicar no botao Start ou Stop
    Clicar usando Javascript    startStopButton

Iniciar e parar antes de 25%
    Clicar no botao Start ou Stop
    FOR    ${i}    IN RANGE    1000
        ${valor}=    Obter valor da barra
        IF    ${valor} >= ${LIMITE_PARADA}    BREAK
    END
    Clicar no botao Start ou Stop

Validar que o valor e menor ou igual a
    [Arguments]    ${maximo}
    ${valor}=    Obter valor da barra
    Log    Valor da barra apos parar: ${valor}%
    Should Be True    ${valor} <= ${maximo}    A barra passou de ${maximo}% (valor: ${valor}%)

Iniciar e aguardar chegar a 100%
    Clicar no botao Start ou Stop
    Wait Until Element Contains    ${BARRA}    100%    timeout=40s

Resetar a barra
    Wait Until Element Is Visible    ${BOTAO_RESET}
    Clicar usando Javascript    resetButton
    Wait Until Element Contains    ${BARRA}    0%
    ${valor}=    Obter valor da barra
    Should Be Equal As Integers    ${valor}    0

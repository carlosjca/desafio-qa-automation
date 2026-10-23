*** Settings ***
Resource    ../base.resource


*** Keywords ***
Clicar no botao New Window
    Clicar usando Scroll    id=windowButton

Validar nova janela com a mensagem
    [Arguments]    ${mensagem_esperada}
    Switch Window    locator=NEW
    Wait Until Element Is Visible    id=sampleHeading
    Element Text Should Be    id=sampleHeading    ${mensagem_esperada}

Fechar a nova janela
    Close Window
    Switch Window    locator=MAIN
    Wait Until Element Is Visible    id=windowButton    timeout=10s

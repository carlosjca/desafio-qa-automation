*** Settings ***
Resource    ../base.resource


*** Keywords ***
Acessar a pagina do DemoQA
    Go To    ${URL}

Escolher o card da Home
    [Arguments]    ${nome_do_card}
    Clicar usando scroll    xpath=//h5[text()='${nome_do_card}']

Clicar no submenu
    [Arguments]    ${nome_do_submenu}
    Clicar usando scroll    xpath=//li//span[text()='${nome_do_submenu}']

Navegar para
    [Arguments]    ${card}    ${submenu}
    Acessar a pagina do DemoQA
    Escolher o card da Home    ${card}
    Clicar no submenu    ${submenu}

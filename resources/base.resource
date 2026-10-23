*** Settings ***
Library     SeleniumLibrary


*** Variables ***
${URL}          https://demoqa.com/
${BROWSER}      edge
${TIMEOUT}      15s


*** Keywords ***
Abrir browser
    #${opcoes}=    Set Variable    add_argument("--start-maximized");add_argument("--disable-notifications");add_argument("--window-size=1920,1080")
    Open Browser    ${URL}    ${BROWSER}    #options=${opcoes}
    Maximize Browser Window
    Set Selenium Timeout    ${TIMEOUT}

Fechar browser
    Close All Browsers

Clicar usando scroll
    [Arguments]    ${locator}
    Wait Until Element Is Visible    ${locator}
    Scroll Element Into View    ${locator}
    Click Element    ${locator}

Clicar usando javascript
    [Documentation]    Usado quando algum elemento cobre o botao e o clique normal falha. Clica usando javascript.
    [Arguments]    ${id_do_elemento}
    Execute Javascript    document.getElementById('${id_do_elemento}').click();

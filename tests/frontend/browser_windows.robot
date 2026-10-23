*** Settings ***
Documentation       Validar nova janela.
Resource            ../../resources/base.resource
Resource            ../../resources/pages/home_page.resource
Resource            ../../resources/pages/browser_windows_page.resource

Suite Setup         Abrir browser
Suite Teardown      Fechar browser


*** Test Cases ***
Abrir e fechar nova janela
    Given que estou na tela Browser Windows
    When clico no botao New Window
    Then uma nova janela deve ser aberta com a mensagem "This is a sample page"
    And Sleep    3s
    And consigo fechar a nova janela


*** Keywords ***
que estou na tela Browser Windows
    Navegar para    Alerts, Frame & Windows    Browser Windows

clico no botao New Window
    Clicar no botao New Window

uma nova janela deve ser aberta com a mensagem "${mensagem}"
    Validar nova janela com a mensagem    ${mensagem}

consigo fechar a nova janela
    Fechar a nova janela

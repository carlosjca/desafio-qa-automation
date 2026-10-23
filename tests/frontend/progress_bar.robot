*** Settings ***
Documentation       Parte 4 - Progress Bar.
Resource            ../../resources/base.resource
Resource            ../../resources/pages/home_page.resource
Resource            ../../resources/pages/progress_bar_page.resource

Suite Setup         Abrir browser
Suite Teardown      Fechar browser

*** Test Cases ***
Parar a Progress Bar antes de 25% e resetar ao chegar em 100%
    Given que estou na tela Progress Bar
    When inicio a barra e paro antes dos 25%
    And Sleep    3s
    Then o valor da barra deve ser menor ou igual a 25%
    When inicio a barra novamente e espero chegar a 100%
    And Sleep    3s
    Then consigo resetar a barra
    And Sleep    5s


*** Keywords ***
que estou na tela Progress Bar
    Navegar para    Widgets    Progress Bar

inicio a barra e paro antes dos 25%
    Iniciar e parar antes de 25%

o valor da barra deve ser menor ou igual a 25%
    Validar que o valor e menor ou igual a    25

inicio a barra novamente e espero chegar a 100%
    Iniciar e aguardar chegar a 100%

consigo resetar a barra
    Resetar a barra

*** Settings ***
Documentation       Validar o preenchimento do Practice Form.
Resource            ../../resources/base.resource
Resource            ../../resources/pages/home_page.resource
Resource            ../../resources/pages/practice_form_page.resource

Suite Setup         Abrir browser
Suite Teardown      Fechar browser


*** Test Cases ***
Preencher e submeter o formulario
    Given que estou na tela do Practice Form
    When preencho todo o formulario com valores aleatorios
    And submeto o formulario
    Then um popup de confirmacao deve ser exibido
    And consigo fechar o popup


*** Keywords ***
que estou na tela do Practice Form
    Navegar para    Forms    Practice Form

preencho todo o formulario com valores aleatorios
    Preencher formulario com valores aleatorios

submeto o formulario
    Submeter o formulario

um popup de confirmacao deve ser exibido
    Validar que o popup foi aberto

consigo fechar o popup
    Fechar o popup

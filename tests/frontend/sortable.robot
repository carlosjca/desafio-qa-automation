*** Settings ***
Documentation       Parte 5 - Sortable (drag and drop).
Resource            ../../resources/base.resource
Resource            ../../resources/pages/home_page.resource
Resource            ../../resources/pages/sortable_page.resource

Suite Setup         Abrir browser
Suite Teardown      Fechar browser


*** Test Cases ***
Ordenar os itens em ordem crescente
    Given que estou na tela Sortable
    And Sleep    3s
    And a lista esta fora de ordem
    When arrasto os itens para a ordem crescente
    And Sleep    3s
    Then a lista deve estar em ordem crescente


*** Keywords ***
que estou na tela Sortable
    Navegar para    Interactions    Sortable

a lista esta fora de ordem
    Embaralhar a lista

arrasto os itens para a ordem crescente
    Ordenar a lista em ordem crescente

a lista deve estar em ordem crescente
    Validar que a lista esta em ordem crescente

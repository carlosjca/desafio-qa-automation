*** Settings ***
Library     OperatingSystem
Library     ../../libs/dados_aleatorios.py
Resource    ../base.resource

*** Variables ***
${ARQUIVO_UPLOAD}       ${EXECDIR}${/}resources${/}arquivos${/}arquivo_upload.txt


*** Keywords ***
Preencher formulario com valores aleatorios
    ${nome}=    Gerar Nome
    ${sobrenome}=    Gerar Sobrenome
    ${email}=    Gerar Email
    ${celular}=    Gerar Celular
    ${endereco}=    Gerar Endereco

    Input Text    id=firstName    ${nome}
    Input Text    id=lastName    ${sobrenome}
    Input Text    id=userEmail    ${email}
    Click Element    css=label[for='gender-radio-1']
    Input Text    id=userNumber    ${celular}

    Input Text    id=dateOfBirthInput    15 Jan 1990
    Press Keys    id=dateOfBirthInput    ENTER

    Click Element    id=subjectsInput
    Press Keys    None    Maths    ENTER
    Click Element    id=subjectsInput
    Press Keys    None    English    ENTER

    Scroll Element Into View    id=uploadPicture
    Click Element    id=hobbies-checkbox-1
    Click Element    id=hobbies-checkbox-3

    File Should Exist    ${ARQUIVO_UPLOAD}
    Choose File    id=uploadPicture    ${ARQUIVO_UPLOAD}

    Input Text    id=currentAddress    ${endereco}

    Click Element    id=state
    Press Keys    None    NCR    ENTER
    Click Element    id=city
    Press Keys    None    Delhi    ENTER

Submeter o formulario
    Clicar usando javascript    submit

Validar que o popup foi aberto
    Wait Until Element Is Visible    id=example-modal-sizes-title-lg
    Element Text Should Be    id=example-modal-sizes-title-lg    Thanks for submitting the form

Fechar o popup
    Wait Until Element Is Visible    id=closeLargeModal
    Run Keyword And Ignore Error    Clicar usando javascript    id=closeLargeModal
    ${popup_fechado}=    Run Keyword And Return Status    Wait Until Element Is Not Visible    id=example-modal-sizes-title-lg    timeout=5s
    IF    not ${popup_fechado}
        Press Keys    None    ESC
    END
    Wait Until Element Is Not Visible    id=example-modal-sizes-title-lg

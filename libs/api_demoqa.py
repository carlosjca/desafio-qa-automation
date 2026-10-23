"""
Biblioteca Python com as chamadas de API.
Cada funcao vira uma keyword no Robot Framework.
"""
import uuid
import requests

BASE_URL = "https://demoqa.com"
TIMEOUT = 30


def gerar_nome_de_usuario():
    """Gera um nome de usuario unico para nao conflitar com execucoes anteriores."""
    return "qa_user_" + uuid.uuid4().hex[:8]


def gerar_senha_valida():
    """A API exige senha com maiuscula, minuscula, numero e caractere especial."""
    return "Senha@12345"


def criar_usuario(nome, senha):
    resposta = requests.post(
        f"{BASE_URL}/Account/v1/User",
        json={"userName": nome, "password": senha},
        timeout=TIMEOUT,
    )
    assert resposta.status_code == 201, (
        f"Erro ao criar usuario: {resposta.status_code} - {resposta.text}"
    )
    return resposta.json()["userID"]


def gerar_token(nome, senha):
    resposta = requests.post(
        f"{BASE_URL}/Account/v1/GenerateToken",
        json={"userName": nome, "password": senha},
        timeout=TIMEOUT,
    )
    assert resposta.status_code == 200, f"Erro ao gerar token: {resposta.text}"
    corpo = resposta.json()
    assert corpo["status"] == "Success", f"Token nao gerado: {corpo}"
    return corpo["token"]


def usuario_esta_autorizado(nome, senha):
    resposta = requests.post(
        f"{BASE_URL}/Account/v1/Authorized",
        json={"userName": nome, "password": senha},
        timeout=TIMEOUT,
    )
    assert resposta.status_code == 200, f"Erro ao validar autorizacao: {resposta.text}"
    return resposta.json() is True


def listar_livros():
    resposta = requests.get(f"{BASE_URL}/BookStore/v1/Books", timeout=TIMEOUT)
    assert resposta.status_code == 200, f"Erro ao listar livros: {resposta.text}"
    return resposta.json()["books"]


def reservar_livros(user_id, token, isbns):
    """Reserva uma lista de livros (isbns) para o usuario."""
    resposta = requests.post(
        f"{BASE_URL}/BookStore/v1/Books",
        json={
            "userId": user_id,
            "collectionOfIsbns": [{"isbn": isbn} for isbn in isbns],
        },
        headers={"Authorization": f"Bearer {token}"},
        timeout=TIMEOUT,
    )
    assert resposta.status_code == 201, (
        f"Erro ao reservar livros: {resposta.status_code} - {resposta.text}"
    )
    return resposta.json()


def obter_detalhes_do_usuario(user_id, token):
    resposta = requests.get(
        f"{BASE_URL}/Account/v1/User/{user_id}",
        headers={"Authorization": f"Bearer {token}"},
        timeout=TIMEOUT,
    )
    assert resposta.status_code == 200, f"Erro ao obter usuario: {resposta.text}"
    return resposta.json()


def excluir_usuario(user_id, token):
    """Limpeza opcional ao final do teste."""
    resposta = requests.delete(
        f"{BASE_URL}/Account/v1/User/{user_id}",
        headers={"Authorization": f"Bearer {token}"},
        timeout=TIMEOUT,
    )
    return resposta.status_code

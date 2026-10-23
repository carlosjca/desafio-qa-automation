"""Funcoes simples para gerar dados aleatorios usados nos formularios."""
import random
import string


def _texto(tamanho=6):
    return "".join(random.choices(string.ascii_lowercase, k=tamanho)).capitalize()


def gerar_nome():
    return _texto(6)


def gerar_sobrenome():
    return _texto(8)


def gerar_email():
    return f"{_texto(5).lower()}{random.randint(100, 9999)}@teste.com"


def gerar_celular():
    """Retorna 10 digitos (o campo do Practice Form exige 10)."""
    return "".join(random.choices(string.digits, k=10))


def gerar_idade():
    return str(random.randint(18, 80))


def gerar_salario():
    return str(random.randint(1500, 20000))


def gerar_departamento():
    return random.choice(["QA", "Dev", "Suporte", "RH", "Financeiro"])


def gerar_endereco():
    return f"Rua {_texto(7)}, {random.randint(1, 999)}"

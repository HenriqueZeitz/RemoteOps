# 🛰️ RemoteOps – Backend

Backend responsável por atuar como middleware seguro entre o aplicativo mobile e o RemoteOps Agent, que roda diretamente no computador do usuário.

Este backend será executado em um servidor dedicado (ex: Raspberry Pi), centralizando autenticação, controle e encaminhamento de comandos.

--- 

## 📌 Responsabilidades do Backend

- Expor API pública segura para clientes
- Autenticar requisições via Bearer Token
- Encaminhar comandos para o Agent
- Consultar status do Agent e dos comandos
- Isolar o Agent de acesso direto externo

---

## 🧱 Arquitetura

```less
[ Mobile ]
      |
      v
[ RemoteOps Backend ]
      |
      v
[ RemoteOps Agent ]
      |
      v
[ Sistema Operacional ]

```

## 📁 Estrutura do Projeto

```bash
backend/
│
├── main.py
├── requirements.txt
├── .env                     # Variáveis de ambiente
│
├── src/
│   ├── api/
│   │   ├── routes.py        # Rotas públicas do backend
│   │   └── auth.py          # Autenticação Bearer Token
│   │
│   ├── clients/
│   │   └── agent_client.py  # Cliente HTTP para comunicação com o Agent
│   │
│   ├── models/
│   │   ├── command_request.py
│   │   └── status_request.py
│   │
│   └── config.py            # Configurações

```

---

## ⚙️ Configuração

### 1️⃣ Criar ambiente virtual (recomendado)

```bash
python -m venv .venv
```

Ativar:

### Windows

```bash
.venv\Scripts\activate
```

### Linux / Raspberry

```bash
source .venv/bin/activate
```

---

### 2️⃣ Instalar dependências

```bash
pip install -r requirements.txt
```

---

### 3️⃣ Criar arquivo .env

```env
API_KEY=chave_secreta_backend
AGENT_BASE_URL=http://localhost:8001
AGENT_TOKEN=chave_secreta_agent
```

| Variável | Descrição |
| --- | --- |
| `API_KEY` | Token para acessar o backend |
| `AGENT_BASE_URL` | URL do Agent |
| `AGENT_TOKEN` | Token usado para autenticar no Agent |

---

## ▶️ Executando o Backend

Na raiz do projeto:

```bash
uvicorn main:app --reload --port 8000
```

A API ficará disponível em:

```arduino
http://localhost:8000
```

---

## 🔐 Autenticação

Todas as rotas exigem autenticação via **Bearer Token**.

### Exemplo (Postman)
- Aba Authorization
- Tipo: Bearer Token
- Token: valor de API_KEY

---

## 📡 Endpoints Disponíveis

### 🔹 Health do Backend

```bash
GET /health
```

Resposta:

```json
{
    "status": "ok"
}
```

---

### 🔹 Health do Agent

```bash
GET /agent/health
```

Encaminha a requisição para o Agent.

---

### 🔹 Executar comando no computador

```bash
POST /commands/execute
```

Body:

```json
{
    "command": "command_example"
}
```

---

### 🔹 Status do serviço

```bash
POST /commands/status
```

Body:

```json
{
    "commands": ["command_exmaple"]
}
```

---

## 🛡️ Segurança

- Agent não fica exposto diretamente
- Autenticação obrigatória em todas as rotas
- Comunicação Backend ↔ Agent protegida por token
- Estrutura preparada para rate limit e logs futuros

## 🗺️ Roadmap

- [X] Middleware Backend
- [X] Autenticação Bearer Token
- [X] Integração com Agent
- [ ] Rate limit por IP
- [ ] Logs estruturados
- [ ] Dockerização
- [ ] Deploy no Raspberry Pi
- [ ] Dashboard Web

## 🧠 Observações

Este backend **não executa comandos diretamente**.
Toda execução ocorre exclusivamente no Agent, garantindo isolamento e segurança.
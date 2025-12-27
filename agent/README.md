# RemoteOps Agent

Agent responsável por executar comandos e controlar o estado do computador remoto no projeto **RemoteOps**.

Este serviço roda **localmente no computador alvo** (Windows ou Linux) e expõe uma API HTTP para:

- Executar comandos previamente cadastrados
- Informar o status de serviços/processos
- Controlar o desligamento do computador de forma segura

⚠️ **Importante:**  
O agent **não executa comandos arbitrários** enviados pelo cliente.  
Ele aceita apenas comandos previamente registrados em um arquivo de configuração.

---

## 📦 Tecnologias

- Python 3.10+
- FastAPI
- Uvicorn
- subprocess (execução controlada)
- Pydantic

---

## 📁 Estrutura do Projeto

```
agent/
├── main.py
├── requirements.txt
├── commands/
├── config.py
│ ├── commands_registry.json
│ └── *.bat / *.sh
└── src/
  ├── api/
  │ └── routes.py
  ├── handlers/
  │ └── commands_handler.py
  ├── domain/
  │ └── commands_registry.py
  │ └── services_state.py
  ├── infra/
  │ └── process_utils.py
  └── models/
    ├── command_request.py
    └── status_request.py
```

---

## ⚙️ Configuração

### 1️⃣ Criar ambiente virtual (opcional, recomendado)

```bash
python -m venv venv
source venv/bin/activate  # Linux/macOS
venv\Scripts\activate     # Windows
```

### 2️⃣ Instalar dependências

```
pip install -r requirements.txt
```

---

## 📜 Registro de comandos

Os comandos aceitos pelo agent devem ser definidos em:

```
/commands/commands_registry.py
```

#### Exemplo

```
{
  "start_backend": {
    "process_name": "python.exe"
  },
  "start_mongodb": {
    "process_name": "mongod.exe"
  }
}
```

### 📌 Para cada comando registrado:

Deve existir um arquivo com o mesmo nome em /commands

A extensão depende do sistema:

Windows: .bat

Linux/macOS: .sh

#### Exemplo:

```
commands/start_backend.bat
commands/start_mongodb.bat
```

---

## 🚀 Executando o Agent

Na raiz do projeto:

```
uvicorn main:app --host 0.0.0.0 --port 9000
```

A API ficará disponível em:

```
http://localhost:9000
```

Swagger:
```
http://localhost:9000/docs
```

---

## 🔌 Endpoints disponíveis

### ▶️ Executar comando

POST /commands/execute

```
{
    "command": "command_name"
}
```

Resposta de sucesso:

```
{
    "status": "success",
    "data": {
        "command": "command_name"
    }
}
```

---

### 📊 Status dos comandos

POST /commands/status

```
{
    "commands": ["command_name_1", "command_name_2", "not_a_command"]
}
```

Resposta:

```
{
    "status": "success",
    "data": {
        "command_name_1": "running",
        "command_name_2": "stopped",
        "not_a_command": "unknown"
    }
}
```

---

### 🔌 Desligar computador

POST /computer/power/off

Restrições:

O desligamento é bloqueado se houver serviços em execução

Resposta quando bloqueado:

```
{
    "status": "blocked",
    "message": "services are still running"
}
```

Resposta de sucesso:

```
{
    "status": "shutting_down",
    "data": {
        "delay_seconds": 5
    }
}
```

---

## 🔐 Segurança

O agent não executa comandos enviados diretamente pelo payload

Apenas comandos registrados no commands_registry.json são aceitos

Cada comando está associado a um processo específico para verificação de status

A API foi projetada para uso em rede local ou ambiente controlado

---

## 🧠 Observações importantes

O estado dos serviços é mantido em memória

O status real é validado via processo do sistema operacional

No futuro, o agent pode:

Rodar como serviço

Integrar autenticação por token

Persistir estado em disco

---

## 📌 Papel do Agent no RemoteOps

```
Mobile App
   ↓
Middleware (Raspberry Pi)
   ↓
RemoteOps Agent (este projeto)
   ↓
Sistema Operacional
```

O agent nunca é exposto diretamente à internet.

---

## 🛠️ Roadmap futuro (Agent)

- [ ] Autenticação via token
- [ ] Health check

---

## 👤 Autor

Projeto desenvolvido como parte do RemoteOps
por Henrique Zeitz
# RemoteOps

RemoteOps é um projeto pessoal voltado para **automação e execução remota de tarefas locais**, utilizando um **Raspberry Pi** como ponto central de controle, um **agent no computador** para executar comandos e um **app mobile** para interação.

O projeto tem como foco principal o **aprendizado prático**, explorando conceitos de:
- automação
- comunicação entre serviços
- redes
- mobile
> tudo de forma incremental e sem overengineering.

---

## 🎯 Objetivo do Projeto

Permitir que tarefas do dia a dia sejam executadas remotamente de forma simples, segura e controlada, como por exemplo:
- Ligar o computador via Wake-on-LAN
- Executar scripts locais (.bat)
- Iniciar servidores (ex: backend local, servidor de jogos)
- Centralizar o controle em um app mobile

---

## 🧩 Arquitetura Geral

O sistema é composto por três partes principais:

1. **App Mobile (Flutter)**
   - Interface para disparar comandos
   - Persistência local dos comandos cadastrados
   - Comunicação via HTTP

2. **Backend no Raspberry Pi (FastAPI)**
   - Middleware entre o app e o computador
   - Responsável por Wake-on-LAN
   - Repassa comandos para o agent do PC
   - Acesso restrito via VPN (WireGuard)

3. **Agent no Computador**
   - Serviço local que executa scripts
   - Recebe comandos via HTTP
   - Retorna status de execução

---

## 📁 Estrutura do Repositório

```bash
remoteops/
├── backend/ # Backend FastAPI (Raspberry Pi)
├── agent/ # Agent de execução no PC
├── mobile/ # App mobile Flutter
├── docs/ # Documentação adicional (arquitetura, decisões)
├── README.md
├── ROADMAP.md
├── LICENSE
└── .gitignore
```

---

## 🚀 Status do Projeto

🟡 **Em fase de planejamento e estruturação inicial**

O roadmap completo, com fases e funcionalidades planejadas, pode ser encontrado em:
- [`ROADMAP.md`](./ROADMAP.md)

---

## 🧭 Princípios do Desenvolvimento

- Começar simples
- Evoluir de forma incremental
- Priorizar aprendizado
- Evitar soluções complexas antes da hora
- Cada funcionalidade deve ser útil ou ensinar algo novo

---

## 🛠 Tecnologias Planejadas

- **Mobile:** Flutter
- **Backend:** Python + FastAPI
- **Agent:** Python
- **VPN:** WireGuard
- **Hardware:** Raspberry Pi
- **Versionamento:** Git + GitHub

*(Tecnologias podem evoluir conforme o aprendizado e necessidade.)*

---

## 📌 Observações

Este é um **projeto pessoal**, sem compromisso com prazos ou releases comerciais.  
Mudanças de arquitetura e decisões técnicas fazem parte do processo de aprendizado.

---

## 📄 Licença

Este projeto está licenciado sob a licença MIT.  
Veja o arquivo [`LICENSE`](./LICENSE) para mais detalhes.

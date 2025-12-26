# RemoteOps Mobile 📱⚡

Aplicativo mobile do projeto **RemoteOps**, desenvolvido em **Flutter**, com o objetivo de permitir o **controle remoto de tarefas em um computador doméstico**, de forma simples, segura e personalizada.

O app atua como a interface principal do usuário, permitindo:
- Ligar o computador via Wake-on-LAN
- Executar comandos remotos previamente configurados
- Gerenciar botões de ação personalizados
- Visualizar status de serviços (desenvolvimento futuro)

---

## 🎯 Objetivo do App

O **RemoteOps Mobile** foi criado para resolver necessidades do dia a dia, como:
- Ligar o computador remotamente
- Iniciar ou encerrar servidores (ex: backend, games, etc.)
- Automatizar tarefas com apenas um toque
- Acessar tudo de forma segura via rede local ou VPN

O foco do projeto é **aprendizado prático**, arquitetura limpa e flexibilidade para evolução futura.

---

## 🧠 Conceitos Utilizados

- Flutter (Material 3)
- Widgets customizados
- Separação de responsabilidades (UI / lógica / serviços)
- Persistência local (ex: SharedPreferences / JSON)
- Comunicação via HTTP (FastAPI no Raspberry Pi)
- Design minimalista (Dark + Orange)

---

## 🎨 Design

- Tema **dark**
- Destaques em **laranja**
- Cards interativos (o card inteiro funciona como botão)
- Barra inferior fixa com ações principais
- Interface pensada para uso rápido e intuitivo

---

## 📦 Persistência de Dados

Os botões e comandos são armazenados **localmente no dispositivo**, permitindo:
- Uso offline
- Carregamento rápido
- Facilidade de backup/sincronização futura

Nenhum banco de dados externo é necessário nesta fase.

---

## 🔐 Segurança

- O app **não expõe serviços diretamente à internet**
- Comunicação prevista via:
  - Rede local
  - VPN (WireGuard)
- O controle remoto ocorre apenas em ambientes confiáveis

---

## 🚧 Status do Projeto

🟡 **Em desenvolvimento**

Funcionalidades iniciais:
- [X] Estrutura base do projeto
- [X] Tema e layout inicial
- [X] Cadastro de botões
- [X] Persistência local
- [ ] Comunicação com Raspberry Pi
- [ ] Feedback visual de status

O roadmap completo está disponível no arquivo [`ROADMAP.md`](../ROADMAP.md).

---

## ▶️ Como rodar o projeto

### Pré-requisitos
- Flutter (canal stable)
- Android Studio (para emulador) ou dispositivo físico
- VS Code (opcional)

### Executar:
```bash
flutter pub get
flutter run
```

--- 

## 🧪 Plataformas Suportadas

📱 Android

---

## 📄 Licença

Este projeto é distribuído sob a licença MIT.
Sinta-se à vontade para estudar, modificar e reutilizar.

---

## ✍️ Autor

Projeto desenvolvido por Henrique Zeitz
Como estudo prático de Flutter, arquitetura mobile e automação residencial.

---

## 🚀 Observação Final

Este é um projeto vivo.
A ideia é evoluir aos poucos, com foco em aprendizado real e código bem estruturado.
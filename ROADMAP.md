# RemoteOps – Roadmap

Projeto pessoal para automação e execução remota de tarefas locais
utilizando Raspberry Pi, app mobile em Flutter e backend em FastAPI.

O objetivo é aprender no processo, começar simples e evoluir aos poucos,
sem overengineering.

---

## 🧭 Princípios do projeto
- Começar simples e funcional
- Evoluir de forma incremental
- Priorizar aprendizado prático
- Evitar dependências desnecessárias no início

---

## 🚀 Fase 0 – Preparação
- [X] Criar repositório Git (monorepo)
- [X] Criar estrutura inicial de pastas
- [X] Criar README.md inicial
- [X] Criar este ROADMAP.md
- [X] Definir nome final do projeto (RemoteOps)

---

## 📱 Fase 1 – App Mobile (MVP)
### Objetivo: interface funcional para disparar comandos

- [ ] Criar projeto Flutter
- [ ] Estrutura básica do app (MaterialApp)
- [ ] Tela inicial
- [ ] Layout com lista de cards
- [ ] Card especial “+ Adicionar comando”
- [ ] Modal/tela para cadastrar novo comando
- [ ] Modelo de dados do comando (nome, descrição, comando)
- [ ] Persistência local (SharedPreferences / JSON)
- [ ] Carregar comandos ao abrir o app
- [ ] Renderizar cards dinamicamente
- [ ] Clique no card dispara requisição HTTP

---

## 🖥️ Fase 2 – Agent no PC
### Objetivo: executar comandos locais no computador

- [ ] Criar projeto do agent
- [ ] Servidor HTTP simples (ex: FastAPI ou Flask)
- [ ] Endpoint para executar comandos
- [ ] Pasta de comandos (.bat / scripts)
- [ ] Executar script baseado no nome recebido
- [ ] Retornar status de sucesso/erro
- [ ] Rodar agent automaticamente ao iniciar o PC

---

## 🍓 Fase 3 – Raspberry Pi (Middleware)
### Objetivo: ponto central de controle e segurança

- [ ] Instalar Raspberry Pi OS Lite
- [ ] Configuração headless (SSH)
- [ ] Criar backend FastAPI
- [ ] Endpoint para Wake-on-LAN
- [ ] Endpoint para repassar comandos ao agent do PC
- [ ] Validação básica das requisições
- [ ] Retornar resposta para o app mobile

---

## 🔐 Fase 4 – Conectividade e Segurança
### Objetivo: acesso remoto seguro

- [ ] Configurar WireGuard no Raspberry Pi
- [ ] Testar acesso via VPN no celular (app externo)
- [ ] Garantir que API só funcione via VPN
- [ ] Documentar configuração da VPN

---

## ⚡ Fase 5 – Funcionalidades Essenciais
### Objetivo: tornar o sistema realmente útil

- [ ] Ligar computador via Wake-on-LAN
- [ ] Executar comando para iniciar backend local
- [ ] Executar comando para iniciar servidor (ex: Minecraft)
- [ ] Retorno visual simples (sucesso / erro)

---

## 🎨 Fase 6 – UX e Qualidade
### Objetivo: melhorar experiência de uso

- [ ] Indicador visual de status no card
- [ ] Botão Power fixo no rodapé
- [ ] Feedback visual ao executar comandos
- [ ] Tratamento de erros de conexão
- [ ] Loading states

---

## 🔄 Fase 7 – Evoluções Futuras (Opcional)
- [ ] Status persistente do backend/servidor
- [ ] Um único botão ligar/desligar baseado no status
- [ ] Histórico de ações executadas
- [ ] Autenticação simples
- [ ] Configuração remota de comandos
- [ ] Dockerização do backend no Raspberry
- [ ] Deploy em servidor cloud
- [ ] Notificações push

---

## 🧠 Ideias em Aberto
- [ ] Integração futura com outros dispositivos
- [ ] Execução agendada de comandos
- [ ] Templates de comandos
- [ ] Dashboard web

---

## ✅ Regra de uso do roadmap
- Trabalhar em **uma tarefa por vez**
- Marcar a tarefa concluída junto com o commit
- Ajustar o roadmap sempre que necessário
- Não transformar o roadmap em obrigação, mas em guia

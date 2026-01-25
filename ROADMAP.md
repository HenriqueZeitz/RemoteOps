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

- [X] Criar projeto Flutter
- [X] Estrutura básica do app (MaterialApp)
- [X] Tela inicial
- [X] Layout com lista de cards
- [X] Card especial “+ Adicionar comando”
- [X] Modal/tela para cadastrar novo comando
- [X] Modelo de dados do comando (nome, descrição, comando)
- [X] Persistência local (SharedPreferences / JSON)
- [X] Carregar comandos ao abrir o app
- [X] Renderizar cards dinamicamente
- [X] Long press no card abre menu de contexto
- [X] Opção de remover comando
- [X] Atualizar persistência local após remoção
- [X] Confirmar remoção com diálogo
- [X] Editar comando existente
- [X] Clique no card dispara requisição HTTP

---

## 🖥️ Fase 2 – Agent no PC
### Objetivo: executar comandos locais no computador

- [X] Criar projeto do agent
- [X] Servidor HTTP simples (ex: FastAPI ou Flask)
- [X] Endpoint para executar comandos
- [X] Pasta de comandos (.bat / scripts)
- [X] Executar script baseado no nome recebido
- [X] Retornar status de sucesso/erro
- [X] Rodar agent automaticamente ao iniciar o PC

---

## 🍓 Fase 3 – Raspberry Pi (Middleware)
### Objetivo: ponto central de controle e segurança

- [X] Instalar Raspberry Pi OS Lite
- [X] Configuração headless (SSH)
- [X] Criar backend FastAPI
- [X] Endpoint para Wake-on-LAN
- [X] Endpoint para repassar comandos ao agent do PC
- [X] Validação básica das requisições
- [X] Retornar resposta para o app mobile

---

## 🔐 Fase 4 – Conectividade e Segurança
### Objetivo: acesso remoto seguro

- [ ] Configurar WireGuard no Raspberry Pi
- [ ] Testar acesso via VPN no celular (app externo)
- [ ] Garantir que API só funcione via VPN
- [ ] Documentar configuração da VPN
- [ ] Criar um rate limit de requisições por IP

---

## ⚡ Fase 5 – Funcionalidades Essenciais
### Objetivo: tornar o sistema realmente útil

- [X] Ligar computador via Wake-on-LAN
- [X] Executar comando para iniciar backend local
- [X] Executar comando para iniciar servidor (ex: Minecraft)
- [X] Retorno visual simples (sucesso / erro)

---

## 🎨 Fase 6 – UX e Qualidade
### Objetivo: melhorar experiência de uso

- [X] Indicador visual de status no card
- [X] Botão Power fixo no rodapé
- [X] Feedback visual ao executar comandos
- [ ] Tratamento de erros de conexão
- [X] Loading states

---

## 🔄 Fase 7 – Evoluções Futuras (Opcional)
- [X] Status persistente do backend/servidor
- [X] Um único botão ligar/desligar baseado no status
- [ ] Histórico de ações executadas
- [ ] Autenticação simples
- [ ] Dockerização do backend no Raspberry
- [ ] Notificações push

---

## 🧠 Ideias em Aberto
- [ ] Integração futura com outros dispositivos
- [ ] Execução agendada de comandos
- [ ] Templates de comandos

---

## ✅ Regra de uso do roadmap
- Trabalhar em **uma tarefa por vez**
- Marcar a tarefa concluída junto com o commit
- Ajustar o roadmap sempre que necessário
- Não transformar o roadmap em obrigação, mas em guia

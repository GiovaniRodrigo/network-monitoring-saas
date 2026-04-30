# Roadmap

Roadmap do SaaS de monitoramento de rede, consolidado a partir do plano de
implementacao inicial, da documentacao em `docs/` e do estado atual do
repositorio.

## Estado Atual

O projeto ja possui a base do monorepo criada, com uma aplicacao Angular em
`apps/dashboard-web`, um Monitor de Recursos em Phoenix em
`services/resource_monitor` e quatro servicos especializados em
Node.js/TypeScript.

Entregas ja iniciadas:

- `package.json` raiz com workspaces para `apps/*` e `services/*`.
- `apps/dashboard-web` criado com Angular.
- `services/resource_monitor` criado em Phoenix.
- `ResourceMonitor.Engine.RequestSupervisor` criado com `DynamicSupervisor`.
- `ResourceMonitor.Engine.RequestHandler` criado como `GenServer` temporario
  para representar o ciclo de vida de requisicoes.
- Servicos Node.js criados:
  - `services/discovery-inventory`
  - `services/traffic-collector`
  - `services/geo-processing`
  - `services/ai-anomaly-service`
- Health check `/health` criado nos quatro servicos Node.js.

## Fontes Comparadas

- [`README.md`](./README.md): visao do produto, fluxo geral, componentes e
  funcionalidades principais.
- [`SERVICES.md`](./SERVICES.md): responsabilidades dos servicos de dominio.
- [`architecture/arquitetura-requisicao.md`](./architecture/arquitetura-requisicao.md):
  fluxo de requisicao, Monitor de Recursos, multi-tenancy e reprocessamento.
- [`adrs/adr-001-microserviço.md`](./adrs/adr-001-microserviço.md):
  decisao por microsservicos, contratos versionados, eventos e processamento
  assincrono.
- [`adrs/adr-002-angular-frontend.md`](./adrs/adr-002-angular-frontend.md):
  decisao por Angular no dashboard.
- [`adrs/adr-003-atomic-design.md`](./adrs/adr-003-atomic-design.md):
  organizacao do frontend com Atomic Design.
- [`# Implementation Plan - Initial Project .md`](./%23%20Implementation%20Plan%20-%20Initial%20Project%20.md):
  estrutura inicial em monorepo, Monitor de Recursos em Elixir/Phoenix e
  servicos especializados em Node.js/TypeScript.

## Direcao Consolidada

O projeto segue em formato de monorepo, com uma aplicacao frontend em Angular e
servicos backend separados por responsabilidade.

Estrutura atual:

```text
apps/
  dashboard-web/
services/
  resource_monitor/
  discovery-inventory/
  traffic-collector/
  geo-processing/
  ai-anomaly-service/
```

Observacao: o plano inicial usava `resource-monitor`, mas o projeto Phoenix foi
criado como `resource_monitor`. A partir daqui, o roadmap usa o nome existente
no repositorio.

Decisoes consolidadas:

- O `dashboard-web` sera desenvolvido em Angular.
- O frontend seguira Atomic Design em componentes compartilhados.
- O `resource_monitor` sera o motor central de orquestracao.
- O `resource_monitor` sera implementado em Elixir/Phoenix para favorecer
  concorrencia, supervisao e tolerancia a falhas.
- Os servicos especializados iniciais serao implementados em Node.js/TypeScript.
- A comunicacao sincrona inicial pode usar HTTP/REST.
- Eventos e filas devem ser previstos para fluxos assincronos como coleta,
  enriquecimento, alertas e IA.
- O contexto de tenant deve acompanhar requisicoes, eventos e dados persistidos.

## Pontos a Decidir

- Definir se a comunicacao interna de alto desempenho usara apenas HTTP/REST ou
  tambem gRPC.
- Definir a estrategia de persistencia por servico. A ADR 001 orienta que
  servicos nao compartilhem banco diretamente, enquanto a arquitetura atual ainda
  representa um banco central acessado por servicos internos.
- Escolher a tecnologia de mensageria ou fila para processamento assincrono.
- Definir estrategia de autenticacao entre servicos.
- Definir stack de observabilidade distribuida: logs, metricas e tracing.
- Definir contratos iniciais de API e eventos versionados.
- Definir padrao de nomes entre servicos com kebab-case e projetos Elixir com
  snake_case.

## Fase 0 - Fundacao do Repositorio

- [x] Criar estrutura base `apps/` e `services/`.
- [x] Configurar `package.json` raiz para scripts de workspace quando aplicavel.
- [ ] Definir padrao de scripts locais para build, lint, test e start.
- [ ] Documentar convencoes de nomes de servicos, portas locais e variaveis de
  ambiente.
- [ ] Criar arquivos de exemplo de ambiente por aplicacao ou servico.
- [ ] Criar guia local de execucao dos servicos em conjunto.

## Fase 1 - Monitor de Recursos

- [x] Criar `services/resource_monitor` como projeto Elixir/Phoenix.
- [x] Criar arvore de supervisao inicial.
- [x] Criar processo base para ciclo de vida de requisicoes.
- [x] Criar supervisor dinamico para requisicoes.
- [ ] Configurar health check do servico.
- [ ] Criar endpoint para iniciar uma requisicao monitorada.
- [ ] Modelar fluxo de orquestracao entre dashboard e servicos internos.
- [ ] Implementar limite explicito para reprocessamento de requisicoes.
- [ ] Propagar contexto de tenant nas operacoes coordenadas pelo monitor.
- [ ] Criar teste basico de chamada simulada para um servico interno.
- [ ] Remover codigo morto ou alinhar geracao de IDs no `RequestHandler`.

## Fase 2 - Servicos Especializados

- [x] Criar `services/discovery-inventory` em Node.js/TypeScript.
- [x] Criar `services/traffic-collector` em Node.js/TypeScript.
- [x] Criar `services/geo-processing` em Node.js/TypeScript.
- [x] Criar `services/ai-anomaly-service` em Node.js/TypeScript.
- [x] Expor health check em cada servico.
- [ ] Padronizar scripts `dev`, `build`, `test` e `start` em cada servico.
- [ ] Definir contratos HTTP iniciais para integracao com o Monitor de Recursos.
- [ ] Preparar estrutura para publicacao e consumo de eventos de dominio.
- [ ] Registrar eventos iniciais esperados:
  `device.discovered`, `traffic.collected`, `traffic.geo.enriched`,
  `anomaly.detected` e `alert.created`.

## Fase 3 - Dashboard Web

- [x] Criar `apps/dashboard-web` como aplicacao Angular.
- [ ] Configurar estrutura `core`, `shared` e `features`.
- [ ] Criar estrutura Atomic Design em `shared/ui`.
- [ ] Configurar rotas iniciais protegidas.
- [ ] Criar servicos HTTP tipados para comunicacao com o Monitor de Recursos.
- [ ] Preparar interceptors para autenticacao, erros e contexto de tenant.
- [ ] Criar shell operacional do dashboard.
- [ ] Criar telas iniciais para inventario, trafego, geolocalizacao, anomalias,
  alertas e relatorios.

## Fase 4 - Multi-Tenancy e Seguranca

- [ ] Definir modelo de tenant, usuario, papel e permissao.
- [ ] Garantir isolamento de dados por tenant nos contratos de API.
- [ ] Implementar autenticacao no dashboard.
- [ ] Implementar autorizacao por perfil e escopo.
- [ ] Propagar tenant entre dashboard, Monitor de Recursos e servicos internos.
- [ ] Definir autenticacao entre servicos.
- [ ] Validar que o dashboard nao acessa banco nem servicos internos diretamente.

## Fase 5 - Coleta, Inventario e Geolocalizacao

- [ ] Implementar descoberta inicial de dispositivos.
- [ ] Persistir inventario com IP, MAC, hostname e tenant.
- [ ] Adicionar identificacao de tipo, fabricante e sistema operacional quando
  possivel.
- [ ] Implementar coleta inicial de download, upload, pacotes por segundo,
  latencia e perda de pacotes.
- [ ] Implementar enriquecimento geografico por IP.
- [ ] Expor consultas consolidadas pelo Monitor de Recursos para o dashboard.

## Fase 6 - Anomalias, Alertas e Insights

- [ ] Criar pipeline inicial de analise de trafego.
- [ ] Detectar picos, outliers e comportamento incomum.
- [ ] Gerar eventos de alerta.
- [ ] Criar consultas para alertas e anomalias.
- [ ] Exibir alertas e insights no dashboard.
- [ ] Planejar evolucao para modelos de machine learning com historico.

## Fase 7 - Observabilidade e Operacao

- [ ] Padronizar logs estruturados.
- [ ] Adicionar metricas por servico.
- [ ] Adicionar rastreamento distribuido entre dashboard, monitor e servicos.
- [ ] Criar verificacoes de saude e prontidao.
- [ ] Documentar troubleshooting local.
- [ ] Criar testes de integracao entre Monitor de Recursos e servicos internos.

## Fase 8 - Evolucao de Produto

- [ ] Integrar SNMP.
- [ ] Suportar NetFlow/sFlow.
- [ ] Expandir relatorios operacionais.
- [ ] Adicionar acompanhamento de SLA.
- [ ] Evoluir mapas e eventos de geolocalizacao.
- [ ] Evoluir motor de IA para previsoes, recomendacoes e aprendizado historico.
- [ ] Adicionar alertas inteligentes com autoajuste.
- [ ] Criar API publica para integracoes externas.
- [ ] Implementar gestao de planos e limites de consumo por tenant.

## Proximos Marcos

1. Padronizar scripts de execucao no monorepo.
2. Adicionar health check no `resource_monitor`.
3. Criar endpoint no `resource_monitor` para iniciar requisicao monitorada.
4. Fazer o `resource_monitor` chamar pelo menos um servico Node.js.
5. Criar a estrutura `core`, `shared`, `features` e `shared/ui` no dashboard.
6. Documentar variaveis de ambiente e portas locais.

## Criterios de Validacao Inicial

- [ ] O Monitor de Recursos inicia e responde a health check.
- [x] Cada servico Node.js possui endpoint de health check.
- [ ] Cada servico Node.js inicia e responde a health check em validacao local.
- [x] O dashboard Angular possui estrutura inicial criada.
- [ ] O dashboard Angular roda localmente e exibe o shell inicial.
- [ ] O dashboard chama o Monitor de Recursos, nao os servicos internos
  diretamente.
- [ ] O Monitor de Recursos executa uma chamada simulada para
  `discovery-inventory`.
- [ ] Requisicoes carregam contexto de tenant.
- [ ] Reprocessamentos possuem limite de tentativas.
- [ ] Contratos iniciais de API e eventos estao documentados.

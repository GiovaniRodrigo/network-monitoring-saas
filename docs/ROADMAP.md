# Roadmap

Roadmap do SaaS de monitoramento de rede, consolidado a partir do plano de
implementação inicial, da documentação em `docs/` e do estado atual do
repositório.

## Estado Atual

O projeto já possui a base do monorepo criada, com uma aplicação Angular em
`apps/dashboard-web`, um Monitor de Recursos em Phoenix em
`services/resource_monitor` e quatro serviços especializados em
Node.js/TypeScript.

Entregas já iniciadas:

- `package.json` raiz com workspaces para `apps/*` e `services/*`.
- `apps/dashboard-web` criado com Angular.
- `services/resource_monitor` criado em Phoenix.
- `ResourceMonitor.Engine.RequestSupervisor` criado com `DynamicSupervisor`.
- `ResourceMonitor.Engine.RequestHandler` criado como `GenServer` temporário
  para representar o ciclo de vida de requisições.
- Serviços Node.js criados:
  - `services/discovery-inventory`
  - `services/traffic-collector`
  - `services/geo-processing`
  - `services/ai-anomaly-service`
- Health check `/health` criado nos quatro serviços Node.js.

## Fontes Comparadas

- [`README.md`](./README.md): visão do produto, fluxo geral, componentes e
  funcionalidades principais.
- [`SERVICES.md`](./SERVICES.md): responsabilidades dos serviços de domínio.
- [`architecture/arquitetura-requisicao.md`](./architecture/arquitetura-requisicao.md):
  fluxo de requisição, Monitor de Recursos, multi-tenancy e reprocessamento.
- [`adrs/adr-001-microserviço.md`](./adrs/adr-001-microserviço.md):
  decisão por microsserviços, contratos versionados, eventos e processamento
  assíncrono.
- [`adrs/adr-002-angular-frontend.md`](./adrs/adr-002-angular-frontend.md):
  decisão por Angular no dashboard.
- [`adrs/adr-003-atomic-design.md`](./adrs/adr-003-atomic-design.md):
  organização do frontend com Atomic Design.
- [`# Implementation Plan - Initial Project .md`](./%23%20Implementation%20Plan%20-%20Initial%20Project%20.md):
  estrutura inicial em monorepo, Monitor de Recursos em Elixir/Phoenix e
  serviços especializados em Node.js/TypeScript.

## Direção Consolidada

O projeto segue em formato de monorepo, com uma aplicação frontend em Angular e
serviços backend separados por responsabilidade.

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

Observação: o plano inicial usava `resource-monitor`, mas o projeto Phoenix foi
criado como `resource_monitor`. A partir daqui, o roadmap usa o nome existente
no repositório.

Decisões consolidadas:

- O `dashboard-web` será desenvolvido em Angular.
- O frontend seguirá Atomic Design em componentes compartilhados.
- O `resource_monitor` será o motor central de orquestração.
- O `resource_monitor` será implementado em Elixir/Phoenix para favorecer
  concorrência, supervisão e tolerância a falhas.
- Os serviços especializados iniciais serão implementados em Node.js/TypeScript.
- A comunicação síncrona inicial pode usar HTTP/REST.
- Eventos e filas devem ser previstos para fluxos assíncronos como coleta,
  enriquecimento, alertas e IA.
- O contexto de tenant deve acompanhar requisições, eventos e dados persistidos.

## Pontos a Decidir

- Definir se a comunicação interna de alto desempenho usará apenas HTTP/REST ou
  também gRPC.
- Definir a estratégia de persistência por serviço. A ADR 001 orienta que
  serviços não compartilhem banco diretamente, enquanto a arquitetura atual ainda
  representa um banco central acessado por serviços internos.
- Escolher a tecnologia de mensageria ou fila para processamento assíncrono.
- Definir estratégia de autenticação entre serviços.
- Definir stack de observabilidade distribuída: logs, métricas e tracing.
- Definir contratos iniciais de API e eventos versionados.
- Definir padrão de nomes entre serviços com kebab-case e projetos Elixir com
  snake_case.

## Fase 0 - Fundação do Repositório

- [x] Criar estrutura base `apps/` e `services/`.
- [x] Configurar `package.json` raiz para scripts de workspace quando aplicável.
- [ ] Definir padrão de scripts locais para build, lint, test e start.
- [ ] Documentar convenções de nomes de serviços, portas locais e variáveis de
  ambiente.
- [ ] Criar arquivos de exemplo de ambiente por aplicação ou serviço.
- [ ] Criar guia local de execução dos serviços em conjunto.

## Fase 1 - Monitor de Recursos

- [x] Criar `services/resource_monitor` como projeto Elixir/Phoenix.
- [x] Criar árvore de supervisão inicial.
- [x] Criar processo base para ciclo de vida de requisições.
- [x] Criar supervisor dinâmico para requisições.
- [ ] Configurar health check do serviço.
- [ ] Criar endpoint para iniciar uma requisição monitorada.
- [ ] Modelar fluxo de orquestração entre dashboard e serviços internos.
- [ ] Implementar limite explícito para reprocessamento de requisições.
- [ ] Propagar contexto de tenant nas operações coordenadas pelo monitor.
- [ ] Criar teste básico de chamada simulada para um serviço interno.
- [ ] Remover código morto ou alinhar geração de IDs no `RequestHandler`.

## Fase 2 - Serviços Especializados

- [x] Criar `services/discovery-inventory` em Node.js/TypeScript.
- [x] Criar `services/traffic-collector` em Node.js/TypeScript.
- [x] Criar `services/geo-processing` em Node.js/TypeScript.
- [x] Criar `services/ai-anomaly-service` em Node.js/TypeScript.
- [x] Expor health check em cada serviço.
- [ ] Padronizar scripts `dev`, `build`, `test` e `start` em cada serviço.
- [ ] Definir contratos HTTP iniciais para integração com o Monitor de Recursos.
- [ ] Preparar estrutura para publicação e consumo de eventos de domínio.
- [ ] Registrar eventos iniciais esperados:
  `device.discovered`, `traffic.collected`, `traffic.geo.enriched`,
  `anomaly.detected` e `alert.created`.

## Fase 3 - Dashboard Web

- [x] Criar `apps/dashboard-web` como aplicação Angular.
- [ ] Configurar estrutura `core`, `shared` e `features`.
- [ ] Criar estrutura Atomic Design em `shared/ui`.
- [ ] Configurar rotas iniciais protegidas.
- [ ] Criar serviços HTTP tipados para comunicação com o Monitor de Recursos.
- [ ] Preparar interceptors para autenticação, erros e contexto de tenant.
- [ ] Criar shell operacional do dashboard.
- [ ] Criar telas iniciais para inventário, tráfego, geolocalização, anomalias,
  alertas e relatórios.

## Fase 4 - Multi-Tenancy e Segurança

- [ ] Definir modelo de tenant, usuário, papel e permissão.
- [ ] Garantir isolamento de dados por tenant nos contratos de API.
- [ ] Implementar autenticação no dashboard.
- [ ] Implementar autorização por perfil e escopo.
- [ ] Propagar tenant entre dashboard, Monitor de Recursos e serviços internos.
- [ ] Definir autenticação entre serviços.
- [ ] Validar que o dashboard não acessa banco nem serviços internos diretamente.

## Fase 5 - Coleta, Inventário e Geolocalização

- [ ] Implementar descoberta inicial de dispositivos.
- [ ] Persistir inventário com IP, MAC, hostname e tenant.
- [ ] Adicionar identificação de tipo, fabricante e sistema operacional quando
  possível.
- [ ] Implementar coleta inicial de download, upload, pacotes por segundo,
  latência e perda de pacotes.
- [ ] Implementar enriquecimento geográfico por IP.
- [ ] Expor consultas consolidadas pelo Monitor de Recursos para o dashboard.

## Fase 6 - Anomalias, Alertas e Insights

- [ ] Criar pipeline inicial de análise de tráfego.
- [ ] Detectar picos, outliers e comportamento incomum.
- [ ] Gerar eventos de alerta.
- [ ] Criar consultas para alertas e anomalias.
- [ ] Exibir alertas e insights no dashboard.
- [ ] Planejar evolução para modelos de machine learning com histórico.

## Fase 7 - Observabilidade e Operação

- [ ] Padronizar logs estruturados.
- [ ] Adicionar métricas por serviço.
- [ ] Adicionar rastreamento distribuído entre dashboard, monitor e serviços.
- [ ] Criar verificações de saúde e prontidão.
- [ ] Documentar troubleshooting local.
- [ ] Criar testes de integração entre Monitor de Recursos e serviços internos.

## Fase 8 - Evolução de Produto

- [ ] Integrar SNMP.
- [ ] Suportar NetFlow/sFlow.
- [ ] Expandir relatórios operacionais.
- [ ] Adicionar acompanhamento de SLA.
- [ ] Evoluir mapas e eventos de geolocalização.
- [ ] Evoluir motor de IA para previsões, recomendações e aprendizado histórico.
- [ ] Adicionar alertas inteligentes com autoajuste.
- [ ] Criar API pública para integrações externas.
- [ ] Implementar gestão de planos e limites de consumo por tenant.

## Próximos Marcos

1. Padronizar scripts de execução no monorepo.
2. Adicionar health check no `resource_monitor`.
3. Criar endpoint no `resource_monitor` para iniciar requisição monitorada.
4. Fazer o `resource_monitor` chamar pelo menos um serviço Node.js.
5. Criar a estrutura `core`, `shared`, `features` e `shared/ui` no dashboard.
6. Documentar variáveis de ambiente e portas locais.

## Critérios de Validação Inicial

- [ ] O Monitor de Recursos inicia e responde a health check.
- [x] Cada serviço Node.js possui endpoint de health check.
- [ ] Cada serviço Node.js inicia e responde a health check em validação local.
- [x] O dashboard Angular possui estrutura inicial criada.
- [ ] O dashboard Angular roda localmente e exibe o shell inicial.
- [ ] O dashboard chama o Monitor de Recursos, não os serviços internos
  diretamente.
- [ ] O Monitor de Recursos executa uma chamada simulada para
  `discovery-inventory`.
- [ ] Requisições carregam contexto de tenant.
- [ ] Reprocessamentos possuem limite de tentativas.
- [ ] Contratos iniciais de API e eventos estão documentados.

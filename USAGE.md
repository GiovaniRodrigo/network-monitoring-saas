# Uso

Guia de uso local do Network Monitoring SaaS durante o desenvolvimento.

## Visão Geral

O projeto é composto por:

- `apps/dashboard-web`: dashboard Angular.
- `services/resource_monitor`: Monitor de Recursos em Elixir/Phoenix.
- `services/discovery-inventory`: serviço Node.js de descoberta e inventário.
- `services/traffic-collector`: serviço Node.js de coleta de tráfego.
- `services/geo-processing`: serviço Node.js de geolocalização.
- `services/ai-anomaly-service`: serviço Node.js de anomalias e insights.

Consulte [`INSTALL.md`](./INSTALL.md) antes de iniciar os serviços pela primeira
vez.

## Atalhos com Makefile

O repositório possui um `Makefile` para concentrar os comandos mais usados.

Liste os comandos disponíveis:

```bash
make help
```

Prepare o ambiente local:

```bash
make setup
```

Inicie serviços individuais:

```bash
make dev-dashboard
make dev-resource-monitor
make dev-discovery
make dev-traffic
make dev-geo
make dev-ai
```

Ou inicie todos os serviços de desenvolvimento em um terminal:

```bash
make dev-all
```

Builds e testes:

```bash
make build
make test
```

Health checks dos serviços Node.js:

```bash
make health
```

## Subir o Dashboard

Na raiz do repositório:

```bash
npm run start -w dashboard-web
```

Acesse:

```text
http://localhost:4200
```

## Subir o Monitor de Recursos

Em outro terminal:

```bash
cd services/resource_monitor
mix phx.server
```

Acesse:

```text
http://localhost:4000
```

Também é possível iniciar o servidor dentro do IEx:

```bash
cd services/resource_monitor
iex -S mix phx.server
```

## Subir os Serviços Node.js

Execute cada serviço em um terminal separado.

### Discovery Inventory

```bash
npm run dev -w discovery-inventory
```

Health check:

```bash
curl http://localhost:3001/health
```

Resposta esperada:

```json
{
  "status": "ok",
  "service": "discovery-inventory"
}
```

### Traffic Collector

```bash
npm run dev -w traffic-collector
```

Health check:

```bash
curl http://localhost:3002/health
```

Resposta esperada:

```json
{
  "status": "ok",
  "service": "traffic-collector"
}
```

### Geo Processing

```bash
npm run dev -w geo-processing
```

Health check:

```bash
curl http://localhost:3003/health
```

Resposta esperada:

```json
{
  "status": "ok",
  "service": "geo-processing"
}
```

### AI Anomaly Service

```bash
npm run dev -w ai-anomaly-service
```

Health check:

```bash
curl http://localhost:3004/health
```

Resposta esperada:

```json
{
  "status": "ok",
  "service": "ai-anomaly-service"
}
```

## Alterar Porta de um Serviço Node.js

Os serviços Node.js leem a porta pela variável `PORT`. Exemplo:

```bash
PORT=3101 npm run dev -w discovery-inventory
```

## Builds Locais

Build do dashboard:

```bash
npm run build -w dashboard-web
```

Build dos serviços Node.js:

```bash
npm run build -w discovery-inventory
npm run build -w traffic-collector
npm run build -w geo-processing
npm run build -w ai-anomaly-service
```

Compilação do Monitor de Recursos:

```bash
cd services/resource_monitor
mix compile
```

## Testes

Testes do dashboard:

```bash
npm run test -w dashboard-web
```

Testes do Monitor de Recursos:

```bash
cd services/resource_monitor
mix test
```

Os serviços Node.js ainda não possuem script `test` definido.

## Fluxo de Desenvolvimento Recomendado

1. Inicie o `resource_monitor`.
2. Inicie os serviços Node.js necessários para a funcionalidade em trabalho.
3. Inicie o `dashboard-web`.
4. Use os endpoints `/health` dos serviços Node.js para verificar se estão
   ativos.
5. Consulte [`docs/ROADMAP.md`](./docs/ROADMAP.md) para saber quais integrações
   ainda estão pendentes.

## Estado Atual da Integração

- O dashboard Angular ainda não chama o Monitor de Recursos.
- O Monitor de Recursos ainda não expõe endpoint de health check.
- O Monitor de Recursos ainda não chama os serviços Node.js.
- Os serviços Node.js já expõem `GET /health`.

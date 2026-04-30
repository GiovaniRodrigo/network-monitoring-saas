# Instalação

Guia de instalação local do Network Monitoring SaaS.

## Requisitos

Instale as ferramentas abaixo antes de preparar o projeto:

- Git.
- Node.js compatível com Angular 21.
- npm compatível com o lockfile do projeto.
- Elixir `~> 1.15`.
- Erlang/OTP compatível com a versão do Elixir instalada.
- Dependências do Phoenix via `mix`.

## Clonar o Repositório

```bash
git clone https://github.com/GiovaniRodrigo/network-monitoring-saas.git
cd network-monitoring-saas
```

Se você já estiver no diretório do projeto, pule esta etapa.

## Instalar Dependências JavaScript

Na raiz do repositório:

```bash
npm install
```

O projeto usa workspaces para:

- `apps/*`
- `services/*`

Esse comando instala as dependências do dashboard Angular e dos serviços
Node.js/TypeScript registrados no monorepo.

## Instalar Dependências do Monitor de Recursos

O Monitor de Recursos é um projeto Phoenix separado em
`services/resource_monitor`.

```bash
cd services/resource_monitor
mix setup
cd ../..
```

Esse comando baixa as dependências Elixir configuradas em `mix.exs`.

## Estrutura Esperada

A estrutura principal após a instalação deve conter:

```text
apps/
  dashboard-web/
services/
  resource_monitor/
  discovery-inventory/
  traffic-collector/
  geo-processing/
  ai-anomaly-service/
docs/
```

## Portas Locais

Portas usadas por padrão no ambiente local:

| Componente | Porta | URL |
| --- | ---: | --- |
| Dashboard Angular | 4200 | `http://localhost:4200` |
| Monitor de Recursos | 4000 | `http://localhost:4000` |
| Discovery Inventory | 3001 | `http://localhost:3001` |
| Traffic Collector | 3002 | `http://localhost:3002` |
| Geo Processing | 3003 | `http://localhost:3003` |
| AI Anomaly Service | 3004 | `http://localhost:3004` |

Nos serviços Node.js, a porta pode ser alterada com a variável `PORT`.

## Validar a Instalação

Compile os serviços Node.js:

```bash
npm run build -w discovery-inventory
npm run build -w traffic-collector
npm run build -w geo-processing
npm run build -w ai-anomaly-service
```

Compile o dashboard:

```bash
npm run build -w dashboard-web
```

Compile o Monitor de Recursos:

```bash
cd services/resource_monitor
mix compile
cd ../..
```

## Observações

- O endpoint de health check do `resource_monitor` ainda está pendente no
  roadmap.
- Os quatro serviços Node.js já possuem endpoint `GET /health`.
- O dashboard ainda está na estrutura inicial gerada pelo Angular.

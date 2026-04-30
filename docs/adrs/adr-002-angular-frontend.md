# 📄 ADR 002: Frontend com Angular

**Autor:** Giovani
**Data:** 2026-04-29
**Status:** Aceito

---

## 🧭 Contexto

O sistema terá um dashboard SaaS para monitoramento de rede, com autenticação,
autorização, escopo por cliente, visualização de dispositivos, gráficos, mapas,
alertas, relatórios e inventário visual.

A interface do produto tende a crescer em quantidade de telas, estados,
permissões, filtros, formulários e integrações com APIs dos microsserviços.
Também será necessário manter consistência visual e comportamental entre módulos
como inventário, tráfego, geolocalização, anomalias, alertas e administração da
conta.

Por isso, é necessário definir uma tecnologia de frontend que favoreça
organização, manutenção, testabilidade, componentização e evolução do dashboard
ao longo do tempo.

---

## 🔍 Alternativas Consideradas

### 1. Angular

* ✔ Vantagens:

  * Framework completo e opinativo para aplicações web grandes.
  * TypeScript como padrão, favorecendo contratos mais claros com APIs.
  * Estrutura consistente para módulos, rotas, serviços, guards e interceptors.
  * Boa base para formulários complexos, validações e dashboards administrativos.
  * Ecossistema maduro para testes, build, CLI e organização de projeto.
  * Facilita padronização entre funcionalidades do SaaS.

* ❌ Desvantagens:

  * Curva de aprendizado maior.
  * Mais estrutura inicial do que bibliotecas mais leves.
  * Pode exigir mais disciplina na separação entre componentes, serviços e estado.

---

### 2. React

* ✔ Vantagens:

  * Ecossistema amplo e flexível.
  * Grande disponibilidade de bibliotecas e profissionais.
  * Boa experiência para criação de componentes reutilizáveis.
  * Permite decisões arquiteturais mais livres.

* ❌ Desvantagens:

  * Exige mais decisões complementares sobre roteamento, formulários, estado e
    estrutura do projeto.
  * A flexibilidade pode gerar inconsistência entre módulos se não houver padrões
    bem definidos.
  * Pode aumentar o esforço de padronização em um dashboard SaaS com muitas áreas.

---

### 3. Vue

* ✔ Vantagens:

  * Boa produtividade e curva de aprendizado mais suave.
  * Componentização simples.
  * Ecossistema moderno e adequado para aplicações web.

* ❌ Desvantagens:

  * Menor aderência ao objetivo de ter um framework mais opinativo e padronizado.
  * Pode exigir decisões adicionais de arquitetura em aplicações maiores.
  * Menor alinhamento com a necessidade de estrutura rígida para o dashboard SaaS.

---

## ✅ Decisão

Adotar **Angular** como tecnologia principal para o frontend do SaaS Dashboard.

O frontend será responsável por:

* autenticação e controle de sessão;
* autorização e visibilidade de recursos por perfil de usuário;
* navegação entre módulos do dashboard;
* visualização de dispositivos e inventário;
* gráficos de banda, tráfego, latência e perda de pacotes;
* mapas e dados de geolocalização;
* alertas, anomalias e insights produzidos pelos serviços;
* relatórios e filtros operacionais;
* integração com APIs dos microsserviços.

Princípios definidos:

* a aplicação frontend deve ser organizada por domínios ou funcionalidades;
* chamadas HTTP devem ser centralizadas em serviços próprios;
* autenticação, tokens e tratamento de erros devem usar interceptors;
* rotas protegidas devem usar guards;
* componentes devem priorizar responsabilidade única;
* interfaces e tipos TypeScript devem representar contratos relevantes das APIs;
* telas operacionais devem favorecer clareza, densidade adequada e leitura rápida
  dos dados.

---

## 🧪 Exemplos de Implementação

### 📁 Estrutura Inicial

```text
apps/
  dashboard-web/
    src/
      app/
        core/
          auth/
          http/
          guards/
          interceptors/
        shared/
          components/
          pipes/
          directives/
        features/
          inventory/
          traffic/
          geolocation/
          anomalies/
          alerts/
          reports/
          account/
```

---

### ⚙️ Integração

O Angular consumirá APIs expostas pelos microsserviços por meio de serviços
HTTP tipados.

Exemplos de integrações esperadas:

```text
GET /api/devices
GET /api/traffic/metrics
GET /api/geolocation/events
GET /api/anomalies
GET /api/alerts
GET /api/reports
```

O dashboard deverá tratar autenticação, autorização, estados de carregamento,
erros de API e atualização periódica de dados de monitoramento quando necessário.

---

## 📊 Consequências

### ✔ Impactos Positivos

* Maior padronização da arquitetura frontend.
* Melhor organização para um dashboard SaaS com muitos módulos.
* Tipagem forte entre telas, serviços e contratos de API.
* Boa estrutura para rotas protegidas, interceptors e formulários complexos.
* Facilidade para manter consistência visual e comportamental ao longo do projeto.
* Ecossistema maduro para build, testes e evolução incremental.

---

### ⚠️ Trade-offs / Impactos Negativos

* Maior complexidade inicial em comparação com soluções mais leves.
* Necessidade de seguir boas práticas do Angular para evitar componentes grandes
  ou acoplados.
* Curva de aprendizado maior para pessoas sem experiência no framework.
* Exige disciplina para manter módulos, serviços e contratos bem organizados.

---

## 🔗 Relacionamentos

* Relacionado a: `docs/adrs/adr-001-microserviço`
* Relacionado a: `docs/README.md`

---

## 📝 Notas Adicionais

Esta decisão favorece uma base frontend estruturada, consistente e preparada para
um dashboard operacional de monitoramento de rede com múltiplos módulos,
integrações e regras de acesso.

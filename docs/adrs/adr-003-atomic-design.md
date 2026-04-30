# 📄 ADR 003: Frontend com Atomic Design

**Autor:** Giovani
**Data:** 2026-04-29
**Status:** Aceito

---

## 🧭 Contexto

O frontend do SaaS Dashboard será desenvolvido em Angular e terá múltiplas áreas
operacionais, como inventário, tráfego, geolocalização, anomalias, alertas,
relatórios e administração da conta.

Essas telas compartilharão muitos elementos visuais e comportamentais:
botões, campos de formulário, filtros, tabelas, cards de métrica, gráficos,
menus, modais, estados de carregamento, mensagens de erro e componentes de
layout.

Sem um padrão claro de organização de componentes, existe risco de duplicação,
inconsistência visual, componentes grandes demais e dificuldade para evoluir o
dashboard conforme novos módulos forem adicionados.

Por isso, é necessário definir uma abordagem fixa para organizar os componentes
do frontend.

---

## 🔍 Alternativas Consideradas

### 1. Atomic Design

* ✔ Vantagens:

  * Organiza componentes em níveis claros de responsabilidade.
  * Favorece reutilização e consistência visual.
  * Ajuda a separar componentes pequenos de composições maiores.
  * Facilita evolução de um design system interno.
  * Combina bem com Angular e com dashboards ricos em componentes.
  * Reduz duplicação entre módulos do SaaS.

* ❌ Desvantagens:

  * Exige disciplina para classificar componentes corretamente.
  * Pode parecer mais estruturado do que o necessário no início do projeto.
  * Requer cuidado para evitar abstrações prematuras.

---

### 2. Organização Apenas por Feature

* ✔ Vantagens:

  * Simples de iniciar.
  * Mantém componentes próximos das telas que os utilizam.
  * Pode funcionar bem para funcionalidades isoladas.

* ❌ Desvantagens:

  * Pode gerar duplicação de componentes entre features.
  * Dificulta padronização visual ao longo do tempo.
  * Componentes compartilháveis podem ficar presos dentro de módulos específicos.
  * Menor aderência à construção de um design system.

---

### 3. Organização Livre por Tipo de Arquivo

* ✔ Vantagens:

  * Fácil de entender em projetos pequenos.
  * Separação direta entre componentes, serviços, pipes e diretivas.

* ❌ Desvantagens:

  * Não expressa bem o nível de composição dos componentes.
  * Pode virar uma pasta genérica de componentes sem critério claro.
  * Escala mal para dashboards com muitas telas e variações de interface.

---

## ✅ Decisão

Adotar **Atomic Design como padrão permanente para o frontend**.

Todo frontend do projeto deverá ser organizado seguindo os níveis:

* **atoms:** componentes básicos e indivisíveis da interface;
* **molecules:** combinações pequenas de atoms com uma função específica;
* **organisms:** blocos mais completos que combinam molecules e atoms;
* **templates:** estruturas de tela e layouts reutilizáveis;
* **pages:** telas conectadas a rotas, dados e fluxos da aplicação.

Essa decisão vale para o frontend atual e para futuras aplicações frontend do
projeto, salvo nova ADR que substitua explicitamente esta decisão.

Princípios definidos:

* componentes compartilhados devem seguir Atomic Design;
* componentes específicos de uma feature podem ficar dentro da própria feature
  quando não forem reutilizáveis;
* componentes promovidos para reutilização devem ir para a camada adequada em
  `shared/ui`;
* atoms não devem depender de regras de negócio;
* molecules devem ter responsabilidade visual ou interativa bem delimitada;
* organisms podem coordenar componentes menores, mas não devem concentrar lógica
  pesada de domínio;
* pages podem integrar serviços, rotas, permissões, estados e dados da aplicação;
* a estrutura deve favorecer consistência, testabilidade e evolução incremental.

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
          ui/
            atoms/
              button/
              input/
              badge/
              icon/
            molecules/
              search-field/
              metric-card/
              status-filter/
              form-field/
            organisms/
              data-table/
              chart-panel/
              alert-list/
              device-summary/
            templates/
              dashboard-shell/
              list-page-layout/
              detail-page-layout/
        features/
          inventory/
            pages/
            components/
          traffic/
            pages/
            components/
          geolocation/
            pages/
            components/
          anomalies/
            pages/
            components/
          alerts/
            pages/
            components/
          reports/
            pages/
            components/
          account/
            pages/
            components/
```

---

### 🧩 Classificação de Componentes

Exemplos esperados:

```text
atoms:
  app-button
  app-input
  app-badge
  app-spinner

molecules:
  app-search-field
  app-date-range-filter
  app-metric-card
  app-status-filter

organisms:
  app-device-table
  app-traffic-chart-panel
  app-alert-timeline
  app-map-events-panel

templates:
  app-dashboard-shell
  app-list-page-layout
  app-detail-page-layout

pages:
  inventory-page
  traffic-overview-page
  alerts-page
  reports-page
```

---

## 📊 Consequências

### ✔ Impactos Positivos

* Maior consistência visual entre módulos do SaaS Dashboard.
* Melhor reutilização de componentes comuns.
* Menor duplicação de elementos de interface.
* Base mais clara para criação de um design system interno.
* Organização mais previsível para novas telas e funcionalidades.
* Facilita testes isolados de componentes pequenos.
* Ajuda a manter responsabilidade única nos componentes Angular.

---

### ⚠️ Trade-offs / Impactos Negativos

* Exige disciplina para manter a classificação correta dos componentes.
* Pode adicionar estrutura inicial antes de todos os níveis serem necessários.
* Requer revisão periódica para promover ou rebaixar componentes conforme o uso.
* Componentes muito específicos não devem ser forçados para `shared/ui`.

---

## 🔗 Relacionamentos

* Relacionado a: `docs/adrs/adr-002-angular-frontend.md`
* Relacionado a: `docs/README.md`

---

## 📝 Notas Adicionais

Atomic Design será o padrão base para manter o frontend do SaaS consistente,
componentizado e preparado para crescer com múltiplos módulos operacionais.

# 📄 ADR 001: Arquitetura baseada em microsserviços

**Autor:** Giovani
**Data:** 2026-04-29
**Status:** Aceito

---

## 🧭 Contexto

O sistema será um SaaS de monitoramento de rede, com coleta contínua de dados,
análise de tráfego, enriquecimento por geolocalização, detecção de padrões por IA
e visualização em dashboard.

As principais capacidades do produto possuem características diferentes:

* descoberta de dispositivos exige varredura e atualização de inventário;
* coleta de tráfego exige alta frequência de escrita e processamento contínuo;
* geolocalização atua como enriquecimento dos dados coletados;
* IA depende de dados históricos e processamento assíncrono;
* dashboard SaaS exige isolamento por cliente, autenticação, relatórios e UX.

Como o domínio tende a crescer em volume de dados, número de clientes e tipos de
processamento, é necessário definir uma arquitetura que permita escala
independente, evolução incremental e separação clara de responsabilidades.

---

## 🔍 Alternativas Consideradas

### 1. Monólito modular

* ✔ Vantagens:

  * Menor complexidade operacional no início do projeto.
  * Desenvolvimento inicial mais simples.
  * Menor esforço para integração entre módulos.
  * Deploy mais direto.

* ❌ Desvantagens:

  * Dificulta a escala independente de coleta, IA e dashboard.
  * Pode aumentar o acoplamento entre domínios do sistema.
  * Pode tornar o processamento assíncrono mais complexo conforme o volume crescer.
  * Exige mais cuidado para preservar limites claros entre módulos.

---

### 2. Microsserviços

* ✔ Vantagens:

  * Permite escalar separadamente os serviços de maior carga.
  * Facilita a evolução independente dos domínios.
  * Melhora o isolamento de falhas.
  * Favorece comunicação assíncrona para tarefas pesadas.
  * Permite escolher tecnologias específicas por serviço quando necessário.

* ❌ Desvantagens:

  * Aumenta a complexidade operacional.
  * Exige observabilidade distribuída.
  * Exige contratos bem definidos entre serviços.
  * Pode gerar inconsistência eventual entre dados.
  * Aumenta o esforço de testes de integração.

---

## ✅ Decisão

Adotar uma arquitetura baseada em microsserviços para separar as principais
responsabilidades do sistema de monitoramento de rede.

Os serviços iniciais serão:

* **Serviço de Descoberta de Dispositivos e Inventário**

  * Descobrir dispositivos na rede.
  * Identificar IP, MAC, hostname, tipo, fabricante e sistema operacional.
  * Mapear portas, serviços e protocolos.
  * Manter o inventário atualizado.

* **Serviço de Coleta de Tráfego**

  * Medir download, upload, pacotes por segundo, latência e perda de pacotes.
  * Identificar fluxos ativos.
  * Registrar dados brutos de comportamento da rede.

* **Serviço de Processamento de Geolocalização**

  * Resolver localização por IP.
  * Associar tráfego a regiões.
  * Classificar origem e destino.
  * Enriquecer dados coletados.

* **Serviço de IA para Padrões e Anomalias**

  * Detectar padrões de uso.
  * Identificar anomalias, outliers e picos anormais.
  * Classificar comportamento de dispositivos.
  * Aprender com histórico e gerar insights automáticos.
  * Produzir alertas, classificações, previsões e recomendações.

* **SaaS Dashboard**

  * Expor a interface do cliente.
  * Visualizar dispositivos, gráficos de banda, tráfego, latência e perda.
  * Exibir mapas, alertas, relatórios e inventário visual.
  * Gerenciar autenticação, autorização e escopo por cliente.

Princípios definidos:

* cada serviço deve ter uma responsabilidade bem definida;
* serviços não devem compartilhar banco de dados diretamente;
* contratos de API e eventos devem ser versionados;
* logs, métricas e rastreamento devem ser planejados desde o início;
* falhas de comunicação entre serviços devem ser tratadas explicitamente;
* tarefas pesadas devem usar processamento assíncrono quando possível.

---

## 🧪 Exemplos de Implementação

### 📁 Estrutura

```text
services/
  discovery-inventory/
  traffic-collector/
  geo-processing/
  ai-anomaly-service/
  saas-dashboard/
```

---

### ⚙️ Integração

A comunicação entre serviços será definida por dois tipos principais:

* **Síncrona**, via API HTTP/REST, para consultas operacionais e integração com o
  dashboard.
* **Assíncrona**, via mensageria ou fila, para eventos de coleta, alertas,
  processamento de IA e enriquecimento de dados.

Eventos importantes do domínio devem ser publicados para evitar acoplamento direto
entre serviços:

```text
device.discovered
traffic.collected
traffic.geo.enriched
anomaly.detected
alert.created
```

Cada microsserviço deve ser responsável por seus próprios dados. Quando um serviço
precisar de dados de outro contexto, deverá consumir uma API ou reagir a eventos
publicados.

---

## 📊 Consequências

### ✔ Impactos Positivos

* Escala independente dos componentes mais exigidos, como coleta de tráfego e IA.
* Separação clara de responsabilidades.
* Menor acoplamento entre domínios do sistema.
* Facilidade para evoluir tecnologias específicas por serviço.
* Melhor isolamento de falhas.
* Possibilidade de processamento assíncrono para tarefas pesadas.

---

### ⚠️ Trade-offs / Impactos Negativos

* Maior complexidade operacional.
* Necessidade de observabilidade distribuída.
* Mais cuidado com autenticação entre serviços.
* Possibilidade de inconsistência eventual entre dados.
* Maior esforço para testes de integração.
* Necessidade de versionamento de APIs e contratos de eventos.

---

## 🔗 Relacionamentos

* Relacionado a: `docs/README.md`

---

## 📝 Notas Adicionais

Esta decisão favorece escalabilidade, evolução incremental e separação de
responsabilidades em um produto de monitoramento de rede com alto volume de dados.

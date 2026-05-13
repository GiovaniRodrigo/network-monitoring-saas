# Design System - Network Monitoring SaaS

## 1. Visão Geral

Este Design System foi desenvolvido especificamente para aplicações SaaS de monitoramento de redes e infraestrutura. O foco principal é a **clareza de dados**, **feedback em tempo real** e **escalabilidade**.

---

## 2. Princípios de Design

1.  **Clareza acima de estética**: A interpretabilidade dos dados é a prioridade máxima.
2.  **Dados Primeiro**: Interface otimizada para alta densidade de informação sem sobrecarga cognitiva.
3.  **Feedback Imediato**: Mudanças de status devem ser comunicadas visualmente de forma instantânea.
4.  **Escalabilidade Modular**: Componentes devem ser reutilizáveis e fáceis de estender.
5.  **Acessibilidade**: Garantir contraste adequado e suporte a múltiplos modos de visualização.

---

## 3. Design Tokens

Os tokens são a base visual do nosso sistema, definidos através de variáveis CSS.

### 3.1. Cores de Status (Light Mode)

| Token | Cor | Exemplo | Uso |
| :--- | :--- | :--- | :--- |
| `--status-online` | `#10b981` | 🟢 | Sistema operando normalmente |
| `--status-warning` | `#f59e0b` | 🟡 | Atenção necessária (threshold atingido) |
| `--status-critical` | `#ef4444` | 🔴 | Falha crítica ou interrupção |
| `--status-offline` | `#6b7280` | ⚪ | Dispositivo inativo ou inacessível |

### 3.2. Métricas de Performance

| Token | Valor | Uso |
| :--- | :--- | :--- |
| `--metric-excellent` | `#10b981` | Performance > 90% |
| `--metric-good` | `#22c55e` | Performance 70-90% |
| `--metric-moderate` | `#f59e0b` | Performance 50-70% |
| `--metric-poor` | `#ef4444` | Performance < 50% |

### 3.3. Visualização de Dados

| Token | Cor | Aplicação |
| :--- | :--- | :--- |
| `--bandwidth-upload` | `#3b82f6` | Tráfego de saída (Azul) |
| `--bandwidth-download` | `#8b5cf6` | Tráfego de entrada (Roxo) |
| `--latency` | `#ec4899` | Latência/Ping (Rosa) |
| `--packet-loss` | `#ef4444` | Perda de pacotes (Vermelho) |

### 3.4. Tipografia

- **Fonte Principal**: Inter (ou similar sem-serifa)
- **Tamanhos**:
    - `h1`: 24px (Semi-bold)
    - `h2`: 20px (Medium)
    - `p`: 16px (Regular)
    - `small`: 14px (Regular)

---

## 4. Componentes Principais

### 4.1. StatusIndicator
Indicador visual minimalista para estado de dispositivos.

```tsx
<StatusIndicator status="online" label="Ativo" />
```

### 4.2. MetricCard
Card informativo com valor principal, unidade e tendência.

```tsx
<MetricCard
  label="Latência Média"
  value={23}
  unit="ms"
  status="good"
  trend="down"
/>
```

### 4.3. DeviceCard
Visualização detalhada de um ativo de rede.

```tsx
<DeviceCard
  name="Switch Core 01"
  ipAddress="10.0.0.1"
  status="online"
  bandwidth="850 Mbps"
/>
```

### 4.4. NetworkTopology
Visualização de grafo para entender conexões físicas e lógicas.

---

## 5. Variações de Tema

### 5.1. Light Mode (Padrão)
Ideal para uso administrativo em ambientes bem iluminados. Foco em contraste clássico.

### 5.2. Dark Mode / NOC Theme
Otimizado para centros de operações (NOC). Fundo escuro (`oklch(0.145 0 0)`) para reduzir fadiga visual e cores vibrantes para status críticos.

### 5.3. Densidade (Compact vs Comfortable)
- **Compact**: Reduz o espaçamento em 25% para visualização de grandes inventários.
- **Comfortable**: Espaçamento padrão para dashboards executivos.

---

## 6. Padrões de Uso (Usage Patterns)

### 6.1. Hierarquia de Alertas
Alertas críticos devem SEMPRE ocupar o topo da página (`AlertBanner`) e podem incluir animações sutis de "pulse" para chamar a atenção imediata.

### 6.2. Grids de Dashboard
- **Desktop**: Grid de 4 colunas para métricas rápidas.
- **Mobile**: Lista vertical (Single column).

### 6.3. Estados de Dados
Todos os componentes devem tratar:
- **Loading**: Skeleton screens.
- **Empty**: Ilustrações sutis e call-to-action (ex: "Adicionar Dispositivo").
- **Error**: Mensagem clara com opção de "Retry".

---

## 7. Acessibilidade (A11y)

- **Contraste**: Mínimo de 4.5:1 para texto normal.
- **Não dependa apenas de cores**: Use ícones (Lucide React) ou labels textuais para indicar status.
- **Navegação**: Todos os elementos interativos devem ser acessíveis via teclado (`focus-ring`).

---

## 8. Stack Tecnológica

- **Framework**: React + TypeScript
- **Estilização**: Tailwind CSS 4.0
- **Componentes Base**: Radix UI / Shadcn UI
- **Ícones**: Lucide React
- **Gráficos**: Recharts

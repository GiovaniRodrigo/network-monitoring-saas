import { Component } from '@angular/core';

@Component({
  selector: 'app-root',
  templateUrl: './app.html',
  styleUrl: './app.css'
})
export class App {
  protected readonly navigationItems = [
    { label: 'Dashboard', icon: '01', active: true },
    { label: 'Inventario', icon: '02', active: false },
    { label: 'Alertas', icon: '03', active: false },
    { label: 'Trafego', icon: '04', active: false },
    { label: 'Relatorios', icon: '05', active: false },
  ];

  protected readonly metrics = [
    {
      label: 'Disponibilidade',
      value: '99.92',
      unit: '%',
      status: 'excellent',
      trend: 'up',
      progress: 96,
      description: 'SLA mensal dentro da meta operacional.',
    },
    {
      label: 'Latencia media',
      value: '23',
      unit: 'ms',
      status: 'good',
      trend: 'down',
      progress: 74,
      description: 'Queda de 6 ms nas ultimas 2 horas.',
    },
    {
      label: 'Uso de banda',
      value: '68',
      unit: '%',
      status: 'moderate',
      trend: 'up',
      progress: 68,
      description: 'Pico recorrente no backbone oeste.',
    },
    {
      label: 'Perda de pacotes',
      value: '1.8',
      unit: '%',
      status: 'poor',
      trend: 'up',
      progress: 42,
      description: 'Acima do limite em 3 dispositivos.',
    },
  ];

  protected readonly topologyNodes = [
    { name: 'Core 01', ip: '10.0.0.1', status: 'online', x: 44, y: 42 },
    { name: 'WAN A', ip: '172.16.0.8', status: 'warning', x: 12, y: 18 },
    { name: 'Edge 03', ip: '172.16.0.21', status: 'critical', x: 75, y: 22 },
    { name: 'Access 14', ip: '10.0.4.14', status: 'online', x: 18, y: 72 },
    { name: 'DC Rack 2', ip: '10.0.8.2', status: 'online', x: 68, y: 72 },
  ];

  protected readonly alerts = [
    { title: 'Perda de pacotes elevada', source: 'Edge Router 03', time: 'ha 2 min', severity: 'critical', count: 4 },
    { title: 'CPU acima de 85%', source: 'Firewall HA 01', time: 'ha 9 min', severity: 'warning', count: 2 },
    { title: 'Janela de manutencao', source: 'Switch Access 14', time: 'ha 21 min', severity: 'info', count: 1 },
    { title: 'Dispositivo restaurado', source: 'AP Bloco B', time: 'ha 34 min', severity: 'online', count: 1 },
  ];

  protected readonly devices = [
    {
      name: 'Switch Core 01',
      ipAddress: '10.0.0.1',
      status: 'online',
      statusLabel: 'Online',
      bandwidth: '850 Mbps',
      latency: '8 ms',
      uptime: '99.99%',
    },
    {
      name: 'Edge Router 03',
      ipAddress: '172.16.0.21',
      status: 'critical',
      statusLabel: 'Critico',
      bandwidth: '410 Mbps',
      latency: '122 ms',
      uptime: '91.42%',
    },
    {
      name: 'Firewall HA 01',
      ipAddress: '10.0.2.5',
      status: 'warning',
      statusLabel: 'Atencao',
      bandwidth: '620 Mbps',
      latency: '34 ms',
      uptime: '98.10%',
    },
    {
      name: 'Switch Access 14',
      ipAddress: '10.0.4.14',
      status: 'online',
      statusLabel: 'Online',
      bandwidth: '210 Mbps',
      latency: '12 ms',
      uptime: '99.82%',
    },
    {
      name: 'AP Bloco B',
      ipAddress: '10.0.7.33',
      status: 'offline',
      statusLabel: 'Offline',
      bandwidth: '0 Mbps',
      latency: '--',
      uptime: '87.04%',
    },
  ];
}

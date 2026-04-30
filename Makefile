.DEFAULT_GOAL := help

SHELL := /bin/bash

NPM ?= npm
MIX ?= mix
CURL ?= curl

RESOURCE_MONITOR_DIR := services/resource_monitor

DISCOVERY_PORT ?= 3001
TRAFFIC_PORT ?= 3002
GEO_PORT ?= 3003
AI_PORT ?= 3004

.PHONY: help install install-js install-resource-monitor setup \
	dev-dashboard dev-resource-monitor iex-resource-monitor \
	dev-discovery dev-traffic dev-geo dev-ai dev-node dev-all \
	build build-dashboard build-node build-discovery build-traffic build-geo build-ai build-resource-monitor \
	test test-dashboard test-resource-monitor \
	health health-discovery health-traffic health-geo health-ai \
	clean-node

help: ## Mostra esta ajuda
	@awk 'BEGIN {FS = ":.*##"; printf "\nComandos disponiveis:\n"} /^[a-zA-Z0-9_-]+:.*##/ {printf "  \033[36m%-24s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)
	@printf "\nExemplos:\n"
	@printf "  make setup\n"
	@printf "  make dev-dashboard\n"
	@printf "  make dev-all\n"
	@printf "  make health\n\n"

install: setup ## Instala todas as dependencias

setup: install-js install-resource-monitor ## Prepara o projeto para uso local

install-js: ## Instala dependencias JavaScript dos workspaces
	$(NPM) install

install-resource-monitor: ## Instala dependencias Elixir/Phoenix
	cd $(RESOURCE_MONITOR_DIR) && $(MIX) setup

dev-dashboard: ## Inicia o dashboard Angular em http://localhost:4200
	$(NPM) run start -w dashboard-web

dev-resource-monitor: ## Inicia o Monitor de Recursos em http://localhost:4000
	cd $(RESOURCE_MONITOR_DIR) && $(MIX) phx.server

iex-resource-monitor: ## Inicia o Monitor de Recursos dentro do IEx
	cd $(RESOURCE_MONITOR_DIR) && iex -S $(MIX) phx.server

dev-discovery: ## Inicia o Discovery Inventory
	PORT=$(DISCOVERY_PORT) $(NPM) run dev -w discovery-inventory

dev-traffic: ## Inicia o Traffic Collector
	PORT=$(TRAFFIC_PORT) $(NPM) run dev -w traffic-collector

dev-geo: ## Inicia o Geo Processing
	PORT=$(GEO_PORT) $(NPM) run dev -w geo-processing

dev-ai: ## Inicia o AI Anomaly Service
	PORT=$(AI_PORT) $(NPM) run dev -w ai-anomaly-service

dev-node: ## Inicia todos os servicos Node.js em paralelo
	@set -e; \
	pids=""; \
	trap 'for pid in $$pids; do kill "$$pid" 2>/dev/null || true; done; wait' INT TERM EXIT; \
	PORT=$(DISCOVERY_PORT) $(NPM) run dev -w discovery-inventory & pids="$$pids $$!"; \
	PORT=$(TRAFFIC_PORT) $(NPM) run dev -w traffic-collector & pids="$$pids $$!"; \
	PORT=$(GEO_PORT) $(NPM) run dev -w geo-processing & pids="$$pids $$!"; \
	PORT=$(AI_PORT) $(NPM) run dev -w ai-anomaly-service & pids="$$pids $$!"; \
	wait

dev-all: ## Inicia dashboard, Monitor de Recursos e servicos Node.js
	@set -e; \
	pids=""; \
	trap 'for pid in $$pids; do kill "$$pid" 2>/dev/null || true; done; wait' INT TERM EXIT; \
	$(NPM) run start -w dashboard-web & pids="$$pids $$!"; \
	(cd $(RESOURCE_MONITOR_DIR) && $(MIX) phx.server) & pids="$$pids $$!"; \
	PORT=$(DISCOVERY_PORT) $(NPM) run dev -w discovery-inventory & pids="$$pids $$!"; \
	PORT=$(TRAFFIC_PORT) $(NPM) run dev -w traffic-collector & pids="$$pids $$!"; \
	PORT=$(GEO_PORT) $(NPM) run dev -w geo-processing & pids="$$pids $$!"; \
	PORT=$(AI_PORT) $(NPM) run dev -w ai-anomaly-service & pids="$$pids $$!"; \
	wait

build: build-dashboard build-node build-resource-monitor ## Compila tudo que possui build

build-dashboard: ## Compila o dashboard Angular
	$(NPM) run build -w dashboard-web

build-node: build-discovery build-traffic build-geo build-ai ## Compila todos os servicos Node.js

build-discovery: ## Compila o Discovery Inventory
	$(NPM) run build -w discovery-inventory

build-traffic: ## Compila o Traffic Collector
	$(NPM) run build -w traffic-collector

build-geo: ## Compila o Geo Processing
	$(NPM) run build -w geo-processing

build-ai: ## Compila o AI Anomaly Service
	$(NPM) run build -w ai-anomaly-service

build-resource-monitor: ## Compila o Monitor de Recursos
	cd $(RESOURCE_MONITOR_DIR) && $(MIX) compile

test: test-dashboard test-resource-monitor ## Executa os testes disponiveis

test-dashboard: ## Executa os testes do dashboard
	$(NPM) run test -w dashboard-web

test-resource-monitor: ## Executa os testes do Monitor de Recursos
	cd $(RESOURCE_MONITOR_DIR) && $(MIX) test

health: health-discovery health-traffic health-geo health-ai ## Verifica health checks dos servicos Node.js

health-discovery: ## Health check do Discovery Inventory
	$(CURL) --fail http://localhost:$(DISCOVERY_PORT)/health

health-traffic: ## Health check do Traffic Collector
	$(CURL) --fail http://localhost:$(TRAFFIC_PORT)/health

health-geo: ## Health check do Geo Processing
	$(CURL) --fail http://localhost:$(GEO_PORT)/health

health-ai: ## Health check do AI Anomaly Service
	$(CURL) --fail http://localhost:$(AI_PORT)/health

clean-node: ## Remove artefatos dist dos workspaces Node.js
	rm -rf apps/dashboard-web/dist services/discovery-inventory/dist services/traffic-collector/dist services/geo-processing/dist services/ai-anomaly-service/dist

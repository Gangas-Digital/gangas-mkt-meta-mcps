# Gangas MKT Meta MCPs

Instalador e catálogo dos MCPs Meta da Gangas Digital para Meta Ads e Meta Social.

O repositório não guarda tokens, IDs de contas, ficheiros `.env` nem dados de clientes. Cada colega autentica o seu próprio ambiente.

## Instalação

```bash
git clone https://github.com/gangas-digital/gangas-mkt-meta-mcps.git
cd gangas-mkt-meta-mcps
./install.sh --source-root /caminho/para/Documents/Codex/mcps/Outras-Integracoes
```

O instalador gera `~/.config/gangas-mkt-meta-mcps/installation.json` e um template de configuração MCP. O modo de leitura deve permanecer ativo por omissão. Alterações de campanhas, orçamento, anúncios ou publicações exigem confirmação explícita.

## Serviços

- Meta Ads: campanhas, conjuntos, anúncios e métricas, conforme o MCP instalado.
- Meta Social: páginas, publicações e informação social, conforme as permissões.

## Próximas fases

1. Integrar os repositórios GitHub dos MCPs como submódulos ou pacotes versionados.
2. Instalar automaticamente ambientes Python e dependências.
3. Gerar configurações para Codex, Claude, Cursor e Windsurf.
4. Adicionar health checks e testes read-only.

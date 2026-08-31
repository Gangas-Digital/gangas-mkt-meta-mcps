#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SOURCE_ROOT=""
SERVICES="meta_ads,meta_social"
OUT_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/gangas-mkt-meta-mcps"
usage() { echo "Uso: ./install.sh --source-root PASTA_OUTRAS_INTEGRACOES [--services LISTA] [--out PASTA]"; }
while [[ $# -gt 0 ]]; do
  case "$1" in
    --source-root) SOURCE_ROOT="$2"; shift 2;;
    --services) SERVICES="$2"; shift 2;;
    --out) OUT_DIR="$2"; shift 2;;
    --help|-h) usage; exit 0;;
    *) echo "Opção desconhecida: $1" >&2; exit 2;;
  esac
done
[[ -n "$SOURCE_ROOT" && -d "$SOURCE_ROOT" ]] || { usage >&2; exit 1; }
mkdir -p "$OUT_DIR"
python3 - "$ROOT/manifest/services.json" "$SOURCE_ROOT" "$OUT_DIR" "$SERVICES" <<'PY'
import json, pathlib, sys
m=json.loads(pathlib.Path(sys.argv[1]).read_text()); source=pathlib.Path(sys.argv[2]).expanduser().resolve(); out=pathlib.Path(sys.argv[3]).expanduser().resolve()
items=[]
for key in sys.argv[4].split(','):
    if key not in m['services']: raise SystemExit(f'Serviço não catalogado: {key}')
    meta=m['services'][key]; path=source/meta['directory']; items.append({'id':key,'label':meta['label'],'source':str(path),'exists':path.exists()})
(out/'installation.json').write_text(json.dumps({'services':items},indent=2,ensure_ascii=False)+'\n')
print(f'Configuração criada em {out}/installation.json')
for x in items: print(f"- {x['label']}: {'encontrado' if x['exists'] else 'não encontrado'}")
PY
cp "$ROOT/templates/mcp-config.example.json" "$OUT_DIR/mcp-config.json"
echo "Instalação concluída. Revê $OUT_DIR/mcp-config.json antes de ligar o agente."

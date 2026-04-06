#!/usr/bin/env zsh
set -euo pipefail

CP=".:/Users/lassejenssen/lib/saxon/saxon-he-12.4.jar:/Users/lassejenssen/lib/saxon/saxon-he-xqj-12.4.jar:/Users/lassejenssen/lib/saxon/xmlresolver-5.2.2.jar"
DEFAULT_XQ="personer.xqy"

# Resolve XQuery file
if [[ $# -gt 0 && -n "${1:-}" ]]; then
  XQ_FILE="$1"
  if [[ ! -f "$XQ_FILE" ]]; then
    echo "Error: XQuery file not found: $XQ_FILE" >&2
    echo "Usage: $0 [path/to/query.xqy]" >&2
    exit 1
  fi
else
  XQ_FILE="$DEFAULT_XQ"
  if [[ ! -f "$XQ_FILE" ]]; then
    echo "Error: default XQuery file not found: $XQ_FILE" >&2
    echo "Provide a query file as argument: $0 path/to/query.xqy" >&2
    exit 1
  fi
fi

# Run
exec java -cp "$CP" XQueryTester.java "$XQ_FILE"

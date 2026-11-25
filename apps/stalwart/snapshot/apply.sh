#!/usr/bin/env bash
set -e

export STALWART_URL=https://mail.mikucat.me

list=(
  AllowedIp
  Application
  Certificate
  DnsServer
  Http
  NetworkListener
  Tracer
  Domain # DnsServer
  SystemSettings # Domain
)

trap 'rm -f snapshot.ndjson' EXIT
for type in "${list[@]}"; do
  jq -c '.' $type.json >> snapshot.ndjson
done
stalwart-cli -k apply --file snapshot.ndjson

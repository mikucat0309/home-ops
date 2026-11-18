#!/usr/bin/env bash
set -e

list=(
  AllowedIp
  Application
  Certificate
  DnsServer
  NetworkListener
  Tracer
  Domain # DnsServer
  SystemSettings # Domain
)

trap 'rm -f snapshot.ndjson' EXIT
for type in "${list[@]}"; do
  jq -c '.' snapshot/$type.json >> snapshot.ndjson
done
stalwart-cli -k apply --file snapshot.ndjson

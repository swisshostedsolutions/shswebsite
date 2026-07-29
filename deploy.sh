#!/bin/bash
set -euo pipefail

# ==============================================================================
# shs-web Deployment Script
# Synchronisiert das lokale Verzeichnis mit der Webserver-VM (192.168.1.20)
#
# Voraussetzung serverseitig: /srv/web/html gehört shsadmin (IaC-Rolle
# shs-web, seit 2026-07-26) — kein root, kein sudo nötig.
# ==============================================================================

# Immer vom Projektverzeichnis aus arbeiten (wichtig wegen "./" und --delete)
cd "$(dirname "$0")"

# rsync muss lokal installiert sein, sonst wird nichts übertragen
if ! command -v rsync >/dev/null 2>&1; then
    echo "❌ rsync ist nicht installiert. Bitte zuerst: sudo apt install rsync" >&2
    exit 1
fi

REMOTE_USER="shsadmin"
REMOTE_HOST="192.168.1.20"
REMOTE_PATH="/srv/web/html/"

echo "🚀 Starte Deployment auf $REMOTE_HOST..."

# -a: Archiv-Modus | -v: Verbose | -z: Kompression
# --delete: entfernt auf dem Server, was lokal nicht mehr existiert
# --chmod=D755,F644: Verzeichnisse 755, Dateien 644 — genau die Rechte,
#   die der nginx-Container (read-only-Mount) braucht; ersetzt den
#   früheren chown/chmod-Block per SSH
# --filter/--exclude: .gitignore respektieren; Repo-Interna (.git,
#   dieses Script, README, Caddyfile.example) landen nicht im Webroot
rsync -avz --delete \
    --chmod=D755,F644 \
    --filter=":- .gitignore" \
    --exclude=".git/" \
    --exclude="deploy.sh" \
    --exclude="README.md" \
    ./ ${REMOTE_USER}@${REMOTE_HOST}:${REMOTE_PATH}

echo "✅ Deployment erfolgreich abgeschlossen!"
